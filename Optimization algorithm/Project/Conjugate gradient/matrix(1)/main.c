/**
 * @file   main.cpp
 * @author WANG Heyu <wangheyu@zju.edu.cn>
 * @date   Mon Dec 26 03:43:56 2016
 * 
 * @brief 用标准C实现2D Poisson方程求解, 应用了CSR稀疏矩阵格式, 并提供
 * 了GS, SOR和CG线性解子. 仅用于教学演示, 不能保证实际计算效率. 只能用
 * 于带D氏条件的正方形计算区域.
 * 
 */

/// 定义求解器
#define _SOLVER_PCG_

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "sparse_crs.h"

double X0;			/**< 计算区域左下角 x 坐标. */
double Y0;			/**< 计算区域左下角 y 坐标. */
double X1;			/**< 计算区域右上角 x 坐标. */
double Y1;			/**< 计算区域右上角 y 坐标. */
int N;				/**< 计算区域分段数. */
double h;			/**< 计算区域分段长度. */
int n;				/**< 总自由度. */
double u_old;			/**< 旧数值解缓存, 用于SOR迭代. */
double omega;			/**< SOR组合系数. */
double tol; 	                /**< 线性解子容许残量. */
int maxit;			/**< 线性解子最大迭代次数. */
int mode;			/**< 求解器选择, 0 = GS, 1 = SOR, 2 = CG, 3 = PCG. */

/** 
 * D氏边界条件.
 * 
 * @param x 边界坐标.
 * @param y 边界坐标.
 * 
 * @return 边界函数值.
 */
double bnd(double x, double y);

/** 
 * 源项.
 * 
 * @param x 源点坐标.
 * @param y 源点坐标.
 * 
 * @return 源点值.
 */
double source(double x, double y);

/// 主流程.
int main (int argc, char *argv[])
{
    clock_t t;		/**< 时间统计缓存 */
    /// 参数输入
    FILE *input;		/**< 输入配置文件流 */
    FILE *output;		/**< 输出结果文件流 */
    char c;			/**< 字符读入缓存 */
    double rTr;		/**< CG, r残量估计*/
    double rTr_old;		/**< CG, r残量上一步缓存 */
    double pTAp;		/**< CG, 共轭最小 */
    double alpha;		/**< CG, 共轭步长 */
    double beta;		/**< CG, 共轭方向校正 */
    /// 准备内存变量
    double *u;		/**< 数值解 */
    double *r;		/**< 残量 */
    double *y;		/**< CG 预处理变量 */
    double *p;		/**< 共轭方向 */
    double *Ap;		/**< 线性搜索方向 */
    double *b;		/**< 右端项 */

    struct PATTERN pA;	/**< 系数矩阵模板 */
    struct MATRIX A;	/**< 系数矩阵 */

    int i;			/**< 列编号. (x向) */
    int j;			/**< 行编号. (y向) */
    double err;     	/**< 线性求解误差, 2-范. */
    int k;			/**< 线性求解迭代次数 */

    int *row;		/**< 稀疏矩阵行索引接口 */
    int *col;		/**< 稀疏矩阵列索引接口 */
    double *ele;		/**< 稀疏矩阵非零元接口 */
    double error;

    input = fopen("config","r");
    output = fopen("re.m","w");
    fscanf(input,"%lf", &X0);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%lf", &Y0);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%lf", &X1);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%lf", &Y1);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%d", &N);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%lf", &omega);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%lf", &tol);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%d", &maxit);
    while ((c=fgetc(input)) != '\n');
    fscanf(input,"%d", &mode);
    h = ((X1 - X0) / (N + 1));
    n = (N * N);
    /// 输入校验
    if (X1 < X0 || Y1 < Y0)
    {
	printf ("Region error!\n");
	exit(-1);
    }
    if (N < 0)
    {
	printf ("Nodes error!\n");
	exit(-1);
    }
    /// 用户校验
    printf("Region: [%lf, %lf] x [%lf, %lf];\n", X0, X1, Y0, Y1);
    printf("No. of Nodes: %d x %d;\n", N, N);
    printf("h = %lf, n = %d\n", h, n);
    printf("tol = %g, maxit = %d\n", tol, maxit);
    printf("mode = %d, 0 = GS, 1 = SOR, 2 = CG, 3 = PCG-SSOR\n", mode); 
    printf("Press enter to continue...\n");
    getchar(); 

    /// 申请内存空间
    if ((u = (double *)malloc(n * sizeof(double))) == NULL ||
	(r = (double *)malloc(n * sizeof(double))) == NULL ||
	(p = (double *)malloc(n * sizeof(double))) == NULL ||
	(b = (double *)malloc(n * sizeof(double))) == NULL ||
	(y = (double *)malloc(n * sizeof(double))) == NULL ||
	(Ap = (double *)malloc(n * sizeof(double))) == NULL)
    {
	printf ("Out of memory!\n");
	exit(-1);
    }

    t = clock();
    /// 准备系数矩阵模板.
    init_pattern(&pA, n, n, 5);
    /// Ui,j
    for (i = 0; i < N; i++)
	for (j = 0; j < N; j++)
	    set_pattern(&pA, j * N + i, j * N + i);
    /// Ui+1,j
    for (j = 0; j < N; j++)
	for (i = 0; i < N - 1; i++)
	    set_pattern(&pA, j * N + i, j * N + i + 1);
    /// Ui-1,j
    for (j = 0; j < N; j++)
	for (i = 1; i < N; i++)
	    set_pattern(&pA, j * N + i, j * N + i - 1);
    /// Ui1,j-1
    for (i = 0; i < N; i++)
	for (j = 1; j < N; j++)
	    set_pattern(&pA, j * N + i, j * N + i - N);
    /// Ui1,j+1
    for (i = 0; i < N; i++)
	for (j = 0; j < N - 1; j++)
	    set_pattern(&pA, j * N + i, j * N + i + N);
    compress_pattern(&pA);
    init_matrix(&A, &pA);
    /// Ui,j, 右端项
    for (i = 0; i < N; i++)
	for (j = 0; j < N; j++)
	{
	    add_matrix(&A, j * N + i, j * N + i, 4.0);
	    b[j * N + i] = h * h * source(X0 + (i + 1) * h, Y0 + (j + 1) * h);
	}
    /// Ui+1,j, 右边界
    for (j = 0; j < N; j++)
    {
	for (i = 0; i < N - 1; i++)
	    add_matrix(&A, j * N + i, j * N + i + 1, -1.0);
	b[j * N + N - 1] += bnd(X1, Y0 + (j + 1) * h);
    }
    /// Ui-1,j, 左边界
    for (j = 0; j < N; j++)
    {
	for (i = 1; i < N; i++)
	    add_matrix(&A, j * N + i, j * N + i - 1, -1.0);
	b[j * N] += bnd(X0, Y0 + (j + 1) * h);
    }
    /// Ui1,j-1, 下边界
    for (i = 0; i < N; i++)
    {
	for (j = 1; j < N; j++)
	    add_matrix(&A, j * N + i, j * N + i - N, -1.0);
	b[i] += bnd(X0 + (i + 1) * h, Y0);
    }
    /// Ui1,j+1, 上边界
    for (i = 0; i < N; i++)
    {
	for (j = 0; j < N - 1; j++)
	    add_matrix(&A, j * N + i, j * N + i + N, -1.0);
	b[(N - 1) * N + i] += bnd(X0 + (i + 1) * h, Y1);

    }
    t = clock() - t;
    printf ("The assembling tooks me %d clicks (%f seconds).\n",(int)t,((float)t)/CLOCKS_PER_SEC);
    /* for (i = 0; i < n; i ++) */
    /* 	printf("b[%d] = %f\n", i, b[i]); */
    /// 线性求解器.
    t = clock();
    if (mode == 2)
    {
	for (i = 0; i < n; i++)
	    u[i] = 1.0;
	/// 获取稀疏矩阵数据接口以提高操作效率.
	row = pA.row;
	col = pA.col;
	ele = A.ele;
	rTr = 0.0;
	for (i = 0; i < n; i++)
	{
	    r[i] = -b[i];
	    for (j = row[i]; j < row[i + 1]; j++)
		r[i] += ele[j] * u[col[j]];
	    p[i] = -r[i];
	    rTr += r[i] * r[i];
	}
	k = 0;
	while (sqrt(rTr) / n > tol)
	{
	    pTAp = 0;
	    for (i = 0; i < n; i++)
	    {
		Ap[i] = 0;
		for (j = row[i]; j < row[i + 1]; j++)
		    Ap[i] += ele[j] * p[col[j]];
		pTAp += p[i] * Ap[i];
	    }
	    alpha = rTr / pTAp;
	    rTr_old = rTr;
	    rTr = 0;
	    for (i = 0; i < n; i++)
	    {
		u[i] += alpha * p[i];
		r[i] += alpha * Ap[i];
		rTr += r[i] * r[i];
	    }
	    beta = rTr / rTr_old;
	    for (i = 0; i < n; i++)
		p[i] = -r[i] + beta * p[i];
	    k++;
	}
    }
    else if (mode == 3)
    {
	for (i = 0; i < n; i++)
	{
	    y[i] = u[i] = 1.0;
	}
	/// 获取稀疏矩阵数据接口以提高操作效率.
	row = pA.row;
	col = pA.col;
	ele = A.ele;
	rTr = 0.0;
	res(&A, u, b, r);
//	pc_id(&A, r, y);
	pc_ssor(&A, r, y, omega);
	for (i = 0; i < n; i++)
	{
	    p[i] = -r[i];
	    rTr += r[i] * y[i];
	}
	k = 0;
	err = rTr;
	while (sqrt(err) / n > tol)
	{
	    pTAp = 0;
	    for (i = 0; i < n; i++)
	    {
		Ap[i] = 0;
		for (j = row[i]; j < row[i + 1]; j++)
		    Ap[i] += ele[j] * p[col[j]];
		pTAp += p[i] * Ap[i];
	    }
	    alpha = rTr / pTAp;
	    rTr_old = rTr;
	    rTr = 0;
	    err = 0;
	    for (i = 0; i < n; i++)
	    {
		u[i] += alpha * p[i];
		r[i] += alpha * Ap[i];
		/// 计算真实残量.
		err += r[i] * r[i];
	    }
//		pc_id(&A, r, y);
	    pc_ssor(&A, r, y, omega);
	    for (i = 0; i < n; i++)
		rTr += r[i] * y[i];
	    beta = rTr / rTr_old;
	    for (i = 0; i < n; i++)
		p[i] = -y[i] + beta * p[i];
	    k++;
	}
    }
    else if (mode == 0)
    {
	for (i = 0; i < n; i++)
	    u[i] = 1.0;
	err = 1.0;
	k = 0;
	while (err > tol)
	{
	    gs_step(&A, u, b);
	    err = res_norm(&A, u, b) / n;
	    k++;
	    if (k > maxit)
	    {
		printf ("not convergent!\n");
		break;
	    }
	}
    }
    else if (mode == 1)
    {
	for (i = 0; i < n; i++)
	    u[i] = 1.0;
	err = 1.0;
	k = 0;
	while (err > tol)
	{
	    sor_step(&A, u, b, omega);
	    err = res_norm(&A, u, b) / n;
	    k++;
	    if (k > maxit)
	    {
		printf ("not convergent!\n");
		break;
	    }
	}
    }
    else
    {
	printf ("Error! No such mode. 0 = GS, 1 = SOR, 2 = CG, 3 = PCG. \n");
	exit(-1);
    }
    t = clock() - t;
    printf ("The linear solver tooks me %d clicks (%f seconds).\n",(int)t,((float)t)/CLOCKS_PER_SEC);
    printf ("the number of iteration steps: %d\n", k);

    fprintf(output, "spA = [\n");
    for (i = 0; i < pA.m; i++)
    {
	for (j = pA.row[i]; j < pA.row[i + 1]; j++)
	{
	    fprintf(output, "%d, %d, %lf;\n", i, pA.col[j], A.ele[j]);
	}
    }
    fprintf(output, "];\n");
    fprintf(output, "A = sparse(spA(:,1)+1, spA(:,2)+1, spA(:,3));\n");
	
    t = clock();
    error = 0;
    delete_pattern(&pA);
    /* /// 数值解输出 */
    /* fprintf (output,"u=[\n"); */
    /* for (j = 0; j <= N + 1; j++) */
    /* 	fprintf(output,"%lf\t", bnd(X0 + j * h, Y0)); */
    /* fprintf(output,"\n"); */
    /* for (i = 1; i <= N; i++) */
    /* { */
    /* 	fprintf(output,"%lf\t", bnd(X0, Y0 + i * h)); */
    /* 	for (j = 1; j <= N; j++) */
    /* 	{ */
    /* 	    fprintf(output,"%lf\t", u[(i - 1) * N + j - 1]); */
    /* 	    error += fabs(u[(i - 1) * N + j - 1] - bnd(X0 + j * h, Y0 + i * h)) * fabs(u[(i - 1) * N + j - 1] - bnd(X0 + j * h, Y0 + i * h)); */
    /* 	} */
    /* 	fprintf(output,"%lf\n", bnd(X1, Y0 + i * h)); */
    /* } */
    /* for (j = 0; j <= N + 1; j++) */
    /* 	fprintf(output,"%lf\t", bnd(X0 + j * h, Y1)); */
    /* fprintf (output,"\n"); */
    /* fprintf (output,"];\n"); */
    /* fprintf (output, "x=linspace(%lf,%lf,%d);\n", X0, X1, N + 2); */
    /* fprintf (output, "y=linspace(%lf,%lf,%d);\n", Y0, Y1, N + 2); */
    /* fprintf (output, "[X Y]=meshgrid(x,y);\n"); */
    /* fprintf (output, "surf(X,Y,u);\n"); */
    /* t = clock() - t; */
    /* printf ("The outputing tooks me %d clicks (%f seconds).\n",(int)t,((float)t)/CLOCKS_PER_SEC); */
    error = sqrt(error) / N / N;
    printf ("error = %f\n", error);
    /* for (i = 0; i < N * N; i++) */
    /* 	printf ("u[%d] = %f\n", i, u[i]); */

    fclose(output);
    fclose(input);
    free(u);
    free(r);
    free(Ap);
    free(p);
    free(b);
    return 0;
}

double source(double x, double y)
{
    return 2.0 * sin(x) * sin(y);
};

double bnd(double x, double y)
{
    return sin(x) * sin(y);
};

