result_prefix 	= '_conn_x';
freq_prefix 	= '_conn_x_freq';
infor_prefix 	= '_infor_sum';
infor_result_prefix 	= '_infor_sum_result';

% indx_list 		= {'1', '2', '3', '4', '5', '6', '7', '8'};
indx_list       = {'109123', '113922', '599671', '725751', '162026', '204521'};

for indx_i=1:length(indx_list)
	indx_now  	= indx_list{indx_i};
	
	result_now 	= [indx_now, result_prefix];
	freq_now 	= [indx_now, freq_prefix];
	infor_now 	= [indx_now, infor_prefix];
	infor_result_now 	= [indx_now, infor_result_prefix];
	
	while exist(result_now, 'file')==0
		pause(100);
	end
	
	pause(100);
	
	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
	cal_infor_sum(freq_now, infor_now);
	cal_infor_sum(freq_now, infor_result_now, 1);
end
