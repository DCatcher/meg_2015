rand('seed', 0);
randn('seed', 0);
sum_errors  = 0;
test_len    = 20;
for big_indx=1:test_len
    fprintf('test time:%i\n', big_indx);
    frequency_more;
    recon_errors    = calculate_connectivity;
    sum_errors      = sum_errors + recon_errors;
%     pause();
end

disp(sum_errors/test_len);