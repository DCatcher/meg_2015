function recon_errors = calculate_connectivity(params)

close all

% disp(configuration);

N               = params.N;
P               = params.P;
gamma           = params.gamma;
configuration   = params.configuration;
recon_P         = params.recon_P;
watch_len       = params.watch_len;
data            = params.data;
arSig           = params.arSig;
arNoise         = params.arNoise;
x_sig           = params.x_sig;
x_noise         = params.x_noise;
sigLevel        = params.sigLevel;
noiseLevel      = params.noiseLevel;
num_st          = params.num_st;
num_en          = params.num_en;

num_neuron      = length(configuration);
connectivity_o  = zeros(num_neuron, num_neuron, P);

data    = data';
fft_all_data    = zeros(size(data));
for indx_i=1:num_neuron
    fft_all_data(indx_i, :)  = fft(data(indx_i,:));
end

fft_all_noise   = zeros(size(x_sig));
for indx_i=1:num_neuron
    fft_all_noise(indx_i, :)     = fft(x_sig(indx_i,:));
end

data    = data';
% x_sig   = x_sig';

for indx_i=1:num_neuron
    for indx_j=1:num_neuron
        for indx_k=1:P
            connectivity_o(indx_i, indx_j, indx_k)  = arSig(indx_i, (indx_k-1)*num_neuron + indx_j);
        end
    end
end

l_connectivity_o            = zeros(num_neuron, num_neuron, N);
l_connectivity_o(:,:,1:P)   = connectivity_o(:,:,:);

f_connectivity  = zeros(num_neuron, num_neuron, N);
for indx_i=1:num_neuron
    for indx_j=1:num_neuron
        f_connectivity(indx_i, indx_j, :)  = fft(l_connectivity_o(indx_i, indx_j, :));
    end
end

sig_en_part     = data(recon_P+2:N, num_en);
len_st_part     = N - recon_P - 1;
sig_st_part     = zeros(len_st_part, recon_P);
for indx_i=1:len_st_part
    sig_st_part(indx_i, :)     = data(indx_i:indx_i+recon_P-1, num_st)';
end

[reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
reg_cal         = reg_cal(end:-1:1);
l_reg_cal       = zeros(1, N);
l_reg_cal(1:recon_P)  = reg_cal;
l_reg_cal       = l_reg_cal';

f_23_cal    = fft(l_reg_cal);


% subplot(2,1,1);
% plot(abs(f_23_cal));
% f_23_real   = f_connectivity(2,3,:)./(1-f_connectivity(2,2,:));
% f_23_real   = f_connectivity(num_en, num_st,:); %work for 23

% cal_order   = 20;
% f_23_real   = f_connectivity(num_en, num_st,:);
% for indx_i=1:cal_order
%     f_23_real   = f_23_real + f_connectivity(num_en, num_st,:).*(f_connectivity(num_en, num_en,:).^indx_i); %don't work for 23
% end

% f_23_real   = (f_connectivity(num_en, num_st,:)./(1-f_connectivity(num_en, num_en, :)));
% f_23_real   = f_connectivity(num_en, num_st,:) + f_connectivity(num_en, 2, :).*f_connectivity(2, num_st, :); %don;t work for 23
% f_23_real   = (f_connectivity(num_en, num_st,:)./(1-f_connectivity(num_en, num_en, :)))./(1-f_connectivity(num_st, num_st, :));


% f_23_real   = f_23_real(:);
% subplot(2,1,2);
% plot(abs(f_23_real));

% con_new     = real(ifft(f_23_real));
% con_ifft    = real(ifft(f_23_real));
% con_ifft    = con_ifft(1:recon_P);
% con_new     = con_new(1:recon_P);

con_new             = zeros(recon_P, 1);
% con_new(1:P)        = connectivity_o(num_en, num_st,:);
tmp_con             = conv(reshape(connectivity_o(num_en, 2, :), P, 1), reshape(connectivity_o(2, num_st, :), P, 1));

con_new             = con_new + tmp_con;

subplot(2,1,1);
diff_tmp            = reg_cal - con_new;
plot(diff_tmp(1:P+2));
subplot(2,1,2);
plot(reshape(connectivity_o(num_en, num_st,:), P, 1));

% recon_errors        = sum(abs(con_new   - con_ifft))/sum(abs(con_new));

% disp(sum(abs(l_connectivity_o(2,3,:))));
% disp(mean(abs(f_23_cal)));
% disp(mean(abs(f_23_real)));
% disp(mean(abs(f_23_real - f_23_cal)));

% disp(reg_cal');
% disp(reshape(connectivity_o(num_en, num_st,:),1, P));
% disp(con_new');
% disp(mean(abs(con_new - reg_cal)));

recon_errors    = sum(abs(con_new - reg_cal))/sum(abs(reg_cal))/recon_P*P;
% recon_errors    = sum(abs(reg_cal));
% fprintf('sum of reg_cal:%f\n', sum(abs(reg_cal)));
% fprintf('sum of con_new:%f\n', sum(abs(con_new)));
% disp(reg_cal')
% disp(con_new')

% reg_real    = l_connectivity_o(num_en, num_st, :);
% reg_real    = reg_real(:);
% disp(sum(abs(reg_real' - l_reg_cal)));
% 
% f_1     = fft(reg_real);
% f_2     = fft(l_reg_cal);
% 
% for indx_i=1:num_neuron
%     fft_recons_tmp  = fft_all_noise(indx_i, :)/sigLevel;
% %     disp(size(fft_recons_tmp));
%     for indx_j=1:num_neuron
%         if configuration(indx_j, indx_i)==1
%             f_con_tmp   = f_connectivity(indx_i, indx_j, :);
% %             disp(size(f_con_tmp));
%             fft_recons_tmp  = fft_recons_tmp + fft_all_data(indx_j, :).*reshape(f_con_tmp, size(fft_recons_tmp));
%         end
%     end
%     
%     fft_recons_tmp  = fft_recons_tmp(1:watch_len);
%     disp(mean(abs(fft_recons_tmp - fft_all_data(indx_i, 1:watch_len))));
%     disp(mean(abs(fft_all_data(indx_i, 1:watch_len))));
%     disp(mean(abs(fft_recons_tmp)));
%     figure(1);
%     plot(abs(fft_all_data(indx_i, 1:watch_len)));
%     figure(2);
%     plot(abs(fft_recons_tmp));
% %     figure(3);
% %     plot(abs(fft_all_noise(indx_i, :)/sigLevel));
%     pause();
% end
