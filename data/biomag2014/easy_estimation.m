%% Easy estimation using MVAR with threshold
function easy_estimation(source_data, save_data, test_num, threshold_pos, recon_P)

if nargin < 3
    test_num    = 1000;
end

if nargin < 4
    threshold_pos   = 0.5;
end

if nargin < 5
    recon_P     = 20;
end

if source_data==0
    load_data
    % load the Challenge data to 'data' variable
end

estimaConfiguration = zeros(3,3, test_num);

all_abssum  = [];

for trial_indx=1:test_num
%     fprintf('now trial num:%i\n', trial_indx);
    data_now    = reshape(data(:,:,trial_indx), size(data,1), size(data,2));
    for indx_i=1:3
        [mat_reg, reg_error]    = MVAR_ml(data_now, size(data_now, 1), recon_P, indx_i);
        for indx_j=1:3
            if indx_i==indx_j
                continue
            end
            
            all_abssum(end+1)   = sum(abs(mat_reg(indx_j, :)));
            estimaConfiguration(indx_j, indx_i, trial_indx)     = all_abssum(end);
        end
    end
end

% hist(all_abssum);
tmp_sort_result     = sort(all_abssum);
threshold_now       = tmp_sort_result(floor(length(all_abssum)*threshold_pos));
fprintf('threshold now:%f\n', threshold_now);
estimaConfiguration     = double(estimaConfiguration > threshold_now);
save(save_data, 'estimaConfiguration')