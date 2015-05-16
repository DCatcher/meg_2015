tmp_clock   = num2str(fix(clock));
name_log    = ['logs/log_' tmp_clock '.txt'];

diary(name_log);

threshold_pos_list  = 0.45:0.05:0.7;
score_list  = [];

recon_P_now     = 10;
test_num        = 1000;

for threshold_indx  = 1:length(threshold_pos_list)
    fprintf('now threshold pos:%f, now recon_P:%i\n', threshold_pos_list(threshold_indx), recon_P_now);
    easy_estimation(0, 'tmp_save', test_num, threshold_pos_list(threshold_indx), recon_P_now);
    score_list(end+1)   = compute_error('tmp_save');
end

plot(threshold_pos_list, score_list);

save('result_est_10', 'score_list');

diary off