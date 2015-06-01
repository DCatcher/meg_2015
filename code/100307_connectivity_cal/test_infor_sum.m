% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_time\106521_infor_sum_4.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_time\106521_infor_sum_8.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_time\106521_infor_sum_12.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_time\106521_infor_sum_16.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');


% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_sub\106521_infor_sum.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% % disp(sort_result(end:-1:end-6)');
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_sub\108323_infor_sum.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% % disp(sort_result(end:-1:end-6)');
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_sub\109123_infor_sum.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% disp(infor_sum(213));
% 
% load('d:\matlab2012a\meg\code\100307_connectivity_cal\conn_sub\113922_infor_sum.mat')
% [sort_result, sort_indx] = sort(infor_sum);
% disp(sort_indx(end:-1:end-6)');
% disp(infor_sum(213));disp(sort_result(end));
% 
%% about rmeg in time

% num_disp    = 10;
% % data_prefix     = 'conn_time\106521_infor_sum_';
% data_prefix     = 'conn_time\106521_infor_sum_result_';
% % data_suffix     = '_infor_sum.mat';
% data_suffix     = '.mat';
% 
% new_sig_suffix  = '106521_new_sig_';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [new_sig_suffix, indx_now];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
% end
% 
% fprintf('\n');
%% about rmeg

% num_disp    = 10;
% data_prefix     = 'conn_sub\';
% data_suffix     = '_infor_sum.mat';
% % data_suffix     = '_infor_sum_result.mat';
% 
% new_sig_suffix  = '_new_sig';
% 
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
% end
% 
% fprintf('\n');

%% about tmeg

% num_disp    = 10;
% data_prefix     = 'conn_tmeg\106521_tmeg_infor_sum_';
% data_suffix     = '.mat';
% 
% new_sig_suffix  = '106521_tmeg_new_sig_';
% 
% indx_list       = {'1', '2', '3', '4', '5', '6', '7', '8'};
% % indx_list       = {'1', '2', '3', '4'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [new_sig_suffix, indx_now];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
% end

%% as cell input
% num_disp    = 20;
% data_prefix     = 'sub_infor_sum\';
% data_suffix     = '_infor_sum.mat';
% % data_suffix     = '_infor_sum_result.mat';
% 
% new_sig_suffix  = '_new_sig';
% 
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% input_cell      = cell(size(indx_list));
% new_sig_cell    = cell(size(indx_list));
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     input_cell{indx_i}      = data_now;
%     new_sig_cell{indx_i}    = new_sig_now;
% end
% 
% [active_reg, sort_result]   = disp_active_reg(input_cell, new_sig_cell, num_disp, 'compress_result_8_resting_brain_rg', 'parcellations_VGD11b_4k', 1);
% %     disp(sort_result);
% for indx_j=1:num_disp
%     fprintf('%s, ', active_reg{indx_j}{1});
% end
% fprintf('\nsub infor sum in cell\n');

%% as cell input, rand seed changed
% num_disp    = 10;
% data_prefix     = 'sub_infor_sum_rand_seed_change\';
% data_suffix     = '_rand_seed_change_infor_sum.mat';
% % data_suffix     = '_rand_seed_change_infor_sum_result.mat';
% % data_suffix     = '_infor_sum_result.mat';
% 
% new_sig_suffix  = '_new_sig';
% 
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% input_cell      = cell(size(indx_list));
% new_sig_cell    = cell(size(indx_list));
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     input_cell{indx_i}      = data_now;
%     new_sig_cell{indx_i}    = new_sig_now;
% end
% 
% [active_reg, sort_result]   = disp_active_reg(input_cell, new_sig_cell, num_disp, 'compress_result_8_resting_brain_rg', 'parcellations_VGD11b_4k', 1);
% %     disp(sort_result);
% for indx_j=1:num_disp
%     fprintf('%s, ', active_reg{indx_j}{1});
% end
% fprintf('\nsub infor sum in cell, rand seed changed\n');
%% For new infor sum
% num_disp    = 10;
% data_prefix         = 'sub_infor_sum\';
% data_prefix_2       = 'sub_infor_sum_rand_test\';
% data_suffix     = '_infor_sum.mat';
% % data_suffix     = '_infor_sum_result.mat';
% 
% new_sig_suffix  = '_new_sig';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
% %     data_now_2      = 
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
%     
% %     disp(sort_result);
% end
% 
% fprintf('sub infor sum\n');

%% For new infor sum, with rand test
% % num_disp    = 10;
% num_disp    = 110;
% data_prefix         = 'sub_infor_sum\';
% data_prefix_2       = 'sub_infor_sum_rand_test\';
% data_suffix         = '_infor_sum.mat';
% data_suffix_2       = '_infor_sum_rand_test.mat';
% % data_suffix     = '_infor_sum_result.mat';
% 
% new_sig_suffix  = '_new_sig';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     data_now_2      = [data_prefix_2, indx_now, data_suffix_2];
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now_2, new_sig_now, num_disp);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
%     
% %     disp(sort_result);
% end
% 
% fprintf('sub infor sum, with rand test\n');

%% about rmeg in sub, time in cell

% num_disp    = 30;
num_disp    = 40;
% data_prefix     = 'conn_time\106521_infor_sum_';
% data_prefix     = 'time_infor_sum\106521_infor_sum_result_';
% data_prefix     = 'time_infor_sum\106521_infor_sum_';
% data_prefix     = 'sub_time_infor_sum\106521_sub_time_infor_sum_';
% data_prefix     = 'sub_time_infor_sum\108323_sub_time_infor_sum_';
data_prefix     = 'sub_time_infor_sum\';
% data_prefix     = 'time_infor_sum\108323_infor_sum_';
% data_suffix     = '_infor_sum.mat';
data_suffix     = '_sub_time_infor_sum_';

new_sig_preffix  = 'sub_time_new_sigs\';
new_sig_suffix  = '_new_sig_sub_time_';
% new_sig_suffix  = 'sub_time_new_sigs\106521_new_sig_sub_time_';
% new_sig_suffix  = '108323_new_sig_';

% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% indx_list       = {'36', '24', '20', '16', '12', '8', '4', '0'};
% indx_list       = {'12', '8', '4', '0'};
sub_list        = {'106521', '108323', '109123', '113922', '204521', '725751', '599671', '162026'};
indx_list       = {'10', '20', '30', '40', '50', '60', '70', '80'};
% indx_list       = {'10'};

all_list_len    = length(sub_list) * length(indx_list);
input_cell      = cell(all_list_len, 1);
new_sig_cell    = cell(all_list_len, 1);

now_cell_len    = 0;

for indx_j=1:length(sub_list)
    sub_now     = sub_list{indx_j};
    
    for indx_i=1:length(indx_list)
    % for indx_i=1:1
        indx_now    = indx_list{indx_i};

        data_now        = [data_prefix, sub_now, data_suffix, indx_now];
        new_sig_now     = [new_sig_preffix, sub_now, new_sig_suffix, indx_now];

%         [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
%     %     disp(sort_result);
%         for indx_j=1:num_disp
%             fprintf('%s, ', active_reg{indx_j}{1});
%         end
%         fprintf('\n');
        
        now_cell_len    = now_cell_len + 1;
        
        input_cell{now_cell_len}        = data_now;
        new_sig_cell{now_cell_len}      = new_sig_now;
    %     disp(sort_result);
    end
end

fprintf('\n');
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [new_sig_suffix, indx_now];
% end

[active_reg, sort_result]   = disp_active_reg(input_cell, new_sig_cell, num_disp, 'compress_result_8_resting_brain_rg', 'parcellations_VGD11b_4k', 1, 0);
%     disp(sort_result);
for indx_j=1:num_disp
    fprintf('%s, ', active_reg{indx_j}{1});
end
fprintf('\n');

%% about tmeg in time
% 
% num_disp    = 10;
% % data_prefix     = 'conn_time\106521_infor_sum_';
% % data_prefix     = 'tmeg_infor_sum\106521_infor_sum_result_';
% data_prefix     = 'tmeg_infor_sum\106521_infor_sum_';
% % data_suffix     = '_infor_sum.mat';
% data_suffix     = '.mat';
% 
% new_sig_suffix  = '106521_tmeg_new_sig_';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% indx_list       = {'1', '2', '3', '4', '5'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [new_sig_suffix, indx_now];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
% %     disp(sort_result);
% end
% 
% fprintf('tmeg in time\n');
%% about tmeg in time in cell

% num_disp    = 10;
% % data_prefix     = 'conn_time\106521_infor_sum_';
% % data_prefix     = 'tmeg_infor_sum\106521_infor_sum_result_';
% data_prefix     = 'tmeg_infor_sum\106521_infor_sum_';
% % data_suffix     = '_infor_sum.mat';
% data_suffix     = '.mat';
% 
% new_sig_suffix  = '106521_tmeg_new_sig_';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% indx_list       = {'1', '2', '3', '4', '5'};
% 
% input_cell      = cell(size(indx_list));
% new_sig_cell    = cell(size(indx_list));
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [new_sig_suffix, indx_now];
%     
%     input_cell{indx_i}      = data_now;
%     new_sig_cell{indx_i}    = new_sig_now;
% end
% 
% [active_reg, sort_result]   = disp_active_reg(input_cell, new_sig_cell, num_disp, 'compress_result_8_resting_brain_rg', 'parcellations_VGD11b_4k', 1);
% %     disp(sort_result);
% for indx_j=1:num_disp
%     fprintf('%s, ', active_reg{indx_j}{1});
% end
% fprintf('\ntmeg in time in cell\n');

%% about tmeg in sub

% num_disp    = 10;
% % data_prefix     = 'conn_time\106521_infor_sum_';
% % data_prefix     = 'tmeg_infor_sum\106521_infor_sum_result_';
% data_prefix     = 'tmeg_infor_sum\';
% % data_suffix     = '_infor_sum.mat';
% % data_suffix     = '_infor_sum_result_2.mat';
% data_suffix     = '_infor_sum_2.mat';
% 
% new_sig_suffix  = '_tmeg_new_sig_2';
% 
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% % indx_list       = {'4', '8', '12', '16', '20', '24', '36'};
% % indx_list       = {'1', '2', '3', '4', '5'};
% 
% for indx_i=1:length(indx_list)
% % for indx_i=1:1
%     indx_now    = indx_list{indx_i};
%     
%     data_now        = [data_prefix, indx_now, data_suffix];
%     new_sig_now     = [indx_now, new_sig_suffix];
%     
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp, 'compress_result_8_resting_brain_rg', 'parcellations_VGD11b_4k', 0, 1);
%     [active_reg, sort_result]   = disp_active_reg(data_now, new_sig_now, num_disp);
% %     disp(sort_result);
%     for indx_j=1:num_disp
%         fprintf('%s, ', active_reg{indx_j}{1});
%     end
%     fprintf('\n');
% %     disp(sort_result);
% end
% 
% fprintf('tmeg in sub\n');