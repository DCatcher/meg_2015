function multiplot(line,nodes,obj, numbers)
step=floor(nodes/(line-1));
figure;
for i=1:line
    subplot(line,1,i);
    plot(obj(:,(i-1)*step+1 - floor(i/line))); axis([0,numbers,0,5e-29])
end
