dt = 1*10^6;        % 每个用户一帧画面的总数据量：1Mbits
B = 1.4*10^6/72;       % 信道带宽
d1 = 20;            % 用户1距离基站距离
d2 = 40;            % 用户2距离基站距离
thres = 5;          % 解码门限
a = 3;              % 路径损耗指数
sigma = 1/10^8;     % 噪声功率
time_duration = 0.01;       %时隙长度：10ms

t_noma = zeros(1,11);
t_oma = zeros(1,11);
x_axis = zeros(1,11);
r11_oma = B*log2(1+1/(d1^a*sigma));
r22_oma = B*log2(1+1/(d2^a*sigma));
r3_oma = min(r11_oma,r22_oma);

% 只在第一阶段使用NOMA
for loop = 1:11
    r = (loop-1)/10;
    x_axis(loop) = r*100;
    [r11,r22] = find_noma_rate_12(B,sigma,d1,d2,a,thres);

    % 第一阶段，x1和x2叠加，x3oma多播
    t11 = dt*(1-r)/r11;
    t22 = dt*(1-r)/r22;
    t_common = min([t11,t22]);     %公共传输时间
    
    % 根据t_common的大小来分别判断接下来的传输方案
    
    % x1数据能传完
    if t_common == t11
        x2_remain = dt*(1-r)-r22*t_common;
        t_common_new = x2_remain/r22_oma;
        t_last = dt*r/r3_oma;
        
    else
        % x2能传完
        x1_remain = dt*(1-r)-r11*t_common;
        t_common_new = x1_remain/r11_oma;
        t_last = dt*r/r3_oma;
    end
    time_slots = (t_common) + (t_common_new) + (t_last);
    t_noma(loop) = time_slots;  

    time_oma = dt*(1-r)/r11_oma + dt*(1-r)/r22_oma + dt*r/r3_oma;
    t_oma(loop) = time_oma;
    
end
plot(x_axis,t_noma,'b-*','LineWidth',2,'MarkerSize',10),hold on;
plot(x_axis,t_oma,'r-*','LineWidth',2,'MarkerSize',10);
xlabel('重叠区域比例(%)');
ylabel('传输时间(s)');
legend('NOMA','OMA');