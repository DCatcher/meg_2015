function cal_conn_from_time_to_frequ(input_conn, output_conn, file_mode)

if nargin < 3
    file_mode = 0;
end

load(input_conn);

num_neurons     = length(all_connectivity);
recon_P         = size(all_connectivity{1}, 4);

all_connectivity_in_freq    = cell(num_neurons, 1);% num_neurons, recon_P
diagonal_connectivity_sum   = zeros(num_neurons, recon_P);
diagonal_connectivity_num   = zeros(num_neurons, 1);

for indx_i=1:num_neurons
    all_connectivity_in_freq{indx_i}    = zeros(num_neurons, recon_P);
end
tic;
for indx_i=1:num_neurons
    if mod(indx_i, 10)==0
        toc;
        fprintf('now indx:%i\n', indx_i);
        tic;
    end
%     fprintf('now indx:%i\n', indx_i);
    
    num_offset  = 0;
    idx_offset  = indx_i+1;
    if file_mode==1
        num_offset  = indx_i;
        idx_offset  = 1;
    end
    
    tmp_conn    = all_connectivity{indx_i};
    num_tmp     = size(tmp_conn, 1);
    
%     tic
    for indx_j=idx_offset:num_tmp
        
        neuron_indx     = indx_j + num_offset;
        
        conn_22_tmp     = reshape(tmp_conn(indx_j, :, :, :), 2, 2, recon_P);
        conn_22_freq    = zeros(size(conn_22_tmp));
        
        for indx_k=1:2
            for indx_u=1:2
                if indx_k==indx_u
                    conn_22_freq(indx_k, indx_u, :)     = 1 - fft(reshape(conn_22_tmp(indx_k, indx_u, :), 1, recon_P));
                else
                    conn_22_freq(indx_k, indx_u, :)     = fft(reshape(conn_22_tmp(indx_k, indx_u, :), 1, recon_P));
                end
            end
        end
        
        for indx_k=1:recon_P
            conn_22_freq(:, :, indx_k)      = inv(conn_22_freq(:, :, indx_k));
        end
        
        all_connectivity_in_freq{indx_i}(neuron_indx, :)     = conn_22_freq(1, 2, :);
        all_connectivity_in_freq{neuron_indx}(indx_i, :)     = conn_22_freq(2, 1, :);
        
        diagonal_connectivity_sum(indx_i, :)            = diagonal_connectivity_sum(indx_i, :) + reshape(conn_22_freq(1, 1, :), 1, recon_P);
        diagonal_connectivity_num(indx_i, :)            = 1 + diagonal_connectivity_num(indx_i, :);
        
        diagonal_connectivity_sum(neuron_indx, :)            = diagonal_connectivity_sum(neuron_indx, :) + reshape(conn_22_freq(2, 2, :), 1, recon_P);
        diagonal_connectivity_num(neuron_indx, :)            = 1 + diagonal_connectivity_num(neuron_indx, :);
    end
%     toc
end
toc;
for indx_i=1:num_neurons
    all_connectivity_in_freq{indx_i}(indx_i, :)         = reshape(diagonal_connectivity_sum(indx_i, :), 1, recon_P)/diagonal_connectivity_num(indx_i, :);
end

save(output_conn, 'all_connectivity_in_freq');