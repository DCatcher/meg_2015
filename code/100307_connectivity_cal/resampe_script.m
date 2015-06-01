data_prefix     = 'c:\Users\Chengxu\Desktop\MEG_data_tmp\';
% data_suffix     = '_MEG_3-Restin_all_sig';
data_suffix     = '106521_MEG_3-Restin_all_sig_';
result_suffix   = '106521_new_sig_';

% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'4', '8', '12', '16', '20', '24'};
indx_list       = {'36', '48', '60'};
% indx_list       = {'599671', '204521'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
%     data_path_now   = [data_prefix, indx_now, data_suffix];
    data_path_now   = [data_prefix, data_suffix, indx_now];
    
%     result_now      = [indx_now, result_suffix];
    result_now      = [result_suffix, indx_now];
    
    resample_from_compress('compress_result_8_resting', data_path_now, result_now, 8);
end