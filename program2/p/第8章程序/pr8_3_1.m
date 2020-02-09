%
% pr8_3_1 
clear all; clc; close all;

r1=0.98; r2=0.98;                      % ����İ뾶
theta1=0.2*pi; theta2=0.3*pi;          % ��������
% �����˲������ݺ����ķ�ĸ����
A=conv([1 -2*cos(0.2*pi)*0.98 0.98*0.98],[1 -2*cos(0.3*pi)*0.98 0.98*0.98]);
B=1;                                   % �˲������ݺ����ķ��Ӳ���
P = 4;                                 % ����      
N = 256;                               % x(n)����
M=1024;                                % FFT�任����
M2=M/2+1;                              % ��Ƶ�ʳ���
% PSD����ֵ
S1 = 20*log10(abs(freqz(B, A, M2)))-10*log10(P);

f = (0 : M2-1)/M2;                     % Ƶ�ʿ̶�            
E_yu=zeros(M2,1);                      % ��ʼ��
E_bg=zeros(M2,1);
E_cv=zeros(M2,1);
E_mv=zeros(M2,1);
L=200;                                 % �������ѭ������
for k=1 : L                            % ����L��ѭ��
    w = randn(N,1);                    % ���������
    x = filter(B, A, w);               % ͨ��B/A���ɵ��˲���
    px1=pyulear(x,4,M);                % ��Yule-Walker�����㹦����
    px2=pburg(x,4,M);                  % ��Burg�����㹦����
    px3=pcov(x,4,M);                   % ��Э������㹦����
    px4=pmcov(x,4,M);                  % �øĽ�Э������㹦����
    S_yule = 10*log10(px1);            % ȡ����
    S_burg = 10*log10(px2);
    S_cov = 10*log10(px3);
    S_mcov = 10*log10(px4);
    E_yu=E_yu+S_yule;                  % �ۼ�
    E_bg=E_bg+S_burg;
    E_cv=E_cv+S_cov;
    E_mv=E_mv+S_mcov;
end
E_yu=E_yu/L;                           % ��ȡƽ��ֵ
E_bg=E_bg/L;
E_cv=E_cv/L;
E_mv=E_mv/L;
% ��ͼ
subplot 221; plot(f,S1,'k',f,E_yu,'r');
legend('True PSD', 'pyulear',3);
title('Yule-Walker��')
ylabel('��ֵ(dB)'); grid; xlim([0 0.5]);
subplot 222; plot(f,S1,'k',f,E_bg,'r');
legend('True PSD', 'pburg',3);
title('Burg��')
ylabel('��ֵ(dB)'); grid; xlim([0 0.5]);
subplot 223; plot(f,S1,'k',f,E_cv,'r');
legend('True PSD', 'pcov',3);
title('Cov��')
xlabel('��һ��Ƶ��'); ylabel('��ֵ(dB)');grid; xlim([0 0.5]);
subplot 224; plot(f,S1,'k',f,E_mv,'r');
legend('True PSD', 'pmcov',3);
title('Mcov��')
xlabel('��һ��Ƶ��'); ylabel('��ֵ(dB)');grid; xlim([0 0.5]);
set(gcf,'color','w'); 

