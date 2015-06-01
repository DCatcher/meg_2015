% cal_con_onedire_to_anodire('100307_all_sig_100', '100307_conn_x_100', 1)
% cal_con_onedire_to_anodire('100307_all_sig_100', '100307_conn_y_100', 2)
% cal_con_onedire_to_anodire('100307_all_sig_100', '100307_conn_z_100', 3)
% cal_con_onedire_to_anodire('100307_all_sig_200', '100307_conn_x_200', 1)
% cal_con_onedire_to_anodire('100307_all_sig_200', '100307_conn_y_200', 2)
% cal_con_onedire_to_anodire('100307_all_sig_200', '100307_conn_z_200', 3)

% cal_con_onedire_to_anodire('100307_all_sig_Resting_4', '100307_Resting_4_conn_x', 1)
% cal_con_onedire_to_anodire('100307_all_sig_Resting_4_100', '100307_Resting_4_conn_x_100', 1)
% cal_con_onedire_to_anodire('100307_all_sig_Resting_4_200', '100307_Resting_4_conn_x_200', 1)

data_suffix     = '_new_sig';
save_suffix     = '_conn_x';

% indx_list       = {'106521', '108323', '109123', '113922', '116524', '149741', '162026', '187547'};
indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};

for indx_i=1:length(indx_list)
    indx_now    = indx_list{indx_i};
    
    data_now    = [indx_now, data_suffix];
    save_now    = [indx_now, save_suffix];
    
    cal_con_onedire_to_anodire(data_now, save_now, -1, -1, 1)
end