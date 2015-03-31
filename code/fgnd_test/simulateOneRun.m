function [data, arSig, arNoise, x_sig, x_noise, sigLevel, noiseLevel]=simulateOneRun(N,P,gamma,configuraton, params)
%Generates one sample for the causality challenge
%
% Input:
% N:     number of time points
% P:     order of AR-system
% gamma: parameter controlling the relative strength of noise
%        and signal, gamma=0 means only signal, gamma=1 means only noise
% conf:  3x3 matrix with binary elements defining (the presence of) causal
%        interactions. A causal influence from channel i to j exists
%        if conf(i,j)==1. Note that diagonal elements will be ignored! 
%           Note alo that AR matrices have a 'transpose meaning', 
%           i.e. interaction from i to j are represented in matrix
%           elements A(j,i) with A an AR matrix at some delay). 
%      
%
% Output:
% data:  Nx3 matrix of data
%
%
% Every sample of the challenge was generated with the commands:
% N=6000; 
% P=10;
% gamma=rand;
% conf=randn(3)>0;
% data=simuldata_biomag(N,P,gamma,conf)
%
% ... success!!             Guido & Andreas

M=length(configuraton);

% for i=1:M;
%     configuraton(i,i)=1;
% end

sSignal=1-gamma;
sNoise=gamma;

done=false;
try_time    = 0;
small_control   = 2.2;

while ~done
    
    arSig=zeros(M,M*P);
    for k=1:P

        aloc=(rand(M)-.5)/small_control;
        arSig(:,(k-1)*M+(1:M))=aloc.*configuraton';

    end
    
    E=eye(M*P);
    A=[arSig;E(1:end-M,:)];
    lambdaMax=max(abs(eig(A)));
    
    arNoise=zeros(M,M*P);
    for k=1:P;

        aloc=diag(diag((rand(M)-.5)/small_control));
        arNoise(:,(k-1)*M+(1:M))=aloc;

    end
    
    E=eye(M*P);
    Anoise=[arNoise;E(1:end-M,:)];
    lambdaMaxNoise=max(abs(eig(Anoise)));
    
    try_time    = try_time + 1;
    fprintf('try time:%i, lambdaMax:%f, lambdaMax_Noise:%f.\n',try_time, lambdaMax, lambdaMaxNoise);
    
    if lambdaMax<.95 && lambdaMaxNoise<.95;
        
%         x=zeros(M,N);
%         x(:,1:P)=randn(M,P);
%         x   = zeros(M, N);
%         x(3, :)     = randn(1, N);
        x   = zeros(M,N);
        for indx_i=1:M
            if params.innovation(indx_i)==1
                x(indx_i, :)    = randn(1, N);
            end
        end
        
        x_sig   = x;
        dataSignal=mymvfilter(arSig,x)';
        sigLevel=norm(dataSignal,'fro');

%         x=zeros(M,N);
%         x(:,1:P)=randn(M,P);
        x   = randn(M,N);
        x_noise     = x;
        dataNoise=mymvfilter(arNoise,x)'*randn(M);
        noiseLevel=norm(dataNoise,'fro');

        data=sSignal*( dataSignal/sigLevel )+sNoise*( dataNoise/noiseLevel );

        done=true;
        
    end
    
end

%% filter function
function y=mymvfilter(ar,x)
[nChan,nOrder]=size(ar);
nOrder=nOrder/nChan;

arReshape=zeros(nChan,nChan,nOrder);
for i=1:nOrder;
    arReshape(:,:,i)=ar(:,(i-1)*nChan+1:i*nChan);
end

N=size(x,2);
y=x;
for i=2:N;

    nOrderLoc=min([i-1,nOrder]);
    for j=1:nOrderLoc;
        y(:,i)=y(:,i)+arReshape(:,:,j)*y(:,i-j);
    end
    
end