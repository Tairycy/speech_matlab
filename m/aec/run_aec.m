close all;
clear all;
clc;
token = [4.082482904638630e-001 * sqrt(0.5)  -3.004261596374099e-017
    -5.282181998520569e-001 8.225260197957544e-018
    2.399888152683055e-001  -5.733259464062257e-017
    -1.209426510735405e-002 6.365366430137442e-018
    1.846294773620827e-005  -4.145515408357529e-018
    6.120179006378732e-004  -1.425483598645417e-017
    5.499197872127104e-004  3.338200835541673e-017
    3.330512243432287e-004  -3.991445470685697e-018
    1.174539197140093e-004  8.134817722064635e-018
    1.271175953190277e-003  1.061081289889354e-016
    5.904772354521236e-004  4.261935782680764e-018
    2.547449951754077e-004  -1.989653107221370e-018
    1.439335536944256e-004  1.032861020696383e-017
    8.379821248584243e-005  2.637946926618362e-018
    6.459175728329905e-005  -4.337403675070662e-018
    8.917856010668035e-004  5.921434018767376e-018];

token = reshape(token, [1, 32]);
out=zeros(1, 768);
for i = 1:768
    for j = 1:32
        out(i) = out(i) + token(j) * cos(pi*(j-1)*(2*i-1)/(768));
    end
end
out = out * sqrt(2/768) * sqrt(256) * sqrt(128)/2048;
filter_coeff=out;

% 129 bins
WEB_RTC_AEC_NL_WEIGHT_CURVE = [
    0.0000,  0.1000,  0.1266,  0.1376, ...
    0.1461,  0.1532,  0.1595,  0.1652, ...
    0.1704,  0.1753,  0.1799,  0.1842, ...
    0.1883,  0.1922,  0.1960,  0.1996, ...
    0.2031,  0.2065,  0.2098,  0.2129, ...
    0.2160,  0.2191,  0.2220,  0.2249, ...
    0.2277,  0.2304,  0.2331,  0.2357, ...
    0.2383,  0.2409,  0.2434,  0.2458, ...
    0.2482,  0.2506,  0.2529,  0.2552, ...
    0.2575,  0.2597,  0.2619,  0.2641, ...
    0.2662,  0.2684,  0.2705,  0.2725, ...
    0.2746,  0.2766,  0.2786,  0.2806, ...
    0.2825,  0.2844,  0.2863,  0.2882, ...
    0.2901,  0.2920,  0.2938,  0.2956, ...
    0.2974,  0.2992,  0.3010,  0.3027, ...
    0.3045,  0.3062,  0.3079,  0.3096, ...
    0.3113,  0.3130,  0.3146,  0.3163, ...
    0.3179,  0.3195,  0.3211,  0.3227, ...
    0.3243,  0.3259,  0.3274,  0.3290, ...
    0.3305,  0.3321,  0.3336,  0.3351, ...
    0.3366,  0.3381,  0.3396,  0.3411, ...
    0.3425,  0.3440,  0.3454,  0.3469, ...
    0.3483,  0.3497,  0.3511,  0.3525, ...
    0.3539,  0.3553,  0.3567,  0.3581, ...
    0.3595,  0.3608,  0.3622,  0.3635, ...
    0.3649,  0.3662,  0.3675,  0.3689, ...
    0.3702,  0.3715,  0.3728,  0.3741, ...
    0.3754,  0.3767,  0.3779,  0.3792, ...
    0.3805,  0.3817,  0.3830,  0.3842, ...
    0.3855,  0.3867,  0.3879,  0.3892, ...
    0.3904,  0.3916,  0.3928,  0.3940, ...
    0.3952,  0.3964,  0.3976,  0.3988, 0.4000];

DOUBLETALK_BAND_TABLE = [ 9, 11, 12, 15, 16, 18, 19, 21, 22, 24, 25, 27, 28, ... 
                          31, 32, 34, 35, 37, 38, 40, 41, 43, 44, 47, 48, 50, ... 
                          51, 53, 54, 56, 57, 59, 60, 63, 64, 66, 67, 69, 70, ...
                          72, 73, 75, 76, 79, 80, 82, 83, 85, 86, 88, 89, 91, ...
                          92, 95, 96, 98, 99, 101, 102, 104, 105, 107, 108, 111, ...
                          112, 114, 115, 117, 118, 120, 121, 123, 124, 126];
DOUBLETALK_BAND_TABLE = DOUBLETALK_BAND_TABLE +1;

% 恰好对应着125-500， 562.5-1125， 1187.5-2937.5, 3000-7750
BAND_TABLE= [2, 8, 9, 18, 19, 47, 48, 124]; 
BAND_TABLE=BAND_TABLE+1;

tic;
[total_input_f_pcm, indexs_1, indexs_2, a, b, c, d]=aec('input_data/rec_mic_0_0_short.pcm', 'input_data/rec_mic_1_0_short.pcm', 'input_data/rec_spk_l_0_short.pcm', filter_coeff, WEB_RTC_AEC_NL_WEIGHT_CURVE, DOUBLETALK_BAND_TABLE, BAND_TABLE);

figure(2);
pcm_size = size(indexs_1, 2);
scatter(1:pcm_size, indexs_1, 10, 'filled')
hold on;
plot(indexs_2)
toc;
disp(['运行时间: ',num2str(toc)]);
tmp1 = total_input_f_pcm(:,1:129);
tmp2 = total_input_f_pcm(:,130:258);
[out1] = compose(tmp1, filter_coeff);
[out2] = compose(tmp2, filter_coeff);
x = size(out1, 1);
y = size(out1, 2);
out1 = reshape(out1.', [x*y, 1]);
out2 = reshape(out2.', [x*y, 1]);

file_id=fopen('out_aec_0_0.pcm','wb');
fwrite(file_id, out1,'int16');
fclose(file_id);

figure(3);
subplot(3,1,1);
plot(out1);
grid on;
subplot(3,1,2);
specgram(out1, 2048, 16000, 2048, 1024);
colorbar;
subplot(3,1,3);
specgram(out2, 2048, 16000, 2048, 1024);
colorbar;

figure(4);
fs=16000;
aa = zeros(pcm_size * 128, 1);
bb = zeros(pcm_size * 128, 1);
cc = zeros(pcm_size * 128, 1);
dd = zeros(pcm_size * 128, 1);
for i = 1:pcm_size
    aa((i-1)*128 + 1:i*128) = a(i);
    bb((i-1)*128 + 1:i*128) = b(i);
    cc((i-1)*128 + 1:i*128) = c(i);
    dd((i-1)*128 + 1:i*128) = d(i);
end
t = (1:pcm_size * 128)/fs * 128;
rrinSubSamp = out1;
plot(t, rrinSubSamp/max(abs(rrinSubSamp)),'b');
hold on;
plot(t, aa, 'r');
plot(t, bb, 'g');
plot(t, cc, 'y');
plot(t, dd, 'k');
hold off;
axis tight;
% % Plot the STFT result
% set(gcf, 'Position', [20 100 600 500]);
% axes('Position', [0.1 0.1 0.85 0.5]);
% n2=1:129;
% N=size(tmp1, 1);
% time=(1:N)/16000;
% freq=(n2-1)*16000/256;
% imagesc(time, freq, abs(tmp1.'));
% axis xy;ylabel('f/Hz');xlabel('Time/s');
% title('语谱图');
% m=64;
% LightYellow=[0.6 0.6 0.6];
% MidRed=[0 0 0];
% Black=[0.5 0.7 1];
% Colors=[LightYellow;MidRed;Black];
% colormap(SpecColorMap(m, Colors));
% 
% % Plot waveform
% axes('Position', [0.07 0.72 0.9 0.22]);
% plot(time, out1, 'k');
% xlim([0 max(time)]);
% xlabel('Time/s');ylabel('幅值');
% title('语音信号波形');

file_id=fopen('out_aec_1_0.pcm','wb');
fwrite(file_id, out2,'int16');
fclose(file_id);
