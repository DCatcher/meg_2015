% N       = 6000;
% P       = 10;
% gamma   = 0;
% configuration   =[1,0,0;0,1,0;0,0,1];

% disp(configuration);

params  = struct();

params.N                = 6000;
params.P                = 10;
params.gamma            = 0;
params.configuration    = [1,0,0;0,1,0;0,0,1];
params.recon_P          = 2*params.P - 1;
params.num_st           = 3;
params.num_en           = 1;
params.watch_len        = 1500;
params.innovation       = [1,1,1];

[params.data, params.arSig, params.arNoise, params.x_sig, params.x_noise, params.sigLevel, params.noiseLevel]=simulateOneRun(params.N, params.P, params.gamma, params.configuration, params);

save data_frequency