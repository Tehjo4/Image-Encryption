 clc; clear all; close all;

% Select input and output folders
inputFolder = uigetdir(pwd, "D:\MINI_PROJECT\original_img");
outputFolder = uigetdir(pwd, "D:\MINI_PROJECT\encrypted _img");

% Load the confusion map (Bernoulli map)
I = readmatrix("confusion_1.xlsx");
I = I';

% Loading the keys from the Excel files
clhenon_x = readmatrix("clheon_x_uint8.xlsx");
clhenon_y = readmatrix("clheon_y_uint8.xlsx");

% Reshaping keys into 256x256 arrays
x_keys_2d = reshape(clhenon_x, [256, 256]);
y_keys_2d = reshape(clhenon_y, [256, 256]);

% Get list of all .tiff files
tiffFiles = dir(fullfile(inputFolder, '*.tiff'));

for k = 1:length(tiffFiles)
    % Full path of current input image
    inputImagePath = fullfile(inputFolder, tiffFiles(k).name);
    
    % Load the RGB image
    RGBimg = imread(inputImagePath);
    [R, G, B] = imsplit(RGBimg);

    % Reshape the image channels into 1x65536 arrays
    R = reshape(R, [1, 65536]);
    G = reshape(G, [1, 65536]);
    B = reshape(B, [1, 65536]);

    % Apply confusion to each channel
    Rc = R(I);
    Gc = G(I);
    Bc = B(I);

    % Reshape back to 256x256
    Rc = reshape(Rc, [256, 256]);
    Gc = reshape(Gc, [256, 256]);
    Bc = reshape(Bc, [256, 256]);

    % Combining confused channels into an RGB image
    confusedImage = cat(3, Rc, Gc, Bc);

    % Separating RGB channels
    [red_channel, green_channel, blue_channel] = imsplit(confusedImage);

    % Row-wise diffusion
    tic;
    for i = 1:256
        red_row = red_channel(i, :);
        green_row = green_channel(i, :);
        blue_row = blue_channel(i, :);
        x_keys_row = x_keys_2d(i, :);

        red_channel(i, :) = DNAatgc_encrypt(red_row, x_keys_row);
        green_channel(i, :) = DNAatgc_encrypt(green_row, x_keys_row);
        blue_channel(i, :) = DNAatgc_encrypt(blue_row, x_keys_row);
    end
    toc;

    % Column-wise diffusion
    tic;
    for j = 1:256
        red_col = red_channel(:, j);
        green_col = green_channel(:, j);
        blue_col = blue_channel(:, j);
        y_keys_col = y_keys_2d(:, j);

        red_channel(:, j) = DNAatgc_encrypt(red_col, y_keys_col);
        green_channel(:, j) = DNAatgc_encrypt(green_col, y_keys_col);
        blue_channel(:, j) = DNAatgc_encrypt(blue_col, y_keys_col);
    end
    toc;

    % Combine channels 
    diffused_image = cat(3, red_channel, green_channel, blue_channel);
    diffused_image = uint8(diffused_image);

    % Save encrypted image to output folder
    outputImagePath = fullfile(outputFolder, tiffFiles(k).name);
    imwrite(diffused_image, outputImagePath);

    fprintf('Encrypted and saved: %s\n', outputImagePath);
end

disp('All images encrypted and saved!');
