result_prefix 	= '106521_conn_x_';
freq_prefix 	= '106521_conn_x_freq_';
infor_prefix 	= '106521_infor_sum_';
infor_result_prefix 	= '106521_infor_sum_result_';

% indx_list 		= {'1', '2', '3', '4', '5', '6', '7', '8'};
% indx_list       = {'109123', '113922', '599671', '725751', '162026', '204521'};
indx_list 	= {'12', '16', '20', '24', '36'};

for indx_i=1:length(indx_list)
	indx_now  	= indx_list{indx_i};
	
	result_now 	= [result_prefix, indx_now];
	freq_now 	= [freq_prefix, indx_now];
	infor_now 	= [infor_prefix, indx_now];
	infor_result_now 	= [infor_result_prefix, indx_now];
	
	while exist(result_now, 'file')==0
		pause(100);
	end
	
	disp('start');
	pause(100);
	
	cal_conn_from_time_to_frequ(result_now, freq_now, 1);
	cal_infor_sum(freq_now, infor_now);
	cal_infor_sum(freq_now, infor_result_now, 1);
end
