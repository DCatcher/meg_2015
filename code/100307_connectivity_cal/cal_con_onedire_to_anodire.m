function cal_con_onedire_to_anodire(input_file, output_file, indx_x, cut_num, resample_freq)

recon_P     = 20;

if nargin<4
    cut_num     = 1000;
end

if nargin<5
    resample_freq   = 10;
end

load(input_file);

if cut_num>0

    all_source_sig_new  = cell(cut_num, 1);

    for indx_i=1:cut_num
        all_source_sig_new{indx_i}  = all_source_sig{indx_i};
    end

    clear all_source_sig

    all_source_sig  = all_source_sig_new;
end

if indx_x>0
    num_neurons     = length(all_source_sig);
    num_sigs        = size(all_source_sig{1}, 2);

    all_connectivity        = cell(num_neurons, 1);

    data    = zeros(num_sigs/resample_freq, num_neurons);
    
    for indx_i=1:num_neurons
        data(:, indx_i)     = all_source_sig{indx_i}(indx_x, 1:resample_freq:num_sigs)';
    end
else
    expand_rate     = size(all_source_sig{1}, 1);
    num_neurons     = length(all_source_sig) * expand_rate;
    num_sigs        = size(all_source_sig{1}, 2);

    all_connectivity        = cell(num_neurons, 1);

    data    = zeros(num_sigs/resample_freq, num_neurons);
    
    for indx_i=1:num_neurons
        tmp_indx_x          = mod(indx_i, expand_rate);
        if tmp_indx_x==0
            tmp_indx_x      = 3;
        end
        tmp_indx_i          = floor((indx_i - tmp_indx_x)/expand_rate) + 1;
        data(:, indx_i)     = all_source_sig{tmp_indx_i}(tmp_indx_x, 1:resample_freq:num_sigs)';
    end    
end

num_sigs    = num_sigs/resample_freq;

% data    = data/std(data(:));

for indx_i=1:num_neurons
    data(:, indx_i)     = data(:, indx_i) - mean(data(:, indx_i));
    data(:, indx_i)     = data(:, indx_i)/std(data(:, indx_i));
end

% parfor indx_i=1:num_neurons
for indx_i=1:num_neurons-1
% parfor indx_i=1:30
    
    fprintf('now indx:%i\n', indx_i);
    
%     tic;
%     [mat_reg_all, reg_error]    = MVAR_ml(data, num_sigs, recon_P, indx_i);
%     all_connectivity(indx_i, :, :)  = mat_reg;
%     toc;
    
    
    tic
    mat_reg_all     = zeros(num_neurons - indx_i, 2, 2, recon_P+1);
    parfor indx_j=(indx_i+1):num_neurons 
	mat_reg_all(indx_j - indx_i, :, :, :)    = MVAR_2(data, num_sigs, recon_P, indx_i, indx_j);
    end
    toc
    
%     tmp_1   = abs(mat_reg_all(2, 2, 2, :) - mat_reg_all(3, 2, 2, :));
%     tmp_2   = abs(mat_reg_all(2, 2, 2, :) - mat_reg_all(4, 2, 2, :));
%     tmp_3   = abs(mat_reg_all(2, 2, 2, :) - mat_reg_all(5, 2, 2, :));
%     disp(sum(tmp_1(:)))
%     disp(sum(tmp_2(:)))
%     disp(sum(tmp_3(:)))
%     pause();
    
    all_connectivity{indx_i}    = mat_reg_all;
end

save(output_file);
