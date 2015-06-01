function compress_indx(input_mne, output_file, compress_num, compress_dist, input_list_label)

if nargin < 5
    input_list_label    = 0;
end

if input_list_label==0
    load(input_mne);
    pos_mat     = source.pos;
else
    pos_mat     = [];
    
    for indx_i=1:length(input_mne)
        tmp_read_name   = input_mne{indx_i};
        load(tmp_read_name);
        pos_mat     = [pos_mat, source.pos];
    end
end

num_neuron  = length(pos_mat);

all_len     = 0;
all_compress_indx   = cell(num_neuron, 1);
compress_label  = zeros(num_neuron, 1);

compress_label_indx     = zeros(num_neuron, 1);

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
        
        if input_list_label==0
            if sort_result(indx_j)>compress_dist
                break;
            end
        end
        
        now_indx    = sort_indx(indx_j);
        
        if input_list_label==1
            tmp_mat_1   = pos_mat(indx_i, :);
            tmp_mat_2   = pos_mat(now_indx, :);
            
            wrong_flag  = 0;
            
            for indx_k=1:length(input_mne)
                tmp_dist    = sum(abs(tmp_mat_1((indx_k-1)*3 + (1:3)) - tmp_mat_2((indx_k-1)*3 + (1:3))));
                if tmp_dist > compress_dist
                    wrong_flag = 1;
                    break;
                end
            end
            
            if wrong_flag==1
                break;
            end
            
        end
        
        compress_label(now_indx)    = 1;
        compress_label_indx(now_indx)   = all_len;
        tmp_list(end+1)     = now_indx;
    end
    
    all_compress_indx{all_len}  = tmp_list;
end

fprintf('all len:%i\n', all_len);
save(output_file, 'all_compress_indx', 'all_len', 'compress_label_indx')