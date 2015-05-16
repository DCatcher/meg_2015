ori = randn(1000,2);
mix_mat = randn(2, 3);
% while det(mix_mat)==0
%     mix_mat = randn(3);
% end
mix_sig = ori*mix_mat;
[icasig, A, W] = fastica(mix_sig', 'numofIC',2);    

disp(A');
disp(mix_mat);
