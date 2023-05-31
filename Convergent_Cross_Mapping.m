function [Ca_xy, Ca_yx] = ccm(X, Y)

% Parameters below represents good approximation for cardio-post
% signals[tau=8-10 and embedding dimesion=4 (approx)]

tau = 10; % time step
E   = 4; % dimension of reconstruction

L=numel(X);
T=1+(E-1)*tau;
Xm=zeros((L-T+1),E);
Ym=zeros((L-T+1),E);
SugiN=E+1;
N = L-T+1;

% RECONTRUCTIONS OF ORIGINAL SIGNALS

for t=1:(L-T+1)
    Xm(t,:)=X((T+t-1):-tau:(T+t-1-(E-1)*tau));
    Ym(t,:)=Y((T+t-1):-tau:(T+t-1-(E-1)*tau));
end
%
% Vector to filled by estimated time series
estX=zeros(N,1);
estY=zeros(N,1);

origY=Y(T:end);
origX=X(T:end);

for j=1:N
    % neighborhood search, weighting, and estimation X (using nearest neighbor
    % of Y) and Y (using nearest neighbor of X)
    
    [n1,d1]=knnsearch(Xm,Xm(j,:),'k',E+2,'distance','euclidean');
    [n2,d2]=knnsearch(Ym,Ym(j,:),'k',E+2,'distance','euclidean');
    
    esY=origY(n1(2:end));
    esX=origX(n2(2:end));
    esY1=esY(1:SugiN);
    esX1=esX(1:SugiN);
    Sugid1=d1(:,2:SugiN+1);
    Sugid2=d2(:,2:SugiN+1);
    
    u1=exp(-Sugid1./(Sugid1(:,1)*ones(1,SugiN)));
    u2=exp(-Sugid2./(Sugid2(:,1)*ones(1,SugiN)));
    w1=u1./(sum(u1,2)*ones(1,SugiN));
    w2=u2./(sum(u2,2)*ones(1,SugiN));
    estY(j)= w1*esY1; %Estimated Y (EMG)
    estX(j)= w2*esX1; %Estimated X (SBP)
    
end

% figure;plot(origX);
% hold on;plot(estX,'r');
% legend('Origial','Estimated');
% figure;plot(origY);
% hold on;plot(estY,'r');
% legend('Original','Estimated');
% 
CorrX_Y=corrcoef(origX,estX);
Ca_xy = CorrX_Y(1,2);% X->Y
CorrY_X=corrcoef(origY,estY);
Ca_yx = CorrY_X(1,2); %Y->X

return