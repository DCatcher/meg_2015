load 100307_MEG_3-Restin_icamne

pos_mat     = source.pos;

watch_indx  = 1;

min_dist    = 1000;
min_indx    = watch_indx;

dist_list   = [];

for indx_i=1:length(pos_mat)
    if indx_i==watch_indx
        dist_list(end+1)    = 1000;
        continue;
    end
    tmp_dist    = sum(abs(pos_mat(indx_i, :) - pos_mat(watch_indx, :)));
    
    dist_list(end+1)    = tmp_dist;
    if tmp_dist < min_dist
        min_dist    = tmp_dist;
        min_indx    = indx_i;
    end
end

fprintf('min dist:%f, the indx:%i\n', min_dist, min_indx);
disp(pos_mat(watch_indx, :))
disp(pos_mat(min_indx, :))

[sort_junk, indx_sort]  = sort(dist_list);
disp(sort_junk(1:16));
disp(pos_mat(indx_sort(1:9), :));