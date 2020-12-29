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

for loop = 1:11
    r = (loop-1)/10;
    x_axis(loop) = r*100;
    [~,p] = find_noma3_min_max(sigma,d1,d2,a,thres);
    [r11,r13,r22,r23] = find_rate_noma3(p,B,sigma,d1,d2,a,thres);
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
        % 将x1和x2叠加发送，重新优化功率分配及传输速率
        [r11_new,r22_new] = find_noma_rate_12(B,sigma,d1,d2,a,thres);
        t11_new = x1_remain/r11_new;
        t22_new = x2_remain/r22_new;
        
        t_common_new = min(t11_new,t22_new);        %公共传输时间2
        
        %看第二阶段还剩下哪部分数据
        if t11_new<t22_new
            % 还剩下x2
            x2_remain_new = x2_remain-r22_new*t_common_new;
            r22_new = B*log2(1+1/(d2^a*sigma));
            t_last = x2_remain_new/r22_new;
        else
            % 还剩下x1
            x1_remain_new = x1_remain-r11_new*t_common_new;
            r11_new = B*log2(1+1/(d1^a*sigma));
            t_last = x1_remain_new/r11_new;
        end
        
    elseif t_common == t11
        % x1部分能传完
        x3_remain = dt*r-r3*t_common;
        x2_remain = dt*(1-r)-r22*t_common;
        % 将x2和x3叠加发送，重新优化功率分配及发送速率
        [r13_new,r22_new,r23_new] = find_noma_rate_23(B,sigma,d1,d2,a,thres);
        
        r3_new = min(r13_new,r23_new);
        t3_new = x3_remain/r3_new;
        t2_new = x2_remain/r22_new;
        t_common_new = min(t2_new,t3_new);
        if t3_new<t2_new
            % 最后还剩下x2
            x2_remain_new = x2_remain - t_common_new*r22_new;
            r22_new = B*log2(1+1/(d2^a*sigma));
            t_last = x2_remain_new/r22_new;
        else
            % 最后还剩下x3
            x3_remain_new = x3_remain - t_common_new*r3_new;
            r3_new = B*log2(1+1/(d2^a*sigma));
            t_last = x3_remain_new/r3_new;
        end
        
    else
        % x2能传完
        x3_remain = dt*r-r3*t_common;
        x1_remain = dt*(1-r)-r11*t_common;
        % 将x1和x3叠加发送，重新优化功率分配及发送速率
        [r11_new,r13_new,r23_new] = find_noma_rate_13(B,sigma,d1,d2,a,thres);
        
        r3_new = min(r13_new,r23_new);
        t3_new = x3_remain/r3_new;
        t1_new = x1_remain/r11_new;
        t_common_new = min(t1_new,t3_new);
        if t3_new<t1_new
            % 最后还剩下x1
            x1_remain_new = x1_remain - t_common_new*r11_new;
            r11_new = B*log2(1+1/(d1^a*sigma));
            t_last = x1_remain_new/r11_new;
        else
            % 最后还剩下x3
            x3_remain_new = x3_remain - t_common_new*r3_new;
            r3_new = B*log2(1+1/(d2^a*sigma));
            t_last = x3_remain_new/r3_new;
        end
    end
    time_slots = (t_common) + (t_common_new) + (t_last);
    t_noma(loop) = time_slots;  
    
    r11_oma = B*log2(1+1/(d1^a*sigma));
    r22_oma = B*log2(1+1/(d2^a*sigma));
    r3_oma = min(r11_oma,r22_oma);
    time_oma = dt*(1-r)/r11_oma + dt*(1-r)/r22_oma + dt*r/r3_oma;
    t_oma(loop) = time_oma;
    
end
plot(x_axis,t_noma,'b-*','LineWidth',2,'MarkerSize',10),hold on;
plot(x_axis,t_oma,'r-*','LineWidth',2,'MarkerSize',10);
xlabel('重叠区域比例(%)');
ylabel('传输时间(s)');
legend('NOMA','OMA');