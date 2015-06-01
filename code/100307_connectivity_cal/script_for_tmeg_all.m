
data_prefix 	= '113922_tmeg_new_sig_';
result_prefix 	= '113922_tmeg_conn_x_';
freq_prefix 	= '113922_tmeg_conn_x_freq_';
infor_prefix 	= '113922_infor_sum_';
infor_result_prefix 	= '113922_infor_sum_result_';

indx_list 		= {'1', '2', '3', '4', '5', '6', '7', '8'};

for indx_i=1:length(indx_list)
	indx_now  	= indx_list{indx_i};
	
	data_now 	= [data_prefix, indx_now];
	result_now 	= [result_prefix, indx_now];
	freq_now 	= [freq_prefix, indx_now];
	infor_now 	= [infor_prefix, indx_now];
	infor_result_now 	= [infor_result_prefix, indx_now];
	
	cal_con_onedire_to_anodire(data_now, result_now, -1, -1, 1);
	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
	cal_infor_sum(freq_now, infor_now);
	cal_infor_sum(freq_now, infor_result_now, 1);
end