%
% pr8_5_1 
clear all; clc; close all;

load arcoeff.mat             % ����ARϵͳϵ��  
N=1000;                      % �������ݳ�
x=randn(1,N);                % ���������,��������
fs=1000;                     % ����Ƶ��
y=filter(1,ar,x);            % ϵͳ�������
nfft=512;                    % �γ�,Ҳ��FFT��
noverlap=nfft-1;             % �ص�����
wind=hanning(nfft);          % ������
% ����tfestimate��������ϵͳ���ݺ���
[Txy,F]=tfestimate(x,y,wind,noverlap,nfft,fs);
[H,f]=freqz(1,ar,[],fs);     % �������ݺ�������ֵ
% ��ͼ
figure
plot(f,abs(H),'r','linewidth',3); hold on
plot(F,abs(Txy),'k'); grid;
title('freqz��tfestimate����ıȽ�' );
xlabel('Ƶ��/Hz'); ylabel('��ֵ');
legend('����ֵ','��tfestimate�����')
set(gcf,'color','w'); 







