function re=avgpower(Nsamples,windowsize,step,sig)
re={};
% Nsamples=611;
% windowsize=40;
% step=20;
num=floor((Nsamples-windowsize)/step)+1;
figure;
for i=1:num
    re{1}(:,i)=mean(sig{1,1}(:,(i-1)*step+1:(i-1)*step+windowsize),2);
    re{2}(:,i)=mean(sig{1,2}(:,(i-1)*step+1:(i-1)*step+windowsize),2);
    re{3}(:,i)=mean(sig{1,3}(:,(i-1)*step+1:(i-1)*step+windowsize),2);
    re{4}(:,i)=mean(sig{1,4}(:,(i-1)*step+1:(i-1)*step+windowsize),2);
end
multiplot(floor(num/2),num,re{1});
    