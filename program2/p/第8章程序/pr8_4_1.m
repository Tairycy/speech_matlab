% 
% pr8_4_1 
clear all; clc; close all;

randn('state',0);                    % �������ʼ��
Fs = 1000;                           % ����Ƶ��
t = 0:1/Fs:1-1/Fs;                   % ʱ��̶�
f1=50; f2=120;                       % �������ҷ���Ƶ��
x=cos(2*pi*f1*t)+3*cos(2*pi*f2*t)+randn(size(t)); % �ź�
N = length(x);                       % x����
% ����periodogram����
[Pxx,f]=periodogram(x,rectwin(length(x)),N,Fs);

% ����spectrum.periodogram��psd����
Hd=spectrum.periodogram('Rectangular');
Ps=psd(Hd,x,'Fs',Fs,'NFFT',N);
% ȡ���������ܶȺ�Ƶ�ʲ���
Pxx1=Ps.data;
f1=Ps.frequencies;
% ��ͼ
subplot 211
plot(f,10*log10(Pxx),'k');           % ȡ������ͼ
grid on; xlim([0 Fs/2]);
title('����periodogram����������ͼ')
xlabel('Ƶ��/Hz')
ylabel('�������ܶ�/(dB/Hz)')
subplot 212
plot(f1,10*log10(Pxx1),'k');          % ȡ������ͼ
grid on; xlim([0 Fs/2]);
title('����spectrum.periodogram����������ͼ')
xlabel('Ƶ��/Hz')
ylabel('�������ܶ�/(dB/Hz)')
mxerr = max(Pxx-Pxx1)                 % �����ַ���������ֵ
set(gcf,'color','w'); 
