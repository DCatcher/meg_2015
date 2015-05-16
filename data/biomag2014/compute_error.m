function score_est  = compute_error(input_file)

load(input_file)
load true

score_est   = 0;

right_num   = 0;
wrong_num   = 0;

for idx_i=1:size(estimaConfiguration, 3)
    for idx_j=1:3
        for idx_k=1:3
            if idx_j==idx_k
                continue;
            end
            true_tmp    = trueConfiguration(idx_j, idx_k, idx_i);
            esti_tmp    = estimaConfiguration(idx_j, idx_k, idx_i);
            if esti_tmp==1
                if true_tmp==1
                    score_est   = score_est + 1;
                    right_num   = right_num + 1;
                else
                    score_est   = score_est - 3;
                    wrong_num   = wrong_num + 1;
                end
            end
        end
    end
end

fprintf('right num:%i, wrong num:%i\n', right_num, wrong_num)
fprintf('score last:%i\n', score_est);
