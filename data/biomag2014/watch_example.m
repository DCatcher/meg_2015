%% Code for watch examples from the Challenge data
function watch_example(which_example)

if nargin<1
    which_example   = -1;
end

load_data

indx    =which_example;

if which_example==-1
    indx    = 1;
end

figure
while (1)
    for neuron_j=1:3
        subplot(3,1,neuron_j)
        tmp_sig     = data(:, neuron_j, indx);
        plot(tmp_sig);
    end
    pause();
    if which_example==-1
        indx    = indx+1;
        continue;
    end 
    break;
end