clc;clear;close all;
s=tf('s');
%%%%a
k = ureal('k',1,'percent',25);
T=ureal('T',2,'percent',25);
kc=0.15; 
Tc=0.4;
Gnom=k/(T*s+1);
K=kc*(Tc*s+1)/(Tc*s);

w1 = makeweight(0.05,2.5,5);
% w2 = makeweight(0.05,2.5,5);
W = blkdiag(w1);
Delta_1 = ultidyn('Delta_1',[1 1]);
% Delta_2 = ultidyn('Delta_2',[1 1]);
Delta = blkdiag(Delta_1);
G = (eye(1) + Delta*W)*Gnom;

Gc1=feedback(G,K);

bodemag(Gc1)
figure()%%%b
[wcg,wcu,info1] = wcgain(Gc1) %% Worstcasegain

% c maginitud respnse
semilogx(info1.Frequency,info1.Bounds)
title('Worst-Case Gain vs. Frequency')
ylabel('Gain')
xlabel('Frequency')
legend('Lower bound','Upper bound','Location','northwest')
figure()
step(Gc1) %c
figure()
%%
%%
%%Obtain for random uncertenities




