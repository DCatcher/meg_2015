% rand('seed', 0);
time_len    = 10000;
conv_len    = 20;

sig_x       = rand(1, time_len) - 0.5;

conv_xy     = rand(1, conv_len);
conv_yz     = rand(1, conv_len);
l_conv_xy   = zeros(1, time_len);
l_conv_yz   = zeros(1, time_len);
l_conv_xy(1:conv_len)   = conv_xy;
l_conv_yz(1:conv_len)   = conv_yz;

sig_y       = conv(sig_x, conv_xy);
sig_z       = conv(sig_y, conv_yz);

sig_z_new   = conv(sig_x, conv(conv_xy, conv_yz));

sig_z_for_reg   = sig_z(conv_len*2-1:time_len-1);
sig_x_for_reg   = zeros(time_len - conv_len*2 +1, conv_len*2-1);
for idx_i=1:time_len - conv_len*2 +1
    sig_x_for_reg(idx_i, :)     = sig_x(idx_i:idx_i+conv_len*2-2);
end

[reg_cal, BINT, R_cal]  = regress(sig_z_for_reg', sig_x_for_reg);
reg_cal     = reg_cal(end:-1:1);
disp(sum(abs(reg_cal' - conv(conv_xy, conv_yz)))/sum(abs(conv(conv_xy, conv_yz))));
disp(sum(abs(R_cal))/sum(abs(sig_z)));

sig_y       = sig_y(1:time_len);
sig_z       = sig_z(1:time_len);

f_sig_x     = fft(sig_x);
f_sig_y     = fft(sig_y);
f_sig_z     = fft(sig_z);

f_conv_xy   = fft(l_conv_xy);
f_conv_yz   = fft(l_conv_yz);
f_conv_xz   = f_conv_xy.*f_conv_yz;

r_conv_xy   = f_sig_y./f_sig_x;
r_conv_yz   = f_sig_z./f_sig_y;
r_conv_xz   = f_sig_z./f_sig_x;

conv_xz     = ifft(r_conv_xz);
plot(abs(f_conv_xy(1:conv_len*10)));
% plot(sig_z);

disp(mean(abs(r_conv_xy)));
disp(mean(abs(r_conv_yz)));
disp(mean(abs(r_conv_xz)));
disp(mean(abs(r_conv_xy - f_conv_xy)));
disp(mean(abs(r_conv_yz - f_conv_yz)));
disp(mean(abs(r_conv_xz - f_conv_xz)));
disp(sum(abs(sig_z_new(1:time_len) - sig_z(1:time_len)))/sum(abs(sig_z)));




