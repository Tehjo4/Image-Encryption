function [e] = DNAatgc_encrypt(c, clh)
    % Initialize output vector
    e = zeros(1, length(c));
for d =1:length(c)
    c1 = dec2bin(c(d), 8);
    clh1 = dec2bin(clh(d), 8);
    for i = 1:4
    c1_dec = {c1(1:2), c1(3:4), c1(5:6), c1(7:8)};
    clh1_dec = {clh1(1:2), clh1(3:4), clh1(5:6), clh1(7:8)};
    sum_dec = mod(bin2dec(c1_dec{i}) + bin2dec(clh1_dec{i}), 4);
    result_bin{i} = dec2bin(sum_dec, 2);
    final_result_bin = [result_bin{:}];
    e(d)=bin2dec(final_result_bin);
    end
end

end