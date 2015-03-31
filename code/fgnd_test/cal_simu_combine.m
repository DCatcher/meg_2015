rand('seed', 0);
randn('seed', 0);
sum_errors  = 0;
test_len    = 20;

params  = struct();

params.N                = 6000;
params.P                = 10;
params.gamma            = 0;
params.configuration    = [0,0,0;1,0,0;1,1,0];
params.recon_P          = 2*params.P - 1;
params.num_st           = 3;
params.num_en           = 1;
params.watch_len        = 1500;
params.innovation       = [0,0,1];

disp(params);

for big_indx=1:test_len
    fprintf('test time:%i\n', big_indx);
    [params.data, params.arSig, params.arNoise, params.x_sig, params.x_noise, params.sigLevel, params.noiseLevel]=simulateOneRun(params.N, params.P, params.gamma, params.configuration, params);
    recon_errors    = calculate_connectivity(params);
    sum_errors      = sum_errors + recon_errors;
    pause();
end

disp(sum_errors/test_len);