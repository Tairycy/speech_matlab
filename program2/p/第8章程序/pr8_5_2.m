%
% pr8_5_2 
clear all; clc; close all;

randn('state',0);                  % �������ʼ��
h = ones(1,10)/10;                 % �˲���1ϵ��
h1 = fir1(30,0.2,rectwin(31));     % �˲���2ϵ��
r = randn(16384,1);                % ���������
x = filter(h,1,r);                 % ������1·�ź�x
y = filter(h1,1,r);                % ������2·�ź�y

N=length(x);                       % ���ݵ㳤��
[H,wh]=freqz(h,1);                 % �˲���1����Ӧ����
[H1,wh1]=freqz(h1,1);              % �˲���2����Ӧ����

wind=hamming(1024);                % ���ú�����,����1024
noverlap=512;                      % �ص�����
Nfft=1024;                         % FFT�任����
PY1=pwelch(x,wind,noverlap,Nfft);  % ���1·�ź�����
PY2=pwelch(y,wind,noverlap,Nfft);  % ���2·�ź�����
[CY12,w1]=cpsd(x,y,wind,noverlap,Nfft);   % ���1·�͵�2·�źŵĻ���
Co12=abs(CY12).^2./(PY1.*PY2);     % ��(8-5-5)������ɺ���
[CR,w2]=mscohere(x,y,wind,noverlap,Nfft); % ����mscohere����������ɺ���
mcof=max(abs(Co12-CR))             % �����ַ����Ĳ�ֵ
% ��ͼ
figure(1)
subplot 211; plot(x,'k'); title('��1·�ź�x����');
ylabel('��ֵ'); xlabel('����'); axis([0 N -1.2 1.2]);
subplot 212; plot(y,'k'); title('��2·�ź�y����');
ylabel('��ֵ'); xlabel('����'); axis([0 N -1.2 1.2]);
set(gcf,'color','w'); 
figure(2)
subplot 211; plot(wh/pi,20*log10(abs(H)),'k'); grid;
ylim([-60 10]); title('�˲���1��ֵ��Ӧ����');
ylabel('��ֵ/dB'); xlabel('��һ��Ƶ��/pi');
subplot 212; plot(wh1/pi,20*log10(abs(H1)),'k'); grid;
ylim([-70 10]); title('�˲���2��ֵ��Ӧ����');
ylabel('��ֵ/dB'); xlabel('��һ��Ƶ��/pi');
set(gcf,'color','w'); 
figure(3)
plot(w1/pi,Co12,'r','linewidth',2);
hold on; grid;
plot(w2/pi,CR,'k');
legend('�������׺ͻ���','����mscohere',3)
title('���ַ��������ɺ����Ƚ�');
ylabel('��ֵ'); xlabel('��һ��Ƶ��/pi');
set(gcf,'color','w'); 

