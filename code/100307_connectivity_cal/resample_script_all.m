data_prefix     = 'c:\Users\Chengxu\Desktop\MEG_data_tmp\data_sub_time_for_lg\';
% data_prefix     = 'c:\Users\Chengxu\Desktop\MEG_data_tmp\108323_MEG_motort_blocks\';
data_suffix     = '_MEG_3-Restin_all_sig_';
% data_suffix     = '106521_MEG_3-Restin_all_sig_';
% result_suffix   = '106521_new_sig_';
result_prefix   = 'sub_time_new_sigs_for_lg/';
result_suffix   = '_new_sig_sub_time_';

% data_suffix     = '108323_MEG_3-Restin_all_sig_';
% data_suffix     = '108323_tmeg_';
% result_suffix   = '108323_new_sig_';

% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
indx_list       = {'599671', '725751', '204521'};

% time_list       = {'10', '20', '30', '40', '50', '60', '70', '80'};
time_list       = cell(33, 1);
for indx_i=1:33
    time_list{indx_i}   = int2str(3*indx_i);
end

% indx_list       = {'4', '8', '12', '16', '20', '24', '36', '48', '60'};
% indx_list       = {'4', '8', '12'};
% indx_list       = {'1', '2', '3', '4', '5', '6', '7', '8'};
% indx_list       = {'599671', '204521'};

start_flag      = 1;
start_indx      = 0;
start_time      = 0;

for indx_i=1:length(indx_list)
    
    if start_flag==0
        if indx_i < start_indx
            continue;
        end
    end
    
    indx_now    = indx_list{indx_i};
    
%     data_path_now   = [data_prefix, indx_now, data_suffix];
    for indx_j=1:length(time_list)
        
        if start_flag==0
            if indx_j < start_time
                continue;
            end
        end
        
        start_flag      = 1;
        
        fprintf('now indx_i:%i, now indx_j:%i\n', indx_i, indx_j);
        time_now        = time_list{indx_j};
        data_path_now   = [data_prefix, indx_now, data_suffix, time_now];

    %     result_now      = [indx_now, result_suffix];
        result_now      = [result_prefix, indx_now, result_suffix, time_now];

    %     resample_from_compress('compress_result_8_resting_brain_rg', data_path_now, result_now, 8, 1);
    %     resample_from_compress('compress_result_8_resting_brain_rg', data_path_now, result_now, 8, 0);
        resample_from_compress('compress_result_8_resting_brain_rg', data_path_now, result_now, 1, 0);
    end
end

% 
% data_prefix     = 'c:\Users\Chengxu\Desktop\MEG_data_tmp\';
% data_suffix     = '_MEG_3-Restin_all_sig';
% % data_suffix     = '106521_MEG_3-Restin_all_sig_';
% result_suffix   = '_new_sig';
% 
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% % indx_list       = {'4', '8', '12', '16', '20', '24'};
% % indx_list       = {'36', '48', '60'};
% % indx_list       = {'599671', '204521'};
% 
% for indx_i=1:length(indx_list)
%     indx_now    = indx_list{indx_i};
%     
%     data_path_now   = [data_prefix, indx_now, data_suffix];
% %     data_path_now   = [data_prefix, data_suffix, indx_now];
%     
%     result_now      = [indx_now, result_suffix];
% %     result_now      = [result_suffix, indx_now];
%     
%     resample_from_compress('compress_result_8_resting_brain_rg', data_path_now, result_now, 8);
% end