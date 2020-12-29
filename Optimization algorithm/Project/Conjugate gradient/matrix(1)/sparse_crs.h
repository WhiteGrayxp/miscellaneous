/**
 * @file   sparse_crs.h
 * @author WANG Heyu <hywang@x200t>
 * @date   Tue Oct 10 08:39:32 2017
 * 
 * @brief  稀疏矩阵模板实现.
 * 
 * 
 */

#ifndef _SPARSE_CRS_WHY_
#define _SPARSE_CRS_WHY_
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/**
 * 稀疏阵模板.
 * 
 */
struct PATTERN 
{
    int n;			/**< 行数. */
    int m;			/**< 列数. */
    int *row;			/**< 行指标. */
    int *col;			/**< 列指标. */
    int is_compressed;		/**< 是否压缩. */
    struct node *registed;	/**< 采用该模板的矩阵. */
};

/**
 * 稀疏矩阵.
 * 
 */
struct MATRIX
{
    struct PATTERN *pat;	/**< 模板指针. */
    double *ele;		/**< 非零元. */
};

/**
 * 用于注册使用模板矩阵的节点. 在每个模板中都记录了使用它的矩阵, 构成
 * 一个链表.
 * 
 */
struct node
{
    struct node *next;
    struct MATRIX *mat;
};

/** 
 * 初始化模板.
 * 
 * @param pattern 模板指针.
 * @param n 行数.  		   
 * @param m 列数.  		   
 * @param nzmax 每行最大非零元个数. 
 * 
 * @return 错误代码.
 */
int init_pattern(struct PATTERN *pattern, int n, int m, int nzmax);

/** 
 * 显示模板信息. 
 * 
 * @param pattern 模板指针.
 * 
 * @return 错误代码.
 */
int print_pattern(const struct PATTERN *pattern);

/** 
 * 删除模板. 注意这里会删除全部使用该模板的矩阵中的元素, 以避免内存泄
 * 漏. 因此不再提供单独的矩阵删除操作.
 * 
 * @param pattern 模板指针.
 * 
 * @return 错误代码.
 */
int delete_pattern(struct PATTERN *pattern);

/** 
 * 设置模板非零元.
 * 
 * @param pattern 模板指针.
 * @param pi 行标.
 * @param pj 列标.
 * 
 * @return 错误代码.
 */
int set_pattern(struct PATTERN *pattern, int pi, int pj);

/** 
 * 压缩模板.
 * 
 * @param pattern 模板指针. 
 * 
 * @return 错误代码.
 */
int compress_pattern(struct PATTERN *pattern);

/** 
 * 初始化矩阵.
 * 
 * @param mat 矩阵指针.
 * @param pattern 模板指针.
 * 
 * @return 错误代码.
 */
int init_matrix(struct MATRIX *mat, struct PATTERN *pattern);

/** 
 * 显示矩阵信息.
 * 
 * @param mat 矩阵指针.
 * 
 * @return 错误代码.
 */
int print_matrix(const struct MATRIX *mat);

/** 
 * 读取 mat[ai, aj] 的数值. 如果是零元则返回 0.
 * 
 * @param mat 矩阵.
 * @param ai 行标.
 * @param aj 列标.
 * 
 * @return mat[ai, aj].
 */
double read_matrix(const struct MATRIX *mat, int ai, int aj);

/** 
 * 增加矩阵元素. 将 e 加到 mat[ai, aj] 上.
 * 
 * @param mat 矩阵指针.
 * @param ai 行标.
 * @param aj 列标.
 * @param e 非零元.
 * 
 * @return 错误代码.
 */
int add_matrix(struct MATRIX *mat, int ai, int aj, double e);

/** 
 * 矩阵乘以向量.
 * 
 * @param mat 矩阵指针.
 * @param iv 乘向量指针.
 * @param ov 积向量指针.
 * 
 * @return 
 */
int mat_m_vec(const struct MATRIX *mat, const double *iv, double *ov);

/** 
 * 一步 GS 迭代.
 * 
 * @param mat 系数矩阵. 
 * @param x 未知量.
 * @param b 右端项.
 * 
 * @return 
 */
int gs_step(const struct MATRIX *mat, double *x, const double *b);

/** 
 * 一步 SOR 迭代。
 * 
 * @param mat 系数矩阵.
 * @param x 未知量.
 * @param b 右端项.
 * @param w 松弛因子.
 * 
 * @return 
 */
int sor_step(const struct MATRIX *mat, double *x, const double *b, double w);

/** 
 * 计算系统残量范数.
 * 
 * @param mat 系数矩阵.
 * @param x 未知量.
 * @param b 右端项.
 * 
 * @return norm(Ax - b), 2-范.
 */
double res_norm(const struct MATRIX *mat, const double *x, const double *b);

/** 
 * 计算系统残向量.
 * 
 * @param mat 系数矩阵.
 * @param x 未知量.
 * @param b 右端项.
 * @param r 返回残量.
 * 
 * @return 错误代码.
 */
int res(const struct MATRIX *mat, const double *x, const double *b, double *r);

/** 
 * 单位预处理, 相当于不预处理, 用于调试. 实现 w = I^-1 * v.
 * 
 * @param mat 线性系统系数矩阵, 不是预处理矩阵 M!
 * @param v = I * w
 * @param w = I^-1 * v
 * 
 * @return 错误代码.
 */
int pc_id(const struct MATRIX *mat, const double *v, double *w);

/** 
 * SSOR 预处理, 实现 w = M_ssor^-1 * v.
 * 
 * @param mat 线性系统系数矩阵, 不是预处理矩阵 M!
 * @param v = M_ssor * w 
 * @param w = M_ssor^-1 * v
 * @param omg 松弛因子. 
 * 
 * @return 错误代码.
 */
int pc_ssor(const struct MATRIX *mat, const double *v, double *w, double omg);

/** 
 * 不完全 Cholesky 分解预处理 IM0.  
 * 
 * @param mat 线性系统系数矩阵, 不是预处理矩阵 M!
 * @param v = M * w; 
 * @param w = M^-1 * v.
 * 
 * @return 错误代码.
 */
int pc_im0(const struct MATRIX *mat, const double *v, double *w);


#else
/// do nothing
#endif
