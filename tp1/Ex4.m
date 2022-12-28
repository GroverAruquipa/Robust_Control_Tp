clc;clear;close all;
K = ureal('K',5,'percent',30);   
T = ureal('T',0.5,'percent',10); 

s=tf('s');
G=[(K/(10*s+1)); (1/(T*s+1))];

step(G)