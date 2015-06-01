% data_prefix     = '';
% 
% data_suffix     = '106521_tmeg_conn_x_freq_';
% result_suffix   = '106521_tmeg_infor_sum_';
% 
% % indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% % indx_list       = {'4', '8', '12', '16', '20', '24'};
% % indx_list       = {'36'};
% indx_list       = {'5', '6', '7', '8'};
% % indx_list       = {'1', '2', '3', '4'};
% 
% for indx_i=1:length(indx_list)
%     indx_now    = indx_list{indx_i};
%     
%     data_now    = [data_prefix, data_suffix, indx_now];
%     result_now  = [data_prefix, result_suffix, indx_now];
%     
%     cal_infor_sum(data_now, result_now);
% end

data_prefix     = '';

data_suffix     = '106521_tmeg_conn_x_freq_';
result_suffix   = '106521_tmeg_infor_sum_result_';

% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% indx_list       = {'4', '8', '12', '16', '20', '24'};
% indx_list       = {'36'};
% indx_list       = {'5', '6', '7', '8'};
indx_list       = {'1', '2', '3', '4'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
    data_now    = [data_prefix, data_suffix, indx_now];
    result_now  = [data_prefix, result_suffix, indx_now];
    
    cal_infor_sum(data_now, result_now, 1);
end