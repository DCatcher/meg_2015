% subject={'106521','108323','109123','113922','162026','204521','599671','725751'};
% indx_list       = {'0', '4', '8', '12', '16', '20', '24', '36'};

indx_list       = {'599671', '725751', '204521'};

% time_list       = {'10', '20', '30', '40', '50', '60', '70', '80'};
time_list       = cell(33, 1);
for indx_i=1:33
    time_list{indx_i}   = int2str(3*indx_i);
end

data_prefix     = 'sub_time_new_sigs_for_lg/';
data_suffix     = '_new_sig_sub_time_';

% basepath= 'E:/MEG/new_sig_rmeg';
for n=1:length(indx_list)
%     cd([basepath,subject{n}]);
%     addpath(genpath(pwd));
    indx_now    = indx_list{n};
    pref=['106521_new_sig_', indx_now];
    disp(['processing time ',indx_now]);
%     sig=cell(1,40);
%     for i=1:40
        load([pref '.mat']);
%         disp([num2str(i)]);
        sig=zeros(751,750);
        for j=1:751
            sig(j,:)=sum(all_source_sig{j}.^2,1);
        end
%     end
    save(['106521_rpower_', indx_now],'sig');
%      for i=41:80
%         load([pref,num2str(i),'.mat']);
%         disp([num2str(i)]);
%         for j=1:8004
%     %         disp([num2str(j)]);
%             sig{i-40}(j,:)=sum(sourcedata{j}.^2,1);
%         end
%      end
%     save([subject{n},'_power2.mat'],'sig')
end