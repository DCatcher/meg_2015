% matlabpool open

data_prefix 	= '106521_new_sig_sub_time_';
result_prefix 	= '106521_conn_sub_time_';
freq_prefix 	= '106521_conn_sub_time_freq_';
infor_prefix 	= '106521_sub_time_infor_sum_';
infor_result_prefix 	= '106521_sub_time_infor_sum_result_';

indx_list 		= {'10', '20', '30', '40', '50', '60', '70', '80'};

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
