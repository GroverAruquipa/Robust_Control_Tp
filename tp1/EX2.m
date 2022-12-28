clc;clear;close all;
s=tf('s');
G11=2/(0.015*(s^2)+0.8*s+1);
G12=0.02/(0.3*s+1);
G13=-0.08/(0.4*s+1);
G21=0.04/(0.1*s+1)
G22=1/(0.04*(s^2)+1.2*(s)+1);
G23=-0.03/(s+1);
Gnom=[G11 G12 G13; G21 G22 G23]

K11=(20*(0.3*s+1)/(0.1*s+1));
K12=0;
K21=0;
K22=(30*(0.5*s+1)/(0.2*s+1));
K31=(s+1)/(0.2*s+1);
K32=(-0.4)/(0.5*s+1);
K=[K11 K12; K21 K22; K31 K32];

Gc1=feedback(Gnom,K);
step(Gc1)
figure(1)
sys=tf(Gnom/(eye(3)+K*Gnom));
step(sys)
figure(2)

sys2=tf(1/(eye(3)+K*Gnom));
step(sys2)
figure(3)

