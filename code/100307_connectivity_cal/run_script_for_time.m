data_suffix     = '106521_new_sig_';
save_suffix     = '106521_conn_x_';

% indx_list       = {'106521', '108323', '109123', '113922', '116524', '149741', '162026', '187547'};
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
indx_list       = {'4', '8', '12', '16', '20', '24'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
    data_now    = [data_suffix, indx_now];
    save_now    = [save_suffix, indx_now];
    
    cal_con_onedire_to_anodire(data_now, save_now, -1, -1, 1)
end