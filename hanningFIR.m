% 基于汉宁窗的FIR高通滤波器
clear
[x, Fs] = audioread("High_Frequency.wav");
sound(x,Fs);
pause(7);

% 原始信号初始分析
N=length(x);   % 计算信号x的长度
t=0:1/Fs:(N-1)/Fs; % 计算时间范围，样本数除以采样频率
X=abs(fft(x));   
X=X(1:N/2); 
df=Fs/ N;        % 计算频谱的谱线间隔
f=0:df:Fs/2-df;         % 计算频谱频率范围

subplot(2,2,1);
plot(t,x);  
title("原始音频信号时域图");
xlabel("时间(s)");
ylabel("幅度");
grid on;

subplot(2,2,2);
plot(f,X);
axis([900,1500,0,5000]);
title('原始音频信号频谱图');
xlabel('频率(hz)');
ylabel('幅度谱');
grid on; 

% 加噪
fn1=930;   % 单频噪声频率
fn2=950;
fn3=970;
fn4=1000;
noise=0.5*sin(fn1*2*pi*t)+0.5*sin(fn2*2*pi*t)+0.5*sin(fn3*2*pi*t)+0.5*sin(fn4*2*pi*t);
% 将噪声向量重复两次以形成 467097x2 的矩阵
noise_matrix = repmat(noise', 1, 2);
y=x+noise_matrix; % 加入一个多频噪声
sound(y,Fs); 
pause(7);

% 加噪信号分析
Y=abs(fft(y));% 对加噪信号进行fft变换
Y=Y(1:N/2);     % 截取前半部分

subplot(2,2,3);
plot(t,y);
title('加入四个单频噪声后的音频信号');
xlabel('时间(s)');
ylabel('幅度');
grid on;

subplot(2,2,4);
plot(f,Y);
axis([900,1500,0,5000]);
title('加入四个单频噪声后的音频信号频谱');
xlabel('频率(hz)');
ylabel('幅度谱');
grid on;

% 计算汉宁窗所需要的参数

fp=1110;fs=950;%通带和阻带截止频率
Rp=1;As=43.9;%通带和阻带衰减
fcd=(fp+fs)/2;% 高通滤波器设计指标，截止频率
df=fp-fs;  % 计算频率间隔
wc=fcd/Fs*2*pi;% 截止频率(弧度) 
dw=df/Fs*2*pi;  
wsd=fs/Fs*2*pi;
M=ceil(6.2*pi/dw)+1          % 计算汉宁窗设计该滤波器时需要的阶数

