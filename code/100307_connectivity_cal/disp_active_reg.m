function [active_reg, sort_result]= disp_active_reg(input_file, new_sig_file, num_disp, compress_result, atlas_file, input_as_cell, rand_test, fil_or_not, fil_list)

if nargin < 3
    num_disp    = 6;
end

if nargin < 4
    compress_result     = 'compress_result_8_resting_brain_rg.mat';
end

if nargin < 5
    atlas_file          = 'parcellations_VGD11b_4k.mat';
end

if nargin < 6
    input_as_cell       = 0;
end


if nargin < 7
    rand_test           = 0;
end

if nargin < 8
    fil_or_not          = 1;
end

if nargin < 9
    fil_list            = [1,2,44,45];
end

load(compress_result);
load(atlas_file);

if input_as_cell==0

    load(input_file);
    load(new_sig_file);

    num_neuron      = length(all_source_sig);

    new_infor_sum   = [];
    all_sum_abs     = [];

    for indx_i=1:num_neuron
        sum_abs     = [];
        tmp_sig     = all_source_sig{indx_i};
        for indx_j=1:3
            sum_abs(end+1)  = sum(abs(tmp_sig(indx_j, :)));
        end

        tmp_infor_sum   = 0;
        for indx_j=1:3
%             tmp_infor_sum   = tmp_infor_sum + infor_sum((indx_i-1)*3 + indx_j) * sum_abs(indx_j)/sum(sum_abs);
            tmp_infor_sum   = tmp_infor_sum + infor_sum((indx_i-1)*3 + indx_j)/3;
        end

        new_infor_sum(end+1)    = tmp_infor_sum;
        all_sum_abs(end+1)      = sum(sum_abs);
    end
else
    new_infor_sum_all   = 0;
    all_sum_abs_all     = 0;
    
    new_infor_sum_for_std   = [];
    
    for indx_j=1:length(input_file)
        load(input_file{indx_j});
        load(new_sig_file{indx_j});

        num_neuron      = length(all_source_sig);

        new_infor_sum   = [];
        all_sum_abs     = [];

        for indx_i=1:num_neuron
            sum_abs     = [];
            tmp_sig     = all_source_sig{indx_i};
            for indx_j=1:3
                sum_abs(end+1)  = sum(abs(tmp_sig(indx_j, :)));
%                 sum_abs(end+1)  = 1;
            end

            tmp_infor_sum   = 0;
            for indx_j=1:3
%                 tmp_infor_sum   = tmp_infor_sum + infor_sum((indx_i-1)*3 + indx_j) * sum_abs(indx_j)/sum(sum_abs);
                tmp_infor_sum   = tmp_infor_sum + infor_sum((indx_i-1)*3 + indx_j)/3;
            end

            new_infor_sum(end+1)    = tmp_infor_sum;
            all_sum_abs(end+1)      = sum(sum_abs);
        end
        
%         disp(sum(new_infor_sum));
        if rand_test==1
            new_infor_sum       = randsample(new_infor_sum, length(new_infor_sum));
        end
        new_infor_sum       = new_infor_sum*sum(new_infor_sum)/num_neuron;
        
        new_infor_sum_all   = new_infor_sum_all + new_infor_sum;
        all_sum_abs_all     = all_sum_abs_all + all_sum_abs;
        
        new_infor_sum_for_std   = [new_infor_sum_for_std; new_infor_sum];
%         disp(size(new_infor_sum_for_std));
    end
    
    new_infor_sum_std   = std(new_infor_sum_for_std, 0, 1);
%     disp(size(new_infor_sum_std));
    new_infor_sum   = new_infor_sum_all/length(input_file);
    all_sum_abs     = all_sum_abs_all/length(input_file);
end

if fil_or_not==1
    left_indx           = [];
    
    for indx_i=1:length(new_infor_sum)
        fil_flag    = 0;
        
        neuron_indx     = all_compress_indx{indx_i}(1);
        brain_indx      = atlas.parcellation2(neuron_indx);
        for indx_j=1:length(fil_list)
            if brain_indx==fil_list(indx_j)
                fil_flag    = 1;
                break
            end
        end
        
        if fil_flag==0
            left_indx(end+1)    = indx_i;
        end
    end
    
    new_infor_sum   = new_infor_sum(left_indx);
    
    if input_as_cell==1
        new_infor_sum_std   = new_infor_sum_std(left_indx);
    end
end

% disp(sum(new_infor_sum));
% disp(kurtosis(new_infor_sum));

% plot(new_infor_sum)
% pause();

% num_brain_rg_neuron     = cell(size(atlas.parcellation2label));
% for indx_i=1:num
%     
% end

[sort_result, sort_indx] = sort(new_infor_sum, 2, 'descend');
% 
if fil_or_not==1
    ori_indx    = sort_indx;
    sort_indx   = left_indx(sort_indx);
end

% disp(sum(sort_result > 1.0894));
active_reg_raw      = sort_indx(1:num_disp)';
%     active_reg_raw      = left_indx(sort_indx(1:num_disp)');
sort_result         = sort_result(1:num_disp)';
active_reg          = cell(size(active_reg_raw));

% disp(sort_result(1));

% disp(all_sum_abs(active_reg_raw));
% 
% all_sum_abs_sort    = all_sum_abs(sort_indx);
% plot(all_sum_abs_sort(1:num_disp));
% pause();

all_brain_rg_indx   = [];
brain_rg_num_all    = [];
for indx_i=1:num_disp
    area_indx   = active_reg_raw(indx_i);
    
    neuron_indx     = all_compress_indx{area_indx}(1);
    brain_rg_num_all(end+1)     = length(all_compress_indx{area_indx});
    all_brain_rg_indx(end+1)    = atlas.parcellation2(neuron_indx);
    brain_rg_indx   = atlas.parcellation2label(atlas.parcellation2(neuron_indx));
    active_reg{indx_i}  = brain_rg_indx;
end

reg_num     = 0;

for indx_i=1:num_disp
    exist_flag  = 0;
    
    for indx_j=1:indx_i-1
        if all_brain_rg_indx(indx_j)==all_brain_rg_indx(indx_i)
            exist_flag  = 1;
            break;
        end
    end
    
    reg_num     = reg_num + 1 - exist_flag;
end

disp(reg_num);

if input_as_cell==1
%     errorbar(sort_result(1:num_disp), new_infor_sum_std(sort_indx(1:num_disp)));
%     hold on;
    bar(sort_result);
    hold on;
    errorbar(sort_result, new_infor_sum_std(ori_indx(1:num_disp)), 'b.');
    axis([0,num_disp+1,0,2.0])
    set(gca,'xtick',1:num_disp);
    new_active_reg  = cell(size(active_reg));
    for indx_i=1:num_disp
        new_active_reg{indx_i}  = active_reg{indx_i}{1}(1:end-4);
    end
    set(gca,'xticklabel',new_active_reg);
%     xlabels{12}     = 'test';
    pause();
else
    plot(sort_result);
    pause();
end

%% calculate the number of each region

% plot(brain_rg_num_all);
% pause();

% brain_rg_num    = zeros(size(atlas.parcellation2label));
% for indx_i=1:num_neuron
%     neuron_indx     = all_compress_indx{indx_i}(1);
%     brain_rg_num(atlas.parcellation2(neuron_indx))  = brain_rg_num(atlas.parcellation2(neuron_indx)) + 1;
% end
% 
% plot(brain_rg_num(all_brain_rg_indx));
% pause();