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

W1 = (s + 10)/(2*s + 0.3);
W3 = (s + 10)/(0.05*s + 20);
[K_h,cl_h,gam] = mixsyn(Gnom,W1,[],W3);



looptransfer = loopsens(Gnom,K_h);
L = looptransfer.Lo;
T = looptransfer.To;
S = looptransfer.So;
I = eye(size(L));
figure(1)
omega = logspace(-1,3,100);
sigma(I+L,"b-",W1/gam,"r--",T,"b-.",gam/W3,"r.",omega)
grid
legend("1/\sigma(S) performance","\sigma(W1) performance bound","\sigma(T) robustness","\sigma(1/W3) robustness bound")
figure(2)
omega = logspace(-1,3,100);
sigma(L,"b-",W1/gam,"r--",gam/W3,"r.",omega)
grid
legend("\sigma(L)","\sigma(W1) performance bound","\sigma(1/W3) robustness bound")


figure (3)
step(T)
