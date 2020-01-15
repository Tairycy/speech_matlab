%
% PART_I
addpath('../basic_tbx');
[xx,fs]=audioread(fle);                   % ��������
mean(xx)  
xx=xx-mean(xx);                         % ����ֱ������
x=xx/max(abs(xx));                      % ��ֵ��һ��
N=length(x);                            % ȡ�źų���
time=(0:N-1)/fs;                        % ����ʱ��
signal=Gnoisegen(x,SNR);                % ��������

wnd=hamming(wlen);                      % ���ô�����
overlap=wlen-inc;                       % ���ص�������
NIS=fix((IS*fs-wlen)/inc +1);           % ��ǰ���޻���֡��

y=enframe(signal,wnd,inc)';             % ��֡
fn=size(y,2);                           % ��֡��
frameTime=frame2time(fn, wlen, inc, fs);% �����֡��Ӧ��ʱ��


