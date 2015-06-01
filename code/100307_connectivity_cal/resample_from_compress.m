function resample_from_compress(compress_result, original_sig, new_sig, resample_freq, rand_seed, file_mode)

if nargin < 4
    resample_freq   = 10;
end

if nargin < 5
    rand_seed       = 1;
end

if nargin < 6
    file_mode       = 0;
    % 0 is for rMEG, 1 is for tMEG.
end

rand('seed', rand_seed);

load(compress_result);

load(original_sig);

if file_mode==1
    all_source_sig  = sourcedata;
end

all_source_sig_new  = cell(all_len, 1);

time_all    = size(all_source_sig{1}, 2);

for indx_i=1:length(all_source_sig)
    all_source_sig{indx_i}  = all_source_sig{indx_i}(:, 1:resample_freq:time_all);
end

time_all    = size(all_source_sig{1}, 2);

for indx_i=1:all_len
    
    if mod(indx_i, 10)==0
        fprintf('now indx:%i\n', indx_i);
    end
    
    tmp_sig     = zeros(size(all_source_sig{1}));
    indx_list   = all_compress_indx{indx_i};
    
    for indx_j=1:time_all
        indx_tmp    = randsample(indx_list, 1);
        
        tmp_sig(:, indx_j)  = all_source_sig{indx_tmp}(:, indx_j);
    end
    
    all_source_sig_new{indx_i}  = tmp_sig;
end

all_source_sig  = all_source_sig_new;

save(new_sig, 'all_source_sig');



% function resample_from_compress(all_source_sig, compress_result, new_sig, resample_freq, rand_seed, file_mode)
% 
% if nargin < 4
%     resample_freq   = 10;
% end
% 
% if nargin < 5
%     rand_seed       = 1;
% end
% 
% if nargin < 6
%     file_mode       = 0;
%     % 0 is for rMEG, 1 is for tMEG.
% end
% 
% rand('seed', rand_seed);
% 
% load(compress_result);
% 
% % load(original_sig);
% 
% if file_mode==1
%     all_source_sig  = sourcedata;
% end
% 
% all_source_sig_new  = cell(all_len, 1);
% 
% time_all    = size(all_source_sig{1}, 2);
% 
% for indx_i=1:length(all_source_sig)
%     all_source_sig{indx_i}  = all_source_sig{indx_i}(:, 1:resample_freq:time_all);
% end
% 
% time_all    = size(all_source_sig{1}, 2);
% 
% for indx_i=1:all_len
%     
%     if mod(indx_i, 10)==0
%         fprintf('now indx:%i\n', indx_i);
%     end
%     
%     tmp_sig     = zeros(size(all_source_sig{1}));
%     indx_list   = all_compress_indx{indx_i};
%     
%     for indx_j=1:time_all
%         indx_tmp    = randsample(indx_list, 1);
%         
%         tmp_sig(:, indx_j)  = all_source_sig{indx_tmp}(:, indx_j);
%     end
%     
%     all_source_sig_new{indx_i}  = tmp_sig;
% end
% 
% all_source_sig  = all_source_sig_new;
% 
% save(new_sig, 'all_source_sig');

