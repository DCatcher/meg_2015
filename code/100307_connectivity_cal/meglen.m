function sig=meglen(sig_o,node)
for j=1:node
    disp('converting to power')
    sig(j,:)=sum(sig_o{j}.^2,1);
end