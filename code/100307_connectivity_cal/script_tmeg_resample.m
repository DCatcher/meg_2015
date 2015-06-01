% data_prefix     = 'c:\Users\Chengxu\Desktop\tMEG_data_106521\tmegpreproc_needed\106521_tmeg_';
data_prefix     = 'c:\Users\Chengxu\Desktop\MEG_data_tmp\113922_MEG_motort_blocks\113922_tmeg_';
result_prefix   = '113922_tmeg_new_sig_';

indx_list       = {'1', '2', '3', '4', '5', '6', '7', '8'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
    data_now    = [data_prefix, indx_now];
    result_now  = [result_prefix, indx_now];
    
    resample_from_compress('compress_result_8_resting_brain_rg', data_now, result_now, 1, 1, 1);
end