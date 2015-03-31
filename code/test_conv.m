L_sig   = 10000;
L_f     = 10;

rand('seed', 0);
fab = rand(1,L_f);
fab_flip = fliplr(fab);
fcb = rand(1,L_f);
fcb_flip = fliplr(fcb);

rand('seed', 1);

A = rand(1,L_sig) - 0.5;
C = rand(1,L_sig) - 0.5;
B = conv(A,fab) + conv(C, fcb);

% fab_all         = zeros(size(B));
% fab_all(1:L_f)  = fab;
% fcb_all         = zeros(size(B));
% fcb_all(1:L_f)  = fcb;

mat_B   = zeros(L_sig-L_f, L_f);
for indx=1:L_sig-L_f
    mat_B(indx,:)   = B(indx:indx+L_f-1);
end

mat_A   = zeros(L_sig-L_f, L_f);
for indx=1:L_sig-L_f
    mat_A(indx,:)   = A(indx:indx+L_f-1);
end

mat_C   = zeros(L_sig-L_f, L_f);
for indx=1:L_sig-L_f
    mat_C(indx,:)   = C(indx:indx+L_f-1);
end

[reg_ba, BINT, R_ba]  = regress(A(L_f:L_sig-1)', mat_B);
[reg_ab, BINT, R_ab]  = regress(B(L_f:L_sig-1)', mat_A);
[reg_cb, BINT, R_cb]  = regress(B(L_f:L_sig-1)', mat_C);