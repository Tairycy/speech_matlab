%
% pr8_5_3
clear all; clc; close all;

load seismicdata.mat         % ��������
N=length(x);                 % ���ݳ���
time=(0:N-1)/fs;             % ʱ��̶�

M=1024;                      % ����
noverlap=M/2;                % �ص�����
w=hanning(M);                % ѡ��hanning��
nfft=1024;                   % FFt�ı任����
[cxy,fxy]=mscohere(x,y,w,noverlap,nfft,fs);    % ������ɺ���ֵ 
% ��ͼ
figure(1)
subplot 211; plot(time,x,'k'); xlim([0 max(time)]);
title('�����źŵ�1ͨ��x�Ĳ���ͼ');
xlabel('ʱ��/s'); ylabel('��ֵ')
subplot 212; plot(time,y,'k'); xlim([0 max(time)]);
title('�����źŵ�2ͨ��y�Ĳ���ͼ');
xlabel('ʱ��/s'); ylabel('��ֵ')
set(gcf,'color','w'); 

figure(2)
plot(fxy,cxy,'k');
title(['M=' num2str(M) '��ɺ�������ͼ']);
xlabel('Ƶ��/Hz'); ylabel('��ɺ���'); xlim([0 fs/2]);
set(gcf,'color','w'); 
