% function re=avgpower(Nsamples,windowsize,step,sig)
% subject={'106521','108323','109123','113922','162026','204521','599671','725751'};

indx_list       = {'0', '4', '8', '12', '16', '20', '24', '36'};

all_len         = length(indx_list);
% basepath= 'E:/MEG/new_sig_rmeg';
window=cell(1,all_len);
for n=1:all_len
%     cd([basepath,subject{n}]);
%     addpath(genpath(pwd));
    indx_now    = indx_list{n};
    disp(['processing time ',indx_now]);
    load(['106521_rpower_', indx_now]);
%     avg=cell(1,100);
    Nsamples=750;
    windowsize=40;
    step=20;
    num=floor((Nsamples-windowsize)/step)+1;
    % figure;
    avg=zeros(751,num);
    for i=1:num
        disp(['processing window',num2str(i)]);
%         for j=1:100
        avg(:,i)=mean(sig(:,(i-1)*step+1:(i-1)*step+windowsize),2);
%         end
    end
    save(['106521_window_', indx_now],'avg');
    window{n}=avg;
end
save('window_all_time.mat','window');
% multiplot(floor(num/2),num,re{1});
    