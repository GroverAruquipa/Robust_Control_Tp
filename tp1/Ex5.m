clc;clear;close all;
s=tf('s');

K1 = ureal('K1',7.2,'percent',45);   
T1 = ureal('T1',0.9,'percent',45); 
K2 = ureal('K2',-3,'percent',45);   
T2 = ureal('T2',1.2,'percent',45); 
K3 = ureal('K3',2,'percent',45);   
T3 = ureal('T3',3,'percent',45); 
K4 = ureal('K4',5,'percent',45);   
T4 = ureal('T4',0.7,'percent',45); 

G11=K1/((T1*s)+1);
G12=K2/((T2*s)+1);
G21=K3/((T3*s)+1);
G22=K4/((T4*s)-1);
Gnom=[G11 G12 ; G21 G22]

k11=(10*(s+1))/(0.3*s+1);
k12=0;
k21=0;
k22=(15*(s+2))/(s+1)
K=[k11 k12; k21 k22]

Gc1=feedback(Gnom,K);
[stabmarg,destabunc,report,info] = robuststab(Gc1)
%report(var) for report
%ex7
[perfmarg,wcu,report2,info2] = robustperf(Gc1)

