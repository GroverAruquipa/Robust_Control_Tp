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

G = [g11 g12;g21 g22];

wp=0.95*(s^2+2000*s+4000)/(s^2+1900*s+10);
wn=10^(-6)*(0.1*s+1)/(0.001*s+1);

Wp=[wp 0; 0 wp];
Wu=[wn 0; 0 wn];

figure;
systemnames = 'G Wp Wu';
inputvar = '[ ref{2}; dist{2}; control{2} ]';
outputvar = '[ Wp; Wu; ref-G-dist ]';
input_to_G = '[ control ]';
input_to_Wp = '[ ref-G-dist ]';
input_to_Wu = '[ control ]';
sys_ic = sysic;


nmeas = 2;
ncont = 2;
fv = logspace(-3,3,100);
opt = dkitopt('FrequencyVector',fv, 'DisplayWhileAutoIter','on', 'NumberOfAutoIterations',3)
[K,cl_mu,bnd_mu,dkinfo] = dksyn(sys_ic,nmeas,ncont,opt)
clp_ic = lft(sys_ic,K);
omega = logspace(-2,2,100);
clp_g = ufrd(clp_ic,omega)

% Robust stability
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report
figure;
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust Stability')
legend('Lower bound', 'Upper bound')
xlabel('Frequency (rad/s)')
% Robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
figure;
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
legend('Lower bound', 'Upper bound')
xlabel('Frequency (rad/s)')


[K_h,cl_h,gam] = mixsyn(G,Wp,[],Wu);

looptransfer = loopsens(G,K_h);
L = looptransfer.Lo;
T = looptransfer.To;
S = looptransfer.So;
I = eye(size(L));
figure;
omega = logspace(-2,2);
sigma(1/Wp,'r--',S,'b-.',omega)
title('Singular values with uncertainty')
grid
legend('1/Wp', 'S')
figure;
omega = logspace(-1,3,100);
title('Singular values with uncertainty')
sigma(1/Wu,'r--',K*S,'r.',omega)
grid
legend('1/Wu', 'K*S')

figure;
step(T)

