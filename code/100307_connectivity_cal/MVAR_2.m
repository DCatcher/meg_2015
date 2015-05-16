function mat_reg =MVAR_2(data,N,recon_P,num_1,num_2)
sig_en_part1     = data(recon_P+1:N, num_1);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_en_part2     = data(recon_P+1:N, num_2);
sig_st_part      = zeros(N-recon_P, recon_P*2);

for indx_i=1:N-recon_P
    sig_st_part(indx_i, :)     = [data(indx_i:indx_i+recon_P-1, num_1)',data(indx_i:indx_i+recon_P-1, num_2)'];
end

[reg_cal1, BINT, R_cal]  = regress(sig_en_part1, sig_st_part);
[reg_cal2, BINT, R_cal]  = regress(sig_en_part2, sig_st_part);
reg_cal1  = reg_cal1(end:-1:1)';%2,1
reg_cal2  = reg_cal2(end:-1:1)';
reg_11= [0,reg_cal1(recon_P+1:end)];
reg_21= [0,reg_cal1(1:recon_P)];
reg_12= [0,reg_cal2(recon_P+1:end)];
reg_22= [0,reg_cal2(1:recon_P)];

mat_reg(1,1,:)  = reg_11;
mat_reg(1,2,:)  = reg_12;
mat_reg(2,1,:)  = reg_21;
mat_reg(2,2,:)  = reg_22;

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