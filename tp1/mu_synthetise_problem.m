%%%mu Synthesis problem
clc;clear;close all
k1 = ureal('k1',12,'Percentage',[-15, 15]);
k2 = ureal('K2',5,'Percentage',[-15, 15]);
t1 = ureal('t1',0.2,'Percentage',[-20, 20]);
t2 = ureal('t2',0.7,'Percentage',[-20, 20]);

s = tf('s');
G=[k1/(t1*s+1) (-0.05)/(0.1*s+1);(0.1)/(0.3*s+1) k2/(t2*s-1)];
wp=0.5*(s+10)/(s+0.3);
wu=0.1*(0.001*s+1)/(1*s+1);
Wu = blkdiag(wu,wu);
Wp = blkdiag(wp,wp);
P = augw(G,Wu,Wp,[]);
[K1,CL,gamma] = hinfsyn(P,2,2)
systemnames =' G Wp Wu';
inputvar ='[ ref{2}; dist{2}; control{2} ]';
outputvar ='[ Wp; Wu; ref-G-dist ]';
input_to_G ='[ control ]';
input_to_Wp ='[ ref-G-dist ]';
input_to_Wu ='[ control ]';
sys_ic = sysic;

[K,CLperf,info] = musyn(sys_ic,2,2) ;
%%% Lower_lft
clp_ic = lft(sys_ic,K);
omega = logspace(-2,2,100);
clp_g = ufrd(clp_ic,omega);

% rng(0);    % for reproducibility
% bode(clp_g,'r',clp_g.NominalValue,'b+') 

%
%% Robust stability
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report

semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust Stability')
xlabel('Frequency (rad/s)')

%%
% Robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
%%

semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
xlabel('Frequency (rad/s)')
