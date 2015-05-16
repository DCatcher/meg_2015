function test_for_phase

M       = 3;
N       = 6000;
P       = 10;
gamma   = 3;
conf    = randn(M)>0;

data_now    =simulateOneRun(N,P,gamma,conf);

recon_P     = 10;

fprintf('for gamma:%f\n', gamma);

for indx_i=1:M
    [mat_reg, reg_error]    = MVAR_ml(data_now, size(data_now, 1), recon_P, indx_i);
    mat_reg_phase   = zeros(size(mat_reg));
    for indx_j=1:M
        mat_reg_phase(indx_j, :)    = phase(mat_reg(indx_j, :));
    end
    phase_diff      = sum(abs(mat_reg_phase(1,:) - mat_reg_phase(2,:)) + abs(mat_reg_phase(1,:) - mat_reg_phase(3,:)));
    fprintf('phase diff for indx %i:%f\n', indx_i, phase_diff);
end