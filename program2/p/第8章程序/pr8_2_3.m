%
% pr8_2_3 
clear all; clc; close all;

Fs=1000;                           % ����Ƶ��
N=1000;                            % ���ݳ���
n=1:N;                             % ������
t=(n-1)/Fs;                        % ʱ������
randn('state',0);                  % �������������ʼ��
f1=50; f2=120;                     % �������ҷ���Ƶ��
x=cos(2*pi*f1*t)+3*cos(2*pi*f2*t)+randn(size(t)); % �ź�
    
% ����ͼ��
window=boxcar(N);                  % ������
nfft=1000;                         % FFT��
[Pxx1,f]=periodogram(x,window,nfft,Fs); % ����ͼ
sqrt(sum(Pxx1)*Fs/nfft)            % ��������ͼ��ƽ������

% welch��
Nfft=128;
window=boxcar(Nfft);               % ѡ�õĴ���
noverlap=100;                      % �ֶ������ص��Ĳ������������ȣ�
range='onesided';                  % ������
[Pxx2,freq]=pwelch(x,window,noverlap,Nfft,Fs,range);  %����Welch�������ƹ�����
plot_Pxx=10*log10(Pxx2);
sqrt(sum(Pxx2)*Fs/Nfft)            % ����welch��ƽ������

% ��ͼ
plot(f,10*log10(Pxx1),'r');        % �������̶�ͼ
hold on; axis([0 500 -50 10]);     
xlabel('Ƶ��/Hz');
ylabel('�������ܶ�/(dB/Hz)');
plot(freq,plot_Pxx,'k'); 
title('����ͼ����welch���Ƚ�');
legend('����ͼ��','welch��')
set(gcf,'color','w');

