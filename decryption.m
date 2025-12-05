% decryption
clc; clear all; close all;

% Load the RGB image
diffusedImage = imread("D:\MINI_PROJECT\encrypted_img\img (21).tiff");
%size(diffusedImage)
%figure
%imshow(diffusedImage);


% Separating RGB channels
[red_channel, green_channel, blue_channel] = imsplit(diffusedImage);


% Loading the keys from the Excel files
clhenon_x = readmatrix("clheon_x_uint8.xlsx");
clhenon_y = readmatrix("clheon_y_uint8.xlsx");

% Reshaping keys into 256x256 arrays
x_keys_2d = reshape(clhenon_x, [256, 256]);
y_keys_2d = reshape(clhenon_y, [256, 256]);


% column-wise diffusion
for j = 1:256
    % Extracting the column
    red_col = red_channel(:, j);
    green_col = green_channel(:, j);
    blue_col = blue_channel(:, j);

    % Extracting the corresponding column of keys
    y_keys_col = y_keys_2d(:, j);

    % Performing DNA addition for the column
    red_channel(:, j) = DNAatgc_decrypt(red_col, y_keys_col);
    green_channel(:, j) = DNAatgc_decrypt(green_col, y_keys_col);
    blue_channel(:, j) = DNAatgc_decrypt(blue_col, y_keys_col);
end

% row-wise diffusion
for i = 1:256
    % Extracting the row
    red_row = red_channel(i, :);
    % size(red_row)
    green_row = green_channel(i, :);
    blue_row = blue_channel(i, :);

    % Extracting the corresponding row of keys
    x_keys_row = x_keys_2d(i, :);

    % Performing DNA addition for the row
    red_channel(i, :) = DNAatgc_decrypt(red_row, x_keys_row);
    green_channel(i, :) = DNAatgc_decrypt(green_row, x_keys_row);
    blue_channel(i, :) = DNAatgc_decrypt(blue_row, x_keys_row);
end
%Combinig channels 
diffused_image_decrypt = cat(3, red_channel, green_channel, blue_channel);
diffused_image_decrypt = uint8(diffused_image_decrypt);

% % Display of the diffused image
% figure;
% imshow(diffused_image_decrypt,[], 'Border', 'tight');
% title('decrypted Diffused Image');


%confusion
%diffused_image_encrypt = imread("clgmatlab\1_stage\decrypt_diffusion.tif");
[R, G, B] = imsplit(diffused_image_decrypt );
R = reshape(R, [1, 65536]);
G = reshape(G, [1, 65536]);
B = reshape(B, [1, 65536]);
I = readmatrix("confusion_1.xlsx");
I = I'; %[65536,1] change to [1,65536]
for i=1:65536
    Rc(I(i))=R(i);
    Gc(I(i))=G(i);
    Bc(I(i))=B(i);
end

Rc = reshape(Rc, [256, 256]);
Gc = reshape(Gc, [256, 256]);
Bc = reshape(Bc, [256, 256]);
DecryptedImage = cat(3, Rc, Gc, Bc);
figure
imshow(DecryptedImage)
%imwrite(DecryptedImage, "D:\nithya mam\DECRYPT");
