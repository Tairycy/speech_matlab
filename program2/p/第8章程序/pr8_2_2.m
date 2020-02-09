%
% pr8_2_2 
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
sqrt(sum(Pxx1)*Fs/nfft)             % ��������ͼ��ƽ������
    
% ���ͼ��
nfft=1000;                         % FFT��
cxn=xcorr(x,500,'biased');         % ����ƫ����غ������ӳ�ֻ��N/2
cxn=cxn(1:nfft).*bartlett(nfft)';  % ����bartlett������
CXk=fft(cxn,nfft)/Fs;              % ���㹦�����ܶ�
Pxx2=abs(CXk);                     % ȡ��ֵ
ind=1:nfft/2;                      % ����ȡһ��,Ϊȡ��Ƶ�ʲ���
freq=(0:nfft-1)*Fs/nfft;           % Ƶ�ʿ̶�
plot_Pxx=Pxx2(ind);                % ȡ��Ƶ�ʲ���
plot_Pxx(2:end)=plot_Pxx(2:end)*2; % ������,��2->nfft/2�ⲿ�ַ�ֵ��2
sqrt(sum(Pxx2)*Fs/nfft)             % ��������ط�ƽ������

% ��ͼ
plot(f,10*log10(Pxx1),'r');        % �������̶�ͼ
hold on; axis([0 500 -50 10]);     
xlabel('Ƶ��/Hz');
ylabel('�������ܶ�/(dB/Hz)');
plot(freq(ind),10*log10(plot_Pxx),'k'); % ��������ͼ
title('����ͼ�������ͼ���Ƚ�');
legend('����ͼ��','�����ͼ��')
set(gcf,'color','w');

