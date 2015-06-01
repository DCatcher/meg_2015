% data_prefix     = 'conn_sub\';
% 
% data_suffix     = '_conn_x';
% result_suffix   = '_conn_x_freq';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751'};
% indx_list       = {'162026', '204521'};
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% for indx_i=1:length(indx_list)
%     indx_now    = indx_list{indx_i};
%     
%     data_now    = [data_prefix, indx_now, data_suffix];
%     result_now  = [data_prefix, indx_now, result_suffix];
%     
%     cal_conn_from_time_to_frequ(data_now, result_now, 1);
% end

% data_prefix     = 'conn_time\';
% 
% data_suffix     = '106521_conn_x_';
% result_suffix   = '106521_conn_x_freq_';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'36'};
% 
% for indx_i=1:length(indx_list)
%     indx_now    = indx_list{indx_i};
%     
%     data_now    = [data_prefix, data_suffix, indx_now];
%     result_now  = [data_prefix, result_suffix, indx_now];
%     
%     cal_conn_from_time_to_frequ(data_now, result_now, 1);
% end

data_prefix     = 'conn_tmeg\';

data_suffix     = '106521_tmeg_conn_x_';
result_suffix   = '106521_tmeg_conn_x_freq_';

% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
indx_list       = {'1', '2', '3', '4', '5', '6', '7', '8'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
    data_now    = [data_prefix, data_suffix, indx_now];
    result_now  = [data_prefix, result_suffix, indx_now];
    
    cal_conn_from_time_to_frequ(data_now, result_now, 1);
end