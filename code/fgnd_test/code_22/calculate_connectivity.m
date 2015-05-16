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
%Xi
for indx_i=1:num_neuron
    fft_all_data(indx_i, :)  = fft(data(indx_i,:));
end
%Innovation
fft_all_noise   = zeros(size(x_sig));%innovation
for indx_i=1:num_neuron
    fft_all_noise(indx_i, :)     = fft(x_sig(indx_i,:));
end

data    = data';
% x_sig   = x_sig';

for indx_i=1:num_neuron
    for indx_j=1:num_neuron
        for indx_k=1:P
            connectivity_o(indx_j,indx_i,indx_k)  = arSig(indx_i, (indx_k-1)*num_neuron + indx_j);
        end
    end
end

l_connectivity_o            = zeros(num_neuron, num_neuron, N);
l_connectivity_o(:,:,1:P)   = connectivity_o(:,:,:);%%%%%%%%%%%%%%%%%%

f_connectivity  = zeros(num_neuron, num_neuron, N);
%Connectivity
for indx_i=1:num_neuron
    for indx_j=1:num_neuron
        f_connectivity(indx_i, indx_j, :)  = fft(l_connectivity_o(indx_i, indx_j, :));
    end
end
for indx_i=1:num_neuron
    for indx_j=1:num_neuron
        if(indx_i==indx_j)
            A(indx_i, indx_j, :)  = 1-f_connectivity(indx_i, indx_j, :);
        else
            A(indx_i, indx_j, :)  = -f_connectivity(indx_i, indx_j, :);
        end
    end
end
for i=1:N
    G(:,:,i)=inv(A(:,:,i));
end
% 
% sig_en_part     = data(recon_P+1:N, num_en);%%%%%%%%%%data(recon_P+1:N, num_en)
% sig_st_part     = zeros(N-recon_P, recon_P);
% for indx_i=1:N-recon_P
%     sig_st_part(indx_i, :)     = data(indx_i:indx_i+recon_P-1, num_st)';
% end
% 
% [reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
% reg_cal         = reg_cal(end:-1:1);
% l_reg_cal       = zeros(1, N);
% l_reg_cal(2:recon_P+1)  = reg_cal;%%%%%%%%%%%%%%%%%
% l_reg_cal       = l_reg_cal';
% 
% f_23_cal    = fft(l_reg_cal);
% [reg_31,f_31]=CoeffRegress(data,N,recon_P-1,1,3);
% 
% [reg_11,f_11]=CoeffRegress(data,N,30,1,1);

all_ave         = zeros(num_neuron, N);
all_ave_num     = zeros(num_neuron, 1);
all_ave_last    = zeros(num_neuron, N);

all_error       = [];

all_standrad    = [];

watch_sum       = [];

if params.mode==0

    tic;

    for indx_i=1:num_neuron

        if params.report_mode==1
            fprintf('indx pair: %i\n', indx_i);
        end
        for indx_j=indx_i+1:num_neuron
            A_tmp       = MVAR(data, N, recon_P, indx_i, indx_j);

            A_tmp_inv   = zeros(size(A_tmp));
            for indx_k=1:N
                A_tmp_inv(:, :, indx_k)     = inv(A_tmp(:, :, indx_k));
            end

            all_ave(indx_i, :)      = all_ave(indx_i, :) + reshape(A_tmp_inv(1, 1, :), 1, N);
            all_ave_num(indx_i)     = all_ave_num(indx_i) + 1;

            all_ave(indx_j, :)      = all_ave(indx_j, :) + reshape(A_tmp_inv(2, 2, :), 1, N);
            all_ave_num(indx_j)     = all_ave_num(indx_j) + 1;

            all_ave_last(indx_i, :)         = reshape(A_tmp_inv(1, 1, :), 1, N);
            all_ave_last(indx_j, :)         = reshape(A_tmp_inv(2, 2, :), 1, N);

    %         f_ori_tmp   = G(indx_i,indx_j, :);
    %         f_com_tmp   = A_tmp_inv(1,2, :);
    %         all_error(end+1)    = sum(abs(abs(f_ori_tmp) - abs(f_com_tmp)))/sum(abs(f_ori_tmp));        

            
            f_ori_tmp   = G(indx_i,indx_j, :);
            f_com_tmp   = A_tmp_inv(1,2, :);
            sum_ori_tmp     = sum(abs(f_ori_tmp));
            sum_com_tmp     = sum(abs(f_com_tmp));
            if sum(abs(f_ori_tmp))>params.delta
                all_error(end+1)    = sum(abs(abs(f_ori_tmp) - abs(f_com_tmp)))/sum_ori_tmp;
                if all_error(end)>1
                    if params.report_mode==1
                        fprintf('error num:%i, %i, %f, %f\n', indx_i, indx_j, sum_ori_tmp, sum_com_tmp);
                    end
                else
                    if params.report_mode==1
                        fprintf('standard connection:%f, error now:%f\n', sum_ori_tmp, all_error(end));
                    end
                    all_standrad(end+1)     = sum_ori_tmp;
                end              
            else
                if params.report_mode==1
                    fprintf('error num:%i, %i, %f\n', indx_i, indx_j, sum_com_tmp);
                end
            end
            
            if indx_i==params.num_st && indx_j==params.num_en
                watch_sum(end+1)    = sum_com_tmp;
            end
%             if sum(abs(f_com_tmp))==Inf
%                 fprintf('error num:%i, %i\n', indx_i, indx_j);
%             end
%             if sum(abs(f_ori_tmp))==Inf
%                 fprintf('error num ori:%i, %i\n', indx_i, indx_j);
%             end            

            f_ori_tmp   = G(indx_j,indx_i, :);
            f_com_tmp   = A_tmp_inv(2,1, :);
            
            sum_ori_tmp     = sum(abs(f_ori_tmp));
            sum_com_tmp     = sum(abs(f_com_tmp));
            if sum(abs(f_ori_tmp))>params.delta
                all_error(end+1)    = sum(abs(abs(f_ori_tmp) - abs(f_com_tmp)))/sum_ori_tmp;
                if all_error(end)>1
                    if params.report_mode==1
                        fprintf('error num:%i, %i, %f, %f\n', indx_j, indx_i, sum_ori_tmp, sum_com_tmp);
                    end
                else
                    if params.report_mode==1
                        fprintf('standard connection:%f, error now:%f\n', sum_ori_tmp, all_error(end));
                    end
                    all_standrad(end+1)     = sum_ori_tmp;
                end
            else
                if params.report_mode==1
                    fprintf('error num:%i, %i, %f\n', indx_j, indx_i, sum_com_tmp);
                end
            end
            
            if indx_i==params.num_st && indx_j==params.num_en
                watch_sum(end+1)    = sum_com_tmp;
            end
%             if sum(abs(f_com_tmp))==Inf
%                 fprintf('error num:%i, %i\n', indx_i, indx_j);
%             end
%             if sum(abs(f_ori_tmp))==Inf
%                 fprintf('error num ori:%i, %i\n', indx_i, indx_j);
%             end                
        end
    end

    for indx_i=1:num_neuron
        f_ori_tmp   = reshape(G(indx_i,indx_i, :), 1, N);
        f_com_tmp   = all_ave(indx_i, :)/all_ave_num(indx_i);

        sum_ori_tmp     = sum(abs(f_ori_tmp));
        sum_com_tmp     = sum(abs(f_com_tmp));
        
        if sum(abs(f_ori_tmp))>params.delta
            all_error(end+1)    = sum(abs(abs(f_ori_tmp) - abs(f_com_tmp)))/sum_ori_tmp;
            if all_error(end)>1
                if params.report_mode==1
                    fprintf('error num:%i\n', indx_i);
                end
            else
                if params.report_mode==1
                    fprintf('standard self connection:%f, error now:%f\n', sum_ori_tmp, all_error(end));
                end
            end         
        else
            if params.report_mode==1
                fprintf('error num:%i, %i, %f\n', indx_i, indx_j, sum_com_tmp);
            end
        end
        
%         if sum(abs(f_com_tmp))==Inf
%             fprintf('error num:%i\n', indx_i);
%         end
%         if sum(abs(f_ori_tmp))==Inf
%             fprintf('error num ori:%i\n', indx_i);
%         end        
    end

    if params.watch_error_mode==0
        recon_errors    = mean(all_error);
    else
        recon_errors    = mean(watch_sum)/mean(all_standrad);
    end

    toc;
elseif params.mode==1

    A_again     = zeros(size(A));
    
    tic
    for indx_i=1:num_neuron
        [A_tmp, MVAR_error]   = MVAR_ml(data, N, recon_P, indx_i);
        if params.report_mode==1
            fprintf('indx now:%i, error MVAR:%f\n', indx_i, MVAR_error);
        end

        for indx_j=1:num_neuron
            f_ori_tmp   = reshape(A(indx_j,indx_i, :), 1, N);
            f_com_tmp   = A_tmp(indx_j, :);
            
            A_again(indx_j, indx_i, :)  = reshape(A_tmp(indx_j, :), 1, 1, N);
            
            sum_ori_tmp     = sum(abs(f_ori_tmp));
            sum_com_tmp     = sum(abs(f_com_tmp));
            
            reg_new_test    = MVAR_ml_oneless(data, N, recon_P, indx_i, indx_j);
            if sum(abs(f_ori_tmp))> params.delta
                all_error(end+1)    = sum(abs(abs(f_ori_tmp) - abs(f_com_tmp)))/sum_ori_tmp;
                if params.report_mode==1
                    fprintf('nrror num:%i, %i, %f, error new:%f\n', indx_i, indx_j, sum_com_tmp, reg_new_test/MVAR_error);
                end
                if indx_i~=indx_j
                    all_standrad(end+1)     = sum_ori_tmp;
                end
            else
                if params.report_mode==1
                    fprintf('error num:%i, %i, %f, error new:%f\n', indx_i, indx_j, sum_com_tmp, reg_new_test/MVAR_error);
                end
            end
            
            if (indx_i==params.num_st && indx_j==params.num_en) || (indx_j==params.num_st && indx_i==params.num_en)
                watch_sum(end+1)    = sum_com_tmp;
            end
        end
    end
    
    G_again     = zeros(size(G));
    
    for i=1:N
        G_again(:,:,i)  =inv(A_again(:,:,i));
    end
    
    new_watch_sum       = [];
    new_all_standrad    = [];
    new_watch_sum(end+1)    = sum(abs(G_again(params.num_st, params.num_en, :)));
    new_watch_sum(end+1)    = sum(abs(G_again(params.num_en, params.num_st, :)));
    
    for indx_i=1:num_neuron
        for indx_j=1:num_neuron
            if indx_i==indx_j
                continue;
            end
            
            if params.configuration(indx_i, indx_j)==0
                continue;
            end
            
            sum_tmp     = sum(abs(G_again(indx_i, indx_j, :)));
            new_all_standrad(end+1)     = sum_tmp;
        end
    end
    
    if params.watch_error_mode==0
        recon_errors    = mean(all_error);
    else
%         recon_errors    = mean(new_watch_sum)/mean(new_all_standrad);
        recon_errors    = mean(watch_sum)/mean(all_standrad);
        
    end
    toc
elseif  params.mode==2
    mat_reg_1   = MVAR_2to1(data, N, recon_P, 1, 1,2);
    mat_reg_2   = MVAR_2to1(data, N, recon_P, 3, 1,2);
    
    subplot(2,1,1);
    comp_1  = mat_reg_1(2, :);
    plot(abs(comp_1));
    subplot(2,1,2);
    comp_2  = mat_reg_2(2, :).*(reshape(f_connectivity(3, 1, :), 1, N)); 
    plot(abs(comp_2));
    
    recon_errors    = sum(abs(comp_1) - abs(comp_2))/sum(abs(comp_1));
end
% 
% A12=MVAR(data,N,20,1,2);
% A13=MVAR(data,N,20,1,3);
% A23=MVAR(data,N,20,2,3);
% for i=1:N
%     A12_inv(:,:,i)=inv(A12(:,:,i));
%     A13_inv(:,:,i)=inv(A13(:,:,i));
%     A23_inv(:,:,i)=inv(A23(:,:,i));
% end

% subplot(3,1,1);
% plot(reshape(abs(A13_inv(2,2,:)),1,N));
% subplot(3,1,2);
% plot(reshape(abs(A23_inv(2,2,:)),1,N));
% subplot(3,1,3)
% plot(reshape(abs(G(3,3,:)),1,N));

% subplot(3,1,1);
% plot(reshape(abs(A13_inv(1,2,:)),1,N));
% subplot(3,1,2);
% plot(reshape(abs(G(1,3,:)),1,N));
% subplot(3,1,3);
% plot(reshape(abs(A13_inv(1,2,:)),1,N) - reshape(abs(G(1,3,:)),1,N));
% 
% fcomp=A13_inv(1,2,:);
% fori=G(1,3,:);
% 
% recon_errors    = sum(abs(abs(fcomp) - abs(fori)))/sum(abs(fori));
% recon_errors    = sum(abs(fcomp - fori))/sum(abs(fori));

% [reg_13,f_13,R_13]=CoeffRegress(data,N,21,3,1);
% [reg_31,f_31]=CoeffRegress(data,N,21,1,3);
% [reg_12,f_12]=CoeffRegress(data,N,10,1,3);
% [reg_21,f_21,R_21]=CoeffRegress(data,N,10,1,2);
% [reg_11,f_11]=CoeffRegressIno2(data,x_sig/sigLevel,N,80,1,1);
%[reg11,f11]=CoeffRegress2(data,N,11,1,1);
% freg=f_13;

% subplot(3,1,1);
% plot(abs(freg));
% f11real=reshape(f_connectivity(1,1,:),1,N);
% f12real=reshape(f_connectivity(2,1,:),1,N);
% f21real=reshape(f_connectivity(1,2,:),1,N);
% f13real=reshape(f_connectivity(3,1,:),1,N);
% f23real=reshape(f_connectivity(3,2,:),1,N);
% f31real=reshape(f_connectivity(1,3,:),1,N);
%fcomp=f11real+f21real.*f12real;
%fcomp=(f11real+f12real.*f21real)./(1-f11real-f12real.*f21real);
%fcomp=1./(1-f11real-f12real.*f21real);
%fcomp=(1./(1-f11real)).*(1./(1-f12real.*f21real));
% fcomp=f13real+f23real./f21real;
% fcomp=1./f13real+f21real./f23real;
% subplot(3,1,2);
% plot(abs((f11real+f12real.*f21real)./(1-f11real-f12real.*f21real)));
%plot(abs((1./(1-f11real)).*(1./(1-f12real.*f21real))));
% plot(abs(f11real+f21real.*f12real));
% plot(abs(fcomp));
% subplot(3,1,3);
% freal=f13real;
% plot(abs(freal));

%[reg_12,f_reg_12]=CoeffRegress2(data,N,recon_P,1,2);

% subplot(2,1,1);
% plot(abs(f_23_cal));
% f_23_real   = f_connectivity(2,3,:)./(1-f_connectivity(2,2,:));
% f_23_real   = f_connectivity(num_en, num_st,:); %work for 23
%f_21_real= f_connectivity(1,2,:)./(1-f_connectivity(1,1,:)).*(1-f_connectivity(2,2,:));
%f_21_real= reshape(f_21_real,N,1);


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

% con_new             = zeros(recon_P, 1);
% con_new(1:P)        = connectivity_o(num_en, num_st,:);
% tmp_con             = conv(reshape(connectivity_o(num_en, 2, :), P, 1), reshape(connectivity_o(2, num_st, :), P, 1));%%%%%%%%%%%%%%
% con_new             = con_new + tmp_con;

% recon_errors        = sum(abs(con_new   - con_ifft))/sum(abs(con_new));

% disp(sum(abs(l_connectivity_o(2,3,:))));
% disp(mean(abs(f_23_cal)));
% disp(mean(abs(f_23_real)));
% disp(mean(abs(f_23_real - f_23_cal)));

% disp(reg_cal');
% disp(reshape(connectivity_o(num_en, num_st,:),1, P));
% disp(con_new');
% disp(mean(abs(con_new - reg_cal)));

%recon_errors    = sum(abs(con_new - reg_31))/sum(abs(reg_31))/recon_P*P;
% recon_errors=0;
% recon_errors    = sum(abs(abs(fcomp') - abs(freg)))/sum(abs(freg))/recon_P*P;
% recon_errors    = sum(abs(abs(freal') - abs(freg)))/sum(abs(freg))/recon_P*P;
% recon_errors    = sum(abs(R_21))/sum(abs(data(:,1)));
% fprintf('sum of reg_cal:%f\n', sum(abs(reg_cal)));

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
end
function [reg_cal,f_reg,R_cal]=CoeffRegress(data,N,recon_P,num_en,num_st)
sig_en_part     = data(recon_P+1:N, num_en);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_st_part     = zeros(N-recon_P, recon_P);
for indx_i=1:N-recon_P
    sig_st_part(indx_i, :)     = data(indx_i:indx_i+recon_P-1, num_st)';
end

[reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
reg_cal         = reg_cal(end:-1:1);
reg_cal=[0;reg_cal];
l_reg_cal       = zeros(1, N);
l_reg_cal(1:recon_P+1)  = reg_cal;%%%%%%%%%%%%%%%%%
l_reg_cal       = l_reg_cal';
f_reg   = fft(l_reg_cal);
end
function [reg_cal,f_reg]=CoeffRegressIno(data,ino,N,recon_P,num_en,num_st)
sig_en_part     = data(recon_P+1:N, num_en);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_st_part     = zeros(N-recon_P, recon_P);
for indx_i=1:N-recon_P
    sig_st_part(indx_i, :)     = ino(num_st,indx_i:indx_i+recon_P-1);
end
[reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
reg_cal         = reg_cal(end:-1:1);
reg_cal=[0;reg_cal];
l_reg_cal       = zeros(1, N);
l_reg_cal(1:recon_P+1)  = reg_cal;%%%%%%%%%%%%%%%%%
l_reg_cal       = l_reg_cal';
f_reg   = fft(l_reg_cal);
end
function [reg_cal,f_reg,R_cal]=CoeffRegressIno2(data,ino,N,recon_P,num_en,num_st)
sig_en_part     = data(recon_P:N, num_en);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_st_part     = zeros(N-recon_P+1, recon_P);
for indx_i=1:N-recon_P+1
    sig_st_part(indx_i, :)     = ino(num_st,indx_i:indx_i+recon_P-1);
end
[reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
reg_cal         = reg_cal(end:-1:1);
l_reg_cal       = zeros(1, N);
l_reg_cal(1:recon_P)  = reg_cal;%%%%%%%%%%%%%%%%%
l_reg_cal       = l_reg_cal';
f_reg   = fft(l_reg_cal);
end
function mat_reg =MVAR(data,N,recon_P,num_1,num_2)
sig_en_part1     = data(recon_P+1:N, num_1);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_en_part2     = data(recon_P+1:N, num_2);
sig_st_part     = zeros(N-recon_P, recon_P*2);

for indx_i=1:N-recon_P
    sig_st_part(indx_i, :)     = [data(indx_i:indx_i+recon_P-1, num_1)',data(indx_i:indx_i+recon_P-1, num_2)'];
end

% disp(size(sig_en_part1));
% disp(size(sig_en_part2));
% disp(size(sig_st_part));
[reg_cal1, BINT, R_cal]  = regress(sig_en_part1, sig_st_part);
[reg_cal2, BINT, R_cal]  = regress(sig_en_part2, sig_st_part);
reg_cal1  = reg_cal1(end:-1:1)';%2,1
reg_cal2  =reg_cal2(end:-1:1)';
reg_11= [0,reg_cal1(recon_P+1:end)];
reg_21= [0,reg_cal1(1:recon_P)];
reg_12= [0,reg_cal2(recon_P+1:end)];
reg_22= [0,reg_cal2(1:recon_P)];

l_reg_cal = zeros(4, N);
l_reg_cal(1,1:recon_P+1)  = reg_11;
l_reg_cal(2,1:recon_P+1)  = reg_21;
l_reg_cal(3,1:recon_P+1)  = reg_12;
l_reg_cal(4,1:recon_P+1)  = reg_22;
mat_reg(1,1,:)  = reshape(1-fft(l_reg_cal(1,:)),1,1,N);
mat_reg(1,2,:)  = reshape(-fft(l_reg_cal(3,:)),1,1,N);
mat_reg(2,1,:)  = reshape(-fft(l_reg_cal(2,:)),1,1,N);
mat_reg(2,2,:)  = reshape(1-fft(l_reg_cal(4,:)),1,1,N);

end

function mat_reg =MVAR_2to1(data,N,recon_P,num_en, num_1,num_2)
sig_en_part     = data(recon_P+1:N, num_en);%%%%%%%%%%data(recon_P+1:N, num_en)
sig_st_part     = zeros(N-recon_P, recon_P*2);

for indx_i=1:N-recon_P
    sig_st_part(indx_i, :)     = [data(indx_i:indx_i+recon_P-1, num_1)',data(indx_i:indx_i+recon_P-1, num_2)'];
end

% disp(size(sig_en_part1));
% disp(size(sig_en_part2));
% disp(size(sig_st_part));
[reg_cal, BINT, R_cal]  = regress(sig_en_part, sig_st_part);
reg_cal = reg_cal(end:-1:1)';%2,1
reg_11  = [0,reg_cal(recon_P+1:end)];
reg_21  = [0,reg_cal(1:recon_P)];

l_reg_cal = zeros(2, N);
l_reg_cal(1,1:recon_P+1)  = reg_11;
l_reg_cal(2,1:recon_P+1)  = reg_21;
mat_reg(1, :)  = reshape(fft(l_reg_cal(1,:)),1,N);
mat_reg(2, :)  = reshape(fft(l_reg_cal(2,:)),1,N);

end


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


function reg_error =MVAR_ml_oneless(data,N,recon_P,num_1, num_2)
sig_en_part1     = data(recon_P+1:N, num_1);%%%%%%%%%%data(recon_P+1:N, num_en)
num_neuron      = size(data, 2);
sig_st_part     = zeros(N-recon_P, recon_P*(num_neuron-1));

for indx_i=1:N-recon_P
    tmp_formx       = [];
    for indx_j=1:num_neuron
        if indx_j==num_2
            continue
        end
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
% reg_cal1    = reg_cal1(end:-1:1)';
% reg_all     = zeros(num_neuron, 1+recon_P);
% 
% for indx_i=1:num_neuron
%     reg_all(indx_i, :)  = [0, reg_cal1((indx_i-1)*recon_P+1:indx_i*recon_P)];
% end
% 
% l_reg_all   = zeros(num_neuron, N);
% for indx_i=1:num_neuron
%     l_reg_all(indx_i, 1:recon_P+1)  = reg_all(indx_i, :);
% end
% 
% mat_reg     = zeros(num_neuron, N);
% for indx_i=1:num_neuron
%     if indx_i==num_1
%         mat_reg(indx_i, :)  = 1 - fft(l_reg_all(num_neuron+1 - indx_i, :));
%     else
%         mat_reg(indx_i, :)  = -fft(l_reg_all(num_neuron+1 - indx_i, :));
%     end
% end

end