dt = 20*10^6;        % 每个用户一帧画面的总数据量：10Mbits
B = 20*10^6;        % 信道带宽
d1 = 15;            % 用户1距离基站距离
d2 = 30;            % 用户2距离基站距离
thres = 5;          % 解码门限
a = 3;              % 路径损耗指数
sigma = 1/10^9;     % 噪声功率
time_duration = 0.01;       %时隙长度：10ms

t_noma = zeros(1,11);
t_oma = zeros(1,11);
x_axis = zeros(1,11);
for loop = 1:11
    r = (loop-1)/10;
    x_axis(loop) = r;
    
    r11_oma = B*log2(1+1/(d1^a*sigma));
    r22_oma = B*log2(1+1/(d2^a*sigma));
    r3_oma = min(r11_oma,r22_oma);
    time_oma = dt*(1-r)/r11_oma + dt*(1-r)/r22_oma + dt*r/r3_oma;
    t_oma(loop) = time_oma;
    
    [r11,r13,r22,r23] = find_rate(B,sigma,d1,d2,a,thres);
    r3 = min(r13,r23);
    % 第一阶段，x1和x3叠加，x2和x3叠加
    t11 = dt*(1-r)/r11;
    t22 = dt*(1-r)/r22;
    t3 = dt*r/r3;
    t_common = min([t11,t22,t3]);     %公共传输时间1
    
    % 根据t_common的大小来分别判断接下来的传输方案
    
    % x3数据能传完
    if t_common == t3
        x1_remain = dt*(1-r)-r11*t_common;
        x2_remain = dt*(1-r)-r22*t_common;
        %之后全都采用正交方式传输
        t_2 = x1_remain/r11_oma;
        t_3 = x2_remain/r22_oma;
        
    elseif t_common == t11
        % x1部分能传完
        x3_remain = dt*r-r3*t_common;
        x2_remain = dt*(1-r)-r22*t_common;
       %之后全都采用OMA传输
       t_2 = x2_remain/r22_oma;
       t_3 = x3_remain/r3_oma;
        
    else
        % x2能传完
        x3_remain = dt*r-r3*t_common;
        x1_remain = dt*(1-r)-r11*t_common;
        %之后全都采用OMA传输
        t_2 = x1_remain/r11_oma;
        t3 = x3_remain/r3_oma;
    end
    time_slots = (2*t_common) + (t_2) + (t_3);
    t_noma(loop) = time_slots;  
    
    
    
end
plot(x_axis,t_noma,'b-*','LineWidth',2,'MarkerSize',10),hold on;
plot(x_axis,t_oma,'r-*','LineWidth',2,'MarkerSize',10);
xlabel('重叠区域比例(%)');
ylabel('传输时间');
legend('NOMA','OMA');