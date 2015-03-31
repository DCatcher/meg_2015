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




