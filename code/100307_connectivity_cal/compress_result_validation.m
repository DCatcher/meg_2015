function compress_result_validation(input_result_1, input_sig_1, input_result_2, input_sig_2)

load(input_result_1);
load(input_sig_1);

all_source_sig_1    = all_source_sig;

all_compress_indx_1     = all_compress_indx;
% all_len_1               = all_len;
compress_label_indx_1   = compress_label_indx;

load(input_result_2);
load(input_sig_2);

all_source_sig_2    = all_source_sig;

all_compress_indx_2     = all_compress_indx;
% all_len_2               = all_len;
compress_label_indx_2   = compress_label_indx;

[rand_error_1, compress_error_1]    = self_validation(all_source_sig_1, all_compress_indx_1, compress_label_indx_1);
[rand_error_2, compress_error_2]    = self_validation(all_source_sig_2, all_compress_indx_2, compress_label_indx_2);

[rand_junk, compress_error_cros_1]  = self_validation(all_source_sig_1, all_compress_indx_2, compress_label_indx_2);
[rand_junk, compress_error_cros_2]  = self_validation(all_source_sig_2, all_compress_indx_1, compress_label_indx_1);

fprintf('rand error 1:%f, compress error 1:%f, cross error 1:%f\n', rand_error_1, compress_error_1, compress_error_cros_1);
fprintf('rand error 2:%f, compress error 2:%f, cross error 2:%f\n', rand_error_2, compress_error_2, compress_error_cros_2);

end

function [error_now] = list_validation(all_source_sig, num_vali, compress_list)
    error_now   = 0;
    
    mult_rate   = 10000000000000000;
    
    sig_ori     = all_source_sig{num_vali};
    error_list  = [];
    for indx_i=compress_list
        sig_tmp     = all_source_sig{indx_i};
        
        if indx_i==num_vali
            continue;
        end
        
        diff_tmp    = sig_tmp - sig_ori;
        diff_tmp    = diff_tmp(:);
        
        error_list(end+1)   = sum(abs(diff_tmp));
    end
    
    error_now   = mean(error_list);
    error_now   = error_now*mult_rate;
end

function [rand_error, compress_error] = self_validation(all_source_sig, all_compress_indx, compress_label_indx)
    compress_error  = 0;
    rand_error      = 0;
    
    num_neuron      = length(all_source_sig);
    
    compress_error_list     = [];
    rand_error_list         = [];
    for indx_i=1:num_neuron
        compress_label_now  = compress_label_indx(indx_i);
        compress_list_now   = all_compress_indx{compress_label_now};
       
        if length(compress_list_now)==1
            continue;
        end
        
        compress_error_list(end+1)  = list_validation(all_source_sig, indx_i, compress_list_now);
        
        compress_list_now   = randsample(num_neuron, length(compress_list_now) - 1);
        
        rand_error_list(end+1)      = list_validation(all_source_sig, indx_i, compress_list_now);
    end
    
    rand_error      = mean(rand_error_list);
    compress_error  = mean(compress_error_list);
end