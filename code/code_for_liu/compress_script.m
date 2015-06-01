input_mne   = cell(8,1);

input_mne{1}    = '106521_MEG_3-Restin_icamne.mat';
input_mne{2}    = '108323_MEG_3-Restin_icamne.mat';
input_mne{3}    = '109123_MEG_3-Restin_icamne.mat';
input_mne{4}    = '113922_MEG_3-Restin_icamne.mat';
input_mne{5}    = '116524_MEG_3-Restin_icamne.mat';
input_mne{6}    = '149741_MEG_3-Restin_icamne.mat';
input_mne{7}    = '162026_MEG_3-Restin_icamne.mat';
input_mne{8}    = '187547_MEG_3-Restin_icamne.mat';

compress_indx(input_mne, 'compress_result_8_resting', 14, 1.7, 1)