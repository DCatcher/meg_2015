function cal_infor_sum(input_data, output_data, cal_mode, rand_test)

if nargin < 3
    cal_mode    = 0;
end

if nargin < 4
    rand_test   = 0;
end

load(input_data);

num_neuron  = length(all_connectivity_in_freq);

sum_abs     = zeros(num_neuron, 1);

if rand_test==1
    recon_P     = size(all_connectivity_in_freq{1}, 2);
    
    all_conn_in_mat     = zeros(num_neuron, num_neuron, recon_P);
    for indx_i=1:num_neuron
        all_conn_in_mat(indx_i, :, :)  = all_connectivity_in_freq{indx_i};
    end
    
    % rand row
    tmp_rand_indx   = randsample(num_neuron, num_neuron);
    all_conn_in_mat(:, :, :)    = all_conn_in_mat(tmp_rand_indx, :, :);
    
    % rand column
    tmp_rand_indx   = randsample(num_neuron, num_neuron);
    all_conn_in_mat(:, :, :)    = all_conn_in_mat(:, tmp_rand_indx, :);
    
    for indx_i=1:num_neuron
        all_connectivity_in_freq{indx_i}    = reshape(all_conn_in_mat(indx_i, :, :), num_neuron, recon_P);
    end    
end

for indx_i=1:num_neuron
    if mod(indx_i, 10)==0
        fprintf('now indx:%i\n', indx_i);
    end
    
    if mod(indx_i, 3)==0
        dire_a  = indx_i-2;
        dire_b  = indx_i-1;
    elseif mod(indx_i, 3)==1
        dire_a  = indx_i+1;
        dire_b  = indx_i+2;
    else
        dire_a  = indx_i-1;
        dire_b  = indx_i+1;
    end
    
    for indx_j=1:num_neuron
        if indx_j==dire_a || indx_j==dire_b
            continue;
        end
        
        if cal_mode==0
            sum_abs(indx_i)     = sum_abs(indx_i) + sum(abs(all_connectivity_in_freq{indx_j}(indx_i, :)));
        else
            sum_abs(indx_i)     = sum_abs(indx_i) + sum(abs(all_connectivity_in_freq{indx_i}(indx_j, :)));
        end
    end
end

infor_sum   = zeros(num_neuron, 1);

for indx_i=1:num_neuron
       
    if mod(indx_i, 10)==0
        fprintf('now indx:%i\n', indx_i);
    end
    
    if mod(indx_i, 3)==0
        dire_a  = indx_i-2;
        dire_b  = indx_i-1;
    elseif mod(indx_i, 3)==1
        dire_a  = indx_i+1;
        dire_b  = indx_i+2;
    else
        dire_a  = indx_i-1;
        dire_b  = indx_i+1;
    end
    
    for indx_j=1:num_neuron
        if indx_j==dire_a || indx_j==dire_b
            continue;
        end      
        
        if cal_mode==0
            infor_sum(indx_i)   = infor_sum(indx_i) + sum(abs(all_connectivity_in_freq{indx_i}(indx_j, :)))/sum_abs(indx_j);
        else
            infor_sum(indx_i)   = infor_sum(indx_i) + sum(abs(all_connectivity_in_freq{indx_j}(indx_i, :)))/sum_abs(indx_j);
        end
    end
end

save(output_data, 'infor_sum');