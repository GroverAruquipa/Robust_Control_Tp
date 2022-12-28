clc;clear;close all
s = tf('s');
g11 = 12/(0.2*s + 1);
g12 = -0.05/(0.1*s + 1);
g21 = 0.1/(0.3*s + 1);
g22 = 5/(0.7*s - 1);
Gnom = [g11 g12;g21 g22];
w1 = makeweight(0.1,20,10);
w2 = makeweight(0.2,25,10);
W = blkdiag(w1,w2);
Delta_1 = ultidyn('Delta_1',[1 1]);
Delta_2 = ultidyn('Delta_2',[1 1]);
Delta = blkdiag(Delta_1,Delta_2);
G = (eye(2) + Delta*W)*Gnom;
Gd = 10/s;
[K,cls,gam] = loopsyn(Gnom,Gd);
omega = logspace(-1,3,100);
looptransfer = loopsens(Gnom,K);
L = looptransfer.Lo;
sigma(L,'r-',Gd,'b--',Gd/gam,'k-.',Gd*gam,'k-.',omega)

W1 = (s + 10)/(2*s + 0.3);
W3 = (s + 10)/(0.05*s + 20);
[K_h,cl_h,gam] = mixsyn(Gnom,W1,[],W3);

looptransfer = loopsens(Gnom,K_h);
L = looptransfer.Lo;
T = looptransfer.To;
I = eye(size(L));
figure(1)
omega = logspace(-1,3,100);
sigma(I+L,'b-',W1/gam,'r--',T,'b-.',gam/W3,'r.',omega)
grid
legend('1/\sigma(S) performance', ...
'\sigma(W1) performance bound', ...
'\sigma(T) robustness', ...
'\sigma(1/W3) robustness bound',3)
figure(2)
omega = logspace(-1,3,100);
sigma(L,'b-',W1/gam,'r--',gam/W3,'r.',omega)
grid
legend('$\sigma(L)$','$\sigma(W1) performance bound$','$\sigma(1/W3) robustness bound$',3)

