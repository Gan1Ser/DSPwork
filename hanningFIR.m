% 基于汉宁窗的FIR高通滤波器
clear
[x, Fs] = audioread("High_Frequency.wav");
sound(x,Fs);

X=abs(fft(x)); 


% % % 初始分析
N=length(x);   % 计算信号x的长度
t=0:1/Fs:(N-1)/Fs; % 计算时间范围，样本数除以采样频率
X=abs(fft(x));   
X=X(1:N/2); 
df=Fs/ N;        % 计算频谱的谱线间隔
f=0:df:Fs/2-df;         % 计算频谱频率范围                       


% 原始信号分析
subplot(2,2,1);plot(t,x);  
title("原始音频信号时域图");
xlabel("时间(s)");
ylabel("幅度");
grid on;
subplot(2,2,2);plot(f,X);
axis([900,1500,0,5000]);
title('原始音频信号频谱图');
xlabel('频率(hz)');
ylabel('幅度谱');
grid on; 