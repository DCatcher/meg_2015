% matlabpool open
parpool
% 
% data_prefix 	= '106521_tmeg_new_sig_';
% result_prefix 	= '106521_tmeg_conn_x_';
% freq_prefix 	= '106521_tmeg_conn_x_freq_';
% infor_prefix 	= '106521_infor_sum_';
% infor_result_prefix 	= '106521_infor_sum_result_';
% 
% indx_list 		= {'6', '7', '8'};
% 
% for indx_i=1:length(indx_list)
% 	indx_now  	= indx_list{indx_i};
% 	
% 	data_now 	= [data_prefix, indx_now];
% 	result_now 	= [result_prefix, indx_now];
% 	freq_now 	= [freq_prefix, indx_now];
% 	infor_now 	= [infor_prefix, indx_now];
% 	infor_result_now 	= [infor_result_prefix, indx_now];
% 	
% 	cal_con_onedire_to_anodire(data_now, result_now, -1, -1, 1);
% 	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
% 	cal_infor_sum(freq_now, infor_now);
% 	cal_infor_sum(freq_now, infor_result_now, 1);
% % end
% 
% data_prefix 	= '_new_sig_rand_seed_change';
% result_prefix 	= '_rand_seed_change_conn_x';
% freq_prefix 	= '_rand_seed_change_freq';
% infor_prefix 	= '_rand_seed_change_infor_sum';
% infor_result_prefix 	= '_rand_seed_change_infor_sum_result';
% 
% % indx_list 		= {'1', '2', '3', '4', '5', '6', '7', '8'};
% indx_list       = {'106521', '108323', '109123', '113922', '599671', '725751', '162026', '204521'};
% 
% for indx_i=1:length(indx_list)
% 	indx_now  	= indx_list{indx_i};
% 	
% 	data_now 	= [data_prefix, indx_now];
% 	result_now 	= [result_prefix, indx_now];
% 	freq_now 	= [freq_prefix, indx_now];
% 	infor_now 	= [infor_prefix, indx_now];
% 	infor_result_now 	= [infor_result_prefix, indx_now];
% 	
% 	cal_con_onedire_to_anodire(data_now, result_now, -1, -1, 1);
% 	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
% 	cal_infor_sum(freq_now, infor_now);
% 	cal_infor_sum(freq_now, infor_result_now, 1);
% end

tmp_prefix_all  = '';
% tmp_prefix_all  = 'd:\matlab2012a\meg\code\100307_connectivity_cal\tmp_for_saving\xyt_result2\';

% result_prefix 	= '162026_tmeg_conn_x_';

% freq_prefix 	= '162026_tmeg_conn_x_freq_';
data_prefix 	= '113922_new_sig_sub_time_';
result_prefix 	= '113922_new_sig_sub_time_conn_x_';
freq_prefix 	= '113922_new_sig_sub_time_conn_x_freq_';
infor_prefix 	= '113922_new_sig_sub_time_infor_sum_';
infor_result_prefix 	= '113922_new_sig_sub_time_infor_sum_result';

% indx_list 		= {'1', '2', '3', '4', '5', '6', '7', '8'};
time_list       = {'10', '20', '30', '40', '50', '60', '70', '80'};

for indx_i=1:length(indx_list)
	indx_now  	= indx_list{indx_i};
	
	data_now 	= [tmp_prefix_all, data_prefix, indx_now];
	result_now 	= [tmp_prefix_all, result_prefix, indx_now];
	freq_now 	= [tmp_prefix_all, freq_prefix, indx_now];
	infor_now 	= [tmp_prefix_all, infor_prefix, indx_now];
	infor_result_now 	= [tmp_prefix_all, infor_result_prefix, indx_now];
	
% 	cal_con_onedire_to_anodire(data_now, result_now, -1, -1, 1);
	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
	cal_infor_sum(freq_now, infor_now);
	cal_infor_sum(freq_now, infor_result_now, 1);
end