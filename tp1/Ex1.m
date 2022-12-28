clc;clear;close all;
s=tf('s'); %Define S as Laplace variable
G=[(1/(s-1)) 0;0 (1/(s+1))];
K=[(s-1)/(s+1) 1;0 1];
looptransfer = loopsens(G,K);
omega = logspace(-3,3,100);
Lo = looptransfer.Lo;
sigma(Lo ,'r-',omega)
hold on
title('Singular Values of Lo')
figure(1)
title('Lo')
Li = looptransfer.Li;
sigma(Li ,'r-',omega)
hold on
title('Singular Values of Li')
figure(2)
title('Li')
Ti = looptransfer.Ti;
sigma(Ti ,'r-',omega)
hold on
title('Singular Values of Ti')
figure(3)

To = looptransfer.To;
sigma(To ,'r-',omega)
hold on
title('Singular Values of To')
figure(4)

Si = looptransfer.Si;
sigma(Si ,'r-',omega)
hold on
title('Singular Values of Si')
figure(5)

So = looptransfer.So;
sigma(So ,'r-',omega)
hold on
title('Singular Values of So')
figure(6)
title('Singular Values of So')
