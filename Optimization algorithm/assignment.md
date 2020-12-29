**问**：用二阶段单纯形法计算下⾯问题，给出主要中间步骤和每⼀步的基础可行点。
$$
\begin{array}{ll}
\min & f(x)=-3 x_{1}+x_{2}+x_{3} \\
\text { s.t. } & x_{1}-2 x_{2}+x_{3}+x_{4}=11 \\
& -4 x_{1}+x_{2}+2 x_{3}-x_{5}=3 \\
& -2 x_{1}+x_{3}=1 \\
& x \geq 0
\end{array}
$$
**解**：

**第一阶段**

首先引入人工变量$x_6, x_7, x_8$，得到第一阶段线性规划问题如下：
$$
\begin{array}{ll}
\min & x_6 + x_7 + x_8 \\
\text { s.t. } & x_{1}-2 x_{2}+x_{3}+x_{4}+x_6=11 \\
& -4 x_{1}+x_{2}+2 x_{3}-x_{5}+x_7=3 \\
& -2 x_{1}+x_{3}+x_8=1 \\
& x \geq 0
\end{array}
$$
整理得到
$$
A = \left[
\begin{array}{cccccccc}
1&-2&1&1&0&1&0&0\\
-4&1&2&0&-1&0&1&0\\
-2& 0& 1& 0& 0& 0& 0& 1
\end{array}
\right],\quad 
b = \left[
\begin{array}{c}
11\\3\\1
\end{array}
\right],\quad 
c = \left[0,0,0,0,0,1,1,1\right]^T.
$$
第一步迭代我们选择$\mathcal{B}=\left\{6,7,8\right\}$，$\mathcal{N}=\left\{1, 2, 3,4,5\right\}$，于是可得矩阵划分如下：
$$
\begin{array}{rr}
B = \left[
\begin{array}{ccc}
1 & 0&0\\
0 & 1&0\\
0&0&1
\end{array}
\right], & 
N = \left[
\begin{array}{ccccc}
1&-2&1&1&0\\ 
-4&1&2&0&-1\\
-2& 0& 1& 0& 0
\end{array}
\right],\\
c_B = \left[
\begin{array}{c}
1\\1\\1
\end{array}
\right], &
c_N = \left[
\begin{array}{c}
0 \\ 0\\0\\0\\0
\end{array}
\right].
\end{array}
$$
第一个基本可行点
$$
x_B = B^{-1}\cdot b  = \left[
\begin{array}{c}
11\\3\\1
\end{array}
\right], \quad 
x_N  = \left[
\begin{array}{c}
0 \\ 0 \\0\\0\\0
\end{array}
\right].
$$
即$x = \left[0, 0,0,0,0, 11,3, 1\right]^T$，此时函数值为$c^Tx=15$。

此时相应检验数为
$$
s_N = c_N - (B^{-1}N)^Tc_B = \left[
\begin{array}{c}
0\\0\\0\\0\\0
\end{array}
\right] - (\left[
\begin{array}{cc}
1 & 0 &0\\
0 & 1 &0\\
0&0&1
\end{array}
\right]
\left[
\begin{array}{ccccc}
1&-2&1&1&0\\ 
-4&1&2&0&-1\\
-2& 0& 1& 0& 0
\end{array}
\right])^T
\cdot \left[
\begin{array}{c}
1\\1\\1
\end{array}
\right] = \left[
\begin{array}{c}
5\\1\\-4\\-1\\1
\end{array}
\right].
$$
选择最小检验数相对于指标为入基，即$q=3$。

可行的下降方向为
$$
d = B^{-1}A_q = \left[
\begin{array}{ccc}
1 & 0&0\\
0 & 1&0\\
0&0&1
\end{array}
\right]\left[
\begin{array}{c}
1 \\ 2\\1
\end{array}
\right] = \left[
\begin{array}{c}
1 \\ 2 \\1
\end{array}
\right]
$$
$d$各分量均为正，而
$$
\frac{(x_B)_6}{d_6} = 11 , \quad \frac{(x_B)_7}{d_7} = \frac{3}{2}, \quad \frac{(x_B)_8}{d_8} = 1
$$
因而选择出基$p=8$。于是更新得到$\mathcal{B}=\left\{6,7,3\right\}$，$\mathcal{N}=\left\{1, 2, 8,4,5\right\}$。

第二次迭代步骤同上，以下省略部分重复过程。
$$
\begin{array}{rr}
B = \left[
\begin{array}{ccc}
1 & 0&1\\
0 & 1&2\\
0&0&1
\end{array}
\right], & 
N = \left[
\begin{array}{ccccc}
1&-2&0&1&0\\ 
-4&1&0&0&-1\\
-2& 0& 1& 0& 0
\end{array}
\right],\\
c_B = \left[
\begin{array}{c}
1\\1\\0
\end{array}
\right], &
c_N = \left[
\begin{array}{c}
0 \\ 0\\1\\0\\0
\end{array}
\right].
\end{array}
$$


第二个基本可行点
$$
x_B = B^{-1}\cdot b  =
\left[
\begin{array}{ccc}
1&0&1\\
0&1&2\\
0&0&1
\end{array}
\right]^{-1}
\left[
\begin{array}{c}
11\\3\\1
\end{array}
\right]
=\left[
\begin{array}{c}
10\\1\\1
\end{array}
\right], \quad 
x_N  = \left[
\begin{array}{c}
0 \\ 0 \\0\\0\\0
\end{array}
\right].
$$
即$x = \left[0, 0,1,0,0, 10,1, 0\right]^T$，此时函数值为$c^Tx=11$。相应检验数为
$$
s_N = c_N - (B^{-1}N)^Tc_B =\left[
\begin{array}{c}
-3\\1\\4\\-1\\1
\end{array}
\right].
$$
仍然有负分量，于是选择入基$q=1$，于是可得
$$
d = B^{-1}A_q  = \left[
\begin{array}{c}
3 \\ 0 \\-2
\end{array}
\right]
$$
于是选择出基$p=6$。更新得到$\mathcal{B}=\left\{1,7,3\right\}$，$\mathcal{N}=\left\{6, 2, 8,4,5\right\}$。

第三次迭代过程如下。
$$
\begin{array}{rr}
B = \left[
\begin{array}{ccc}
1 & 0&1\\
-4 & 1&2\\
-2&0&1
\end{array}
\right], & 
N = \left[
\begin{array}{ccccc}
1&-2&0&1&0\\ 
0&1&0&0&-1\\
0& 0& 1& 0& 0
\end{array}
\right],\\
c_B = \left[
\begin{array}{c}
0\\1\\0
\end{array}
\right], &
c_N = \left[
\begin{array}{c}
1 \\ 0\\1\\0\\0
\end{array}
\right].
\end{array}
$$
第三个基本可行点
$$
x_B = B^{-1}\cdot b 
=\left[
\begin{array}{c}
\frac{10}{3}\\1\\\frac{23}{3}
\end{array}
\right], \quad 
x_N  = \left[
\begin{array}{c}
0 \\ 0 \\0\\0\\0
\end{array}
\right].
$$
即$x = \left[\frac{10}{3}, 0,\frac{23}{3},0,0,0,1, 0\right]^T$，此时函数值为$c^Tx=1$。相应检验数为
$$
s_N = c_N - (B^{-1}N)^Tc_B =\left[
\begin{array}{c}
1\\-1\\3\\0\\1
\end{array}
\right].
$$
于是选择入基$q=2$。可得
$$
d = B^{-1}A_q  = \left[
\begin{array}{c}
-\frac{2}{3} \\ 1 \\ -\frac{4}{3}
\end{array}
\right]
$$
于是选择出基$p=7$。更新得到$\mathcal{B}=\left\{1,2,3\right\}$，$\mathcal{N}=\left\{6, 7, 8,4,5\right\}$。此时所有的人工变量均不是基变量，即人工变量值均为0，已经得到第一阶段最优解，所以第一阶段到此结束。

相应可行点为
$$
x_B = B^{-1}\cdot b 
=\left[
\begin{array}{c}
4\\1\\9
\end{array}
\right], \quad 
x_N  = \left[
\begin{array}{c}
0 \\ 0 \\0\\0\\0
\end{array}
\right].
$$
即$x = \left[4, 1,9,0,0,0,0, 0\right]^T$

可以验证此时
$$
s_N = c_N - (B^{-1}N)^Tc_B =\left[
\begin{array}{c}
1\\1\\1\\0\\0
\end{array}
\right]\geq0.
$$

## 第二阶段

由原始优化问题可得
$$
A = \left[
\begin{array}{ccccc}
1&-2&1&1&0\\
-4&1&2&0&-1\\
-2& 0& 1& 0& 0
\end{array}
\right],\quad 
b = \left[
\begin{array}{c}
11\\3\\1
\end{array}
\right],\quad 
c = \left[-3,1,1,0,0\right]^T.
$$
由第一阶段解知$\mathcal{B}=\left\{1,2,3\right\}$，$\mathcal{N}=\{4,5\}$，初始可行解为$x = \left[4, 1,9,0,0\right]^T$，函数值为$f(x) = c^Tx = -2$。

此时检验数为
$$
s_N = c_N - (B^{-1}N)^Tc_B =\left[
\begin{array}{c}
\frac{1}{3} \\ \frac{1}{3}
\end{array}
\right] \geq 0.
$$
因此最优解已获得，即$x^* =\left[4, 1,9,0,0\right]^T$，$f(x^*) = -2$。

 