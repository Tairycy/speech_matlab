clc;
close all;
clear all;
% �ⲻ��sin�������Ƶ��Ӧ�ķ�ʽ
t=-5:0.01:4.99;
x=sin(2*pi*t);
plot(t, x);
X=fft(x);
Y=fft(x(1:50));
Z=fft(x(1:100));
figure;
plot(abs(X));
hold on;
plot(abs(Y), '*');
hold on;
plot(abs(Z));

% �ⲻ�Ǵ������ķ�Ƶ��Ӧ��ķ�ʽ
x1=zeros(1, 100);
x1(40:1:59)=1;
y1=fft(x1);
figure;
plot(abs(y1));

%{
--------------------------------------------------------------------------- 
File:Matlab�Ĵ�����,���δ�                               
���ܣ������԰�ˮƽ
������ 
--------------------------------------------------------------------------- 
%}
%N =51 
%==========================================================================
%����δ���Ƶ����Ӧͼ  
%==========================================================================
W = linspace(-pi,pi,4096);
wn0 = rectwin(20);   %���δ����� 
%20*log10(abs(WN))  
[h1,w0] = freqz(wn0,1,W); 
%subplotfigure(5,1,1);  
figure;
plot(w0/pi,20*log10(abs(h1/max(h1))));  
axis([-1 1 -100 0]); 
xlabel('��һ��Ƶ�� /\pi');  
ylabel('20log_{10}|W(e^{j\omega})| /dB');  
title('���δ��ĸ���Ҷ�任'); 
set(gca,'YTick',[-100 -80 -60 -40 -20 0])  
set(gca,'XTick',[-1 :0.2: 1])   
%set(gca,'XAxisLocation','top');%����X�����Ϸ�  
set(gca,'XAxisLocation','bottom');%����X�����·�  
set(gca,'YAxisLocation','left'); %����Y������  
text(1,-124,'\pi');%gtext('\pi');
figure;
plot(w0/pi, phase(h1));
