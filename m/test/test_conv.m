close all;
clear all;
clc;
t_size=128;
t=0:1/t_size:1-1/t_size;
% h=sin(pi*t);
% h=ones(size(t));
h=hamming(t_size);
delta=1;
unit=[1, 1];
h1 = conv(h,delta);
h2 = conv(h,unit);

delta_w = fft(delta);
h_w =fft(h);
H_W = h_w .* delta_w;

W = 0:2*pi/t_size:2*pi*(t_size-1)/t_size; 
H_W1 = freqz(h, 1, W);

W2=linspace(0, 2*pi, 2* t_size + 1);
H_W2 = freqz(h, 1, W2);
% ֤���˴�������fft �ȼ���
% ֱ�����Ƶ��Ӧ��ֻ�ǻ���Ƶ��Ӧ��ʱ��w��ȡֵ��ȽϾ�ϸ�����ֱ�Ӱ�fft�ĵ�����ȡֵ�Ļ������ߵ����߾���ȫ�Ǻ�
figure;
plot(W/(2*pi), 20*log10(abs(H_W)/max(abs(H_W))), 'b');
hold on;
plot(W/(2*pi), 20*log10(abs(H_W1)/max(abs(H_W1))), 'g');
hold on;
plot(W2/(2*pi), 20*log10(abs(H_W2)/max(abs(H_W2))), 'r');

%%%%%%%%%%%%%%%%%
t_size=128;
t=0:1/t_size:2-1/t_size;
% h=sin(pi*t);
% h=ones(size(t));
h=hamming(t_size * 2);
x = 2* sin(2*pi*t) + sin(3*pi*t +0.5);
x_w = fft(x);
x_h = x .* h.';
X_H_W = fft(x_h);

% ֤���ˣ� �˿�t�ĳ�����һ�����ڣ�����Ҫ�Ӵ����Ӵ������ᵼ��Ƶ��й¶
figure;
plot(abs(x_w), '*');
hold on;
stem(abs(X_H_W));

%%%%%%%%%%%%%%%%%
t_size=128;
t=0:1/t_size:3-1/t_size;
% h=sin(pi*t);
% h=ones(size(t));
h=hamming(t_size * 3);
x = 2* sin(2*pi*t) + sin(3*pi*t +0.5);
x_w = fft(x);
x_h = x .* h.';
X_H_W = fft(x_h);

% ֤���ˣ��˿�t�ĳ�����һ�������ڣ��ᵼ��Ƶ��й¶���Ӵ����Ի���Ƶ��й¶
figure;
plot(abs(x_w), '*');
hold on;
stem(abs(X_H_W));

X_H_W1 = 1 / ( 2* pi) * conv(x_w, h_w);
% ֤�����źźʹ������ֱ�����fft������Ƶ�������ٳ���2pi, ���ȼ���
% �Ӵ�������fft, ���Ⱦ��������Ƶ�׳��Ⱦͺ�Ŀ��fft�ĳ��Ȳ���ȣ� ���fft����zero padding֮����ܻ���ȣ�
figure;
plot(abs(X_H_W1));
hold on;
plot(abs(X_H_W), 'g');

