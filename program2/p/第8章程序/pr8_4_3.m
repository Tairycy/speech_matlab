% 
% pr8_4_3 
clear all; clc; close all;

randn('state',0);                    % �������ʼ��
Fs = 1000;                           % ����Ƶ��
t = 0:1/Fs:1-1/Fs;                   % ʱ��̶�
f1=50; f2=120;                       % �������ҷ���Ƶ��
x=cos(2*pi*f1*t)+3*cos(2*pi*f2*t)+randn(size(t)); % �ź�
nfft=1024;                           % FFT���� 
p=12;                                % ARģ�ͽ���
% ����burg����
[Pxx1,freq1]=pburg(x,p,nfft,Fs);

% ����spectrum.burg��psd����
Hd=spectrum.burg(p);
Ps=psd(Hd,x,'Fs',Fs,'NFFT',nfft);
% ȡ���������ܶȺ�Ƶ����ֵ
Pxx2=Ps.data;
freq2=Ps.frequencies;
% ��ͼ
subplot 211
plot(freq1,10*log10(Pxx1),'k');      % ȡ������ͼ
grid on; xlim([0 Fs/2]);
title('����pburg�����ĸĽ�����ͼ')
xlabel('Ƶ��/Hz')
ylabel('�������ܶ�/(dB/Hz)')
subplot 212
plot(freq2,10*log10(Pxx2),'k');      % ȡ������ͼ
grid on; xlim([0 Fs/2]);
title('����spectrum.burg�����ĸĽ�����ͼ')
xlabel('Ƶ��/Hz')
ylabel('�������ܶ�/(dB/Hz)')
mxerr = max(Pxx1-Pxx2)                 % �����ַ���������ֵ
set(gcf,'color','w'); 
