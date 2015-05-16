function compress_indx(input_mne, output_file, compress_num, compress_dist)

load(input_mne);

pos_mat     = source.pos;

num_neuron  = length(pos_mat);

all_len     = 0;
all_compress_indx   = cell(num_neuron, 1);
compress_label  = zeros(num_neuron, 1);

for indx_i=1:num_neuron
    if mod(indx_i, 20)==0
        fprintf('now indx:%i\n', indx_i);
    end
    if compress_label(indx_i)==1
        continue;
    end
    
    all_len     = all_len + 1;
    tmp_list    = [];
    
    dist_list   = [];
    indx_list   = [];
    
    for indx_j=indx_i:num_neuron
        if compress_label(indx_j)==1
            continue;
        end
        
        dist_list(end+1)    = sum(abs(pos_mat(indx_i, :) - pos_mat(indx_j, :)));
        indx_list(end+1)    = indx_j;
    end
    
    [sort_result, sort_indx]    = sort(dist_list);
    sort_indx   = indx_list(sort_indx);
    for indx_j=1:min(compress_num, length(sort_result))
        if sort_result(indx_j)>compress_dist
            break;
        end
        
        now_indx    = sort_indx(indx_j);
        compress_label(now_indx)    = 1;
        tmp_list(end+1)     = now_indx;
    end
    
    all_compress_indx{all_len}  = tmp_list;
end

fprintf('all len:%i\n', all_len);
save(output_file, 'all_compress_indx', 'all_len')