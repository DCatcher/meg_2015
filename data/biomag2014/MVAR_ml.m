function [mat_reg, reg_error] =MVAR_ml(data,N,recon_P,num_1)
sig_en_part1     = data(recon_P+1:N, num_1);%%%%%%%%%%data(recon_P+1:N, num_en)
num_neuron      = size(data, 2);
sig_st_part     = zeros(N-recon_P, recon_P*num_neuron);

for indx_i=1:N-recon_P
    tmp_formx       = [];
    for indx_j=1:num_neuron
        tmp_formx     = [tmp_formx, data(indx_i:indx_i+recon_P-1, indx_j)'];
    end
    sig_st_part(indx_i, :)     = tmp_formx;
end

% disp(size(sig_en_part1));
% disp(size(sig_en_part2));
% disp(size(sig_st_part));
[reg_cal1, BINT, R_cal]  = regress(sig_en_part1, sig_st_part);
reg_error   = sum(abs(R_cal - sig_en_part1))/sum(abs(sig_en_part1));
% fprintf('regress error: %f\n', abs(R_cal - sig_en_part1)/abs(sig_en_part1));
reg_cal1    = reg_cal1(end:-1:1)';
reg_all     = zeros(num_neuron, 1+recon_P);

for indx_i=1:num_neuron
    reg_all(indx_i, :)  = [0, reg_cal1((indx_i-1)*recon_P+1:indx_i*recon_P)];
end

l_reg_all   = zeros(num_neuron, N);
for indx_i=1:num_neuron
    l_reg_all(indx_i, 1:recon_P+1)  = reg_all(indx_i, :);
end

mat_reg     = zeros(num_neuron, N);
for indx_i=1:num_neuron
    if indx_i==num_1
        mat_reg(indx_i, :)  = 1 - fft(l_reg_all(num_neuron+1 - indx_i, :));
    else
        mat_reg(indx_i, :)  = -fft(l_reg_all(num_neuron+1 - indx_i, :));
    end
end

% reg_cal1  = reg_cal1(end:-1:1)';%2,1
% reg_cal2  =reg_cal2(end:-1:1)';
% reg_11= [0,reg_cal1(recon_P+1:end)];
% reg_21= [0,reg_cal1(1:recon_P)];
% reg_12= [0,reg_cal2(recon_P+1:end)];
% reg_22= [0,reg_cal2(1:recon_P)];
% 
% l_reg_cal = zeros(4, N);
% l_reg_cal(1,1:recon_P+1)  = reg_11;
% l_reg_cal(2,1:recon_P+1)  = reg_21;
% l_reg_cal(3,1:recon_P+1)  = reg_12;
% l_reg_cal(4,1:recon_P+1)  = reg_22;
% mat_reg(1,1,:)  = reshape(1-fft(l_reg_cal(1,:)),1,1,N);
% mat_reg(1,2,:)  = reshape(-fft(l_reg_cal(3,:)),1,1,N);
% mat_reg(2,1,:)  = reshape(-fft(l_reg_cal(2,:)),1,1,N);
% mat_reg(2,2,:)  = reshape(1-fft(l_reg_cal(4,:)),1,1,N);

end