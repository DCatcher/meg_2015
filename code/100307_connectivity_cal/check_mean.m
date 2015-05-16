load 100307_all_sig

num_neurons     = length(all_source_sig);
threshold       = 0.45;

for indx_i=1:num_neurons
    tmp_sig     = all_source_sig{indx_i};
%     fprintf('now indx_i:%i\n', indx_i);
    for indx_j=1:3
        sum_less_than_0     = sum(tmp_sig(indx_j, :)>0);
        if sum_less_than_0/size(tmp_sig, 2)<threshold
            fprintf('No!\n');
        end
    end
end