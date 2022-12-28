clc;clear;close all;
s=tf('s');


G11=-s+2;
G12=2*s+1;
G21=-3;
G22=-s+2; 
coef=1/(s^2+2*s+4);
Gnom=coef*[G11 G12; G21 G22];

k11=-s+2;
k12=-2*(s+1);
k21=3;
k22=-s+2;
K=(2*(s+2)*(s^2+2*s+4))/(s*(s+1)*(s^2+2*s+7))*[k11 k12; k21 k22];

w1 = makeweight(0.02,10,2);
w2 = makeweight(0.02,10,2);
W = blkdiag(w1,w2);
Delta_1 = ultidyn('Delta_1',[1 1]);
Delta_2 = ultidyn('Delta_2',[1 1]);
Delta = blkdiag(Delta_1,Delta_2);
G = (eye(2) + Delta*W)*Gnom;
Gc1=feedback(G,K);
[stabmarg,destabunc,report,info] = robuststab(Gc1)
step(Gc1)
%ex7
[perfmarg,wcu,report2,info2] = robustperf(Gc1)