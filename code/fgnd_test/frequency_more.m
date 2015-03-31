N       = 6000;
P       = 10;
gamma   = 0;
configuration   =[0,0,0;1,0,0;1,1,0];

% disp(configuration);

[data, arSig, arNoise, x_sig, x_noise, sigLevel, noiseLevel]=simulateOneRun(N,P,gamma,configuration);

save data_frequency