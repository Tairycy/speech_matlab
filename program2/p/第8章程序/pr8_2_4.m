%
% pr8_2_4 
clc; clear all; close all

load Gpsd_7096.mat                % ���빦�����ܶ���ֵ�ļ�
L=length(freq);                   % ��Ƶ�ʳ���
N=(L-1)*2;                        % ���ݳ���
Gxx=Gx;                           % ˫�߹������ܶ�
Gxx(2:L-1)=Gx(2:L-1)/2;           % �ѵ��߹������ܶȷ�ֵ��Ϊ˫�߹������ܶȷ�ֵ
Ax=sqrt(Gxx*N*fs);                % ��������˫��Ƶ�׷�ֵ
% ��������������
fik=pi*randn(1,L);                % ���������λ��
Xk=Ax.*exp(1j*fik);               % ��������Ƶ��
Xk=[Xk conj(Xk(L-1:-1:2))];       % ���ù���Գ������˫��Ƶ��
Xm=ifft(Xk);                      % ����Ҷ��任
xm=real(Xm);                      % ȡʵ��
time=(0:N-1)/fs;                  % ʱ������
% ���������xm������ͼ���Ĺ������ܶ�
[Gx1,f1]=periodogram(xm,boxcar(N),N,fs,'onesided');
Dgx=max(Gx-Gx1')                  % �������������ܶ�����ֵ
% ��ͼ
figure(1)
subplot 211; plot(freq,Gx,'k','linewidth',2)
xlabel('Ƶ��/Hz'); ylabel('�������ܶȷ�ֵ/m^2/(s^4Hz)')
title('�����������ܶ�Gx'); grid; 
subplot 212; plot(freq,Ax,'k','linewidth',2)
xlabel('Ƶ��/Hz'); ylabel('���ٶ�Ƶ���ֵ/m/s^2')
title('�������ٶ�Ƶ���ֵAx'); grid; 
set(gcf,'color','w'); 


figure(2)
subplot 211; plot(time,xm,'k');
xlabel('ʱ��/s'); ylabel('���ٶȷ�ֵ/m/s^2')
title('����������ٶ����в���ͼ'); grid; 
subplot 212; plot(freq,Gx,'r','linewidth',3); hold on
plot(f1,Gx1,'k');
xlabel('Ƶ��/Hz'); ylabel('�������ܶȷ�ֵ/m^2/(s^4Hz)')
title('�����������ܶȺ�������й������ܶȱȽ�'); grid; 
legend('�����������ܶ�','������й�������')
set(gcf,'color','w'); 


