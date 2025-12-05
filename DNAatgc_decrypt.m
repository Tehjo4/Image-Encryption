
function [e] = DNAatgc_decrypt(c, clh)

    % Initialize output vector
    e = zeros(1, length(c));
for d =1:length(c)
    c1 = dec2bin(c(d), 8);
    clh1 = dec2bin(clh(d), 8);
    for i = 1:4
    c1_dec = {bin2dec(c1(1:2)), bin2dec(c1(3:4)), bin2dec(c1(5:6)), bin2dec(c1(7:8))};
    clh1_dec = {bin2dec(clh1(1:2)), bin2dec(clh1(3:4)), bin2dec(clh1(5:6)), bin2dec(clh1(7:8))};
    if (c1_dec{i}<clh1_dec{i})
        diff_dec=((c1_dec{i}+4)-clh1_dec{i});
    else 
        diff_dec=((c1_dec{i}) - (clh1_dec{i}));
    end
    result_bin{i}=dec2bin(diff_dec, 2);
    final_result_bin = [result_bin{:}];
    e(d)=bin2dec(final_result_bin);
    end
end

end