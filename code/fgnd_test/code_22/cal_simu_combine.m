rand('seed', 0);
randn('seed', 0);
sum_errors  = 0;
test_len    = 20;

params  = struct();

neuron_num  = 10;
% neuron_num  = 20;
% sparsity    = 0.5;
params.small_control    = 3;
params.N                = 6000;
params.P                = 11;
params.gamma            = 0;
% params.configuration    = [1,1,1,1;1,1,1,1;1,1,1,1;1,1,1,1];
% params.configuration    = ones(neuron_num, neuron_num);
% params.configuration    = double(rand(neuron_num, neuron_num) < sparsity);
params.configuration    = [1,0,0;0,1,0;1,1,1];
% params.configuration    = [1,0,0,0;1,1,0,1;1,0,1,1;0,0,0,1];

% params.configuration    = eye(neuron_num);
% for indx_i=2:neuron_num-1
%     params.configuration(indx_i, 1)     = 1;
%     
%     params.configuration(indx_i, neuron_num)     = 1;
% end

% params.configuration(1, neuron_num) =1;
% params.configuration(neuron_num, 1) =1;

% params.configuration    = zeros(neuron_num, neuron_num);
% params.configuration(:,1)   = 1;
% params.configuration(neuron_num,:)      = 1;
% params.configuration(neuron_num,1)      = 0;

params.recon_P          = 11;
params.num_st           = 1;
params.num_en           = neuron_num;
params.watch_len        = 1500;
% params.innovation       = [1,1,1,1,1,1];
params.innovation       = ones(1, neuron_num);
params.mode             = 2; %0 is 2-2, 1 is MVAR, 2 is special test.
params.report_mode      = 0;
params.watch_error_mode = 1;

params.delta            = 1;

tmp_clock   = num2str(fix(clock));
params.diary_name       = ['logs/log_' tmp_clock '.txt'];

diary(params.diary_name);

disp(params);
disp(params.configuration);

for big_indx=1:test_len
    [params.data, params.arSig, params.arNoise, params.x_sig, params.x_noise, params.sigLevel, params.noiseLevel]=simulateOneRun(params.N, params.P, params.gamma, params.configuration, params);
    recon_errors    = calculate_connectivity(params);
    sum_errors    = sum_errors + recon_errors;
    fprintf('test time:%i, error now:%f\n', big_indx, sum_errors/big_indx);
    pause(0.5);
end
disp(sum_errors/test_len);

diary off