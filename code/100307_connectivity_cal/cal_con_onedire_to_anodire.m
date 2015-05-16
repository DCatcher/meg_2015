function cal_con_onedire_to_anodire(input_file, output_file, indx_x, cut_num, resample_freq)

recon_P     = 20;

if nargin<4
    cut_num     = 1000;
end

if nargin<5
    resample_freq   = 10;
end

load(input_file);

all_source_sig_new  = cell(cut_num, 1);

for indx_i=1:cut_num
    all_source_sig_new{indx_i}  = all_source_sig{indx_i};
end

clear all_source_sig

all_source_sig  = all_source_sig_new;

num_neurons     = length(all_source_sig);
num_sigs        = size(all_source_sig{1}, 2);

all_connectivity        = cell(num_neurons, 1);

data    = zeros(num_sigs/resample_freq, num_neurons);

for indx_i=1:num_neurons
    data(:, indx_i)     = all_source_sig{indx_i}(indx_x, 1:resample_freq:num_sigs)';
end

num_sigs    = num_sigs/resample_freq;

data    = data/std(data(:));

for indx_i=1:num_neurons
    
%     [mat_reg, reg_error]    = MVAR_ml(data, num_sigs, recon_P, indx_i);
%     all_connectivity(indx_i, :, :)  = mat_reg;
    fprintf('now indx:%i\n', indx_i);
    
    tic
    mat_reg_all     = zeros(num_neurons, 2, 2, recon_P+1);
    parfor indx_j=1:num_neurons 
        if indx_j~=indx_i
            mat_reg_all(indx_j, :, :, :)    = MVAR_2(data, num_sigs, recon_P, indx_i, indx_j);
        end
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