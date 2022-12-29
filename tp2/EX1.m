close all; clear all; clc;

s=tf('s');

k1 = ureal('k1',12,'percent',15);
k2 = ureal('k2',5,'percent',15);

T1 = ureal('T1',0.2,'percent',20);
T2 = ureal('T2',0.7,'percent',20);

g11=k1/(T1*s+1);
g12=-0.05/(0.1*s+1);
g21=0.1/(0.3*s+1);
g22=k2/(T2*s-1);

Gnom = [g11 g12;g21 g22];
%%

% w1 = makeweight(0.1,20,10);
% w2 = makeweight(0.2,25,10);
% W = blkdiag(w1,w2);
% Delta_1 = ultidyn("Delta_1",[1 1]);
% Delta_2 = ultidyn("Delta_2",[1 1]);
% Delta = blkdiag(Delta_1,Delta_2);
% G = (eye(2) + Delta*W)*Gnom;
%%
%% increasing the gain increases performance in the low frequencies while dicreasing it increases performance in the higher frequencies%%
Gd = 1.75/s;  %%change values
[K,cls,gam] = loopsyn(Gnom,Gd);
omega = logspace(-1,3,100);
looptransfer = loopsens(Gnom,K);
L = looptransfer.Lo;

figure (1)
sigma(L,"r-",Gd,"b--",Gd/gam,"k-.",Gd*gam,"k-.",omega)

figure (2)
omega = logspace(-1,3,100);
I = eye(size(L));
T = looptransfer.To;
sigma(I+L,"r-",T,"b--",omega);
grid
legend("1/\sigma(S) performance","\sigma(T) robustness")

figure (3)
omega = logspace(-1,3,100);
I = eye(size(L));
S = looptransfer.So;
sigma(I+L,"r-",S,"b--",omega);
grid
legend("1/\sigma(S) performance","\sigma(s) robustness")

figure (4)
step(T)
