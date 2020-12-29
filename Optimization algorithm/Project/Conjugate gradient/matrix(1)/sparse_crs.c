#include "sparse_crs.h"

int init_pattern(struct PATTERN *pattern, int n, int m, int nzmax)
{
    int i, j;
    pattern->n = n;
    pattern->m = m;
    if ((pattern->row = (int*)malloc(sizeof(int) * (n + 1))) == NULL ||
	(pattern->col = (int*)malloc(sizeof(int) * (n * nzmax))) == NULL)
    {
	printf ("Out of memory!\n");
	exit(-1);
    }
    for (i = 0; i < n; i++)
    {
	pattern->row[i] = i * nzmax;
	pattern->col[pattern->row[i]] = i;
	for (j = i * nzmax + 1; j < (i + 1) * nzmax; j++)
	    pattern->col[j] = -1;
    }
    pattern->row[n] = n * nzmax;
    pattern->is_compressed = 0;
    pattern->registed = NULL;
    return 0;
};

int print_pattern(const struct PATTERN *pattern)
{
    int i, j;
    for (i = 0; i < pattern->n; i++)
	for (j = pattern->row[i]; j < pattern->row[i + 1]; j++)
	    printf ("(%d, %d)\n", i, pattern->col[j]);
    return 0;
};

int delete_pattern(struct PATTERN *pattern)
{
    struct node *p = pattern->registed;
    struct node *d;		/**< pointer to delete. */
    while (p != NULL)
    {
	d = p;
	p = p->next;
	free(d->mat->ele);
	free(d);
    }
    free(pattern->col);
    free(pattern->row);
};

int set_pattern(struct PATTERN *pattern, int pi, int pj)
{
    int j, flag;
    if (pi == pj)
	return 0;
    else
    {
	flag = 0;
	for (j = pattern->row[pi] + 1; j < pattern->row[pi + 1]; j++)
	{
	    if (pattern->col[j] == -1)
	    {
		pattern->col[j] = pj;
		flag = 1;
		break;
	    }
	}
	if (flag == 0)
	{
	    printf ("Pattern error!\n");
	    exit(-1);
	}
    }
    return 0;
};

int compress_pattern(struct PATTERN *pattern)
{
    int rp = 0;
    int wp = 0;
    int old_row = 0;
    int i, j;
    for (i = 0; i < pattern->n; i++)
    {
	for (j = old_row; j < pattern->row[i + 1]; j++)
	{
	    if (pattern->col[j] != -1)
	    {
		pattern->col[wp] = pattern->col[rp];
		wp++;
		rp++;
	    }
	    else
		rp++;
	}
	old_row = pattern->row[i + 1];
	pattern->row[i + 1] = wp;
    }
    pattern->is_compressed = 1;
    return 0;
};

int init_matrix(struct MATRIX *mat, struct PATTERN *pattern)
{
    int i;
    if (pattern->is_compressed == 0)
    {
	printf ("The pattern have to be compressed first!\n");
	exit(-1);
    }
    mat->pat = pattern;

    /// 将自己加入模板注册列表.
    struct node *p = pattern->registed;
    while (p != NULL)
	p = p->next;
    if ((p = (struct node*)malloc(sizeof(struct node))) == NULL)
    {
	printf ("Out of memory!\n");
	exit(-1);
    }
    p->mat = mat;
    p->next = NULL;
    
    if ((mat->ele = (double*)malloc(sizeof(double) * (pattern->row[pattern->n]))) == NULL)
    {
	printf ("Out of memory!\n");
	exit(-1);
    }
    for (i = 0; i < pattern->n; ++i)
	mat->ele[i] = 0.0;
    return 0;
};

int print_matrix(const struct MATRIX *mat)
{
    int i, j;
    for (i = 0; i < mat->pat->n; i++)
	for (j = mat->pat->row[i]; j < mat->pat->row[i + 1]; j++)
	    printf ("(%d, %d) = %lf\n", i, mat->pat->col[j], mat->ele[j]);
    return 0;
};

int add_matrix(struct MATRIX *mat, int ai, int aj, double e)
{
    int i, flag;
    if (ai == aj)
    {
	mat->ele[mat->pat->row[ai]] += e;
	return 0;
    }
    else
    {
	flag = 0;
	for (i = mat->pat->row[ai] + 1; i < mat->pat->row[ai + 1]; i++)
	{
	    if (mat->pat->col[i] == aj)
	    {
		mat->ele[i] += e;
		flag = 1;
		break;
	    }
	}
	if (flag == 0)
	{
	    printf ("Insert a non-zero element to a zero entry!\n");
	    exit(-1);
	}
    }
    return 0;
};

int mat_m_vec(const struct MATRIX *mat, const double *iv, double *ov)
{
    int i, j;
    double s;
    for (i = 0; i < mat->pat->n; i++)
    {
	s = 0;
	for (j = mat->pat->row[i]; j < mat->pat->row[i + 1]; j++)
	    s += mat->ele[j] * iv[mat->pat->col[j]];
	ov[i] = s;
    }
    return 0;
};

int gs_step(const struct MATRIX *mat, double *x, const double *b)
{
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;
    double s = 0;
    int i, j;
    for (i = 0; i < n; i++)
    {
	s = b[i];
	for (j = row[i] + 1; j < row[i + 1]; j++)
	    s -= ele[j] * x[col[j]];
	x[i] = s / ele[row[i]];
    }
};

int sor_step(const struct MATRIX *mat, double *x, const double *b, double w)
{
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;
    double s = 0;

    int i, j;
    for (i = 0; i < n; i++)
    {
	s = b[i];
	for (j = row[i] + 1; j < row[i + 1]; j++)
	    s -= ele[j] * x[col[j]];
	x[i] = s / ele[row[i]] * w + x[i] * (1 - w);
    }
};

double res_norm(const struct MATRIX *mat, const double *x, const double *b)
{
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;
    double e, err = 0;
    int i, j;
    for (i = 0; i < n; i++)
    {
	e = b[i];
	for (j = row[i]; j < row[i + 1]; j++)
	    e -= ele[j] * x[col[j]];
	err += e * e;
    }
    return sqrt(err);
};

double read_matrix(const struct MATRIX *mat, int ai, int aj)
{
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;

    int j;
    for (j = row[ai]; j < row[ai + 1]; j ++)
	if (col[j] == aj)
	    return ele[j];
    return 0.0;
}

int res(const struct MATRIX *mat, const double *x, const double *b, double *r)
{
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;
    int i, j;
    for (i = 0; i < n; i++)
    {
	r[i] = -b[i];
	for (j = row[i]; j < row[i + 1]; j++)
	    r[i] += ele[j] * x[col[j]];
    }
    return 0;
};

int pc_id(const struct MATRIX *mat, const double *v, double *w)
{
    int i;
    int n = mat->pat->n;
    for (i = 0; i < n; i++)
	w[i] = v[i];
};

int pc_ssor(const struct MATRIX *mat, const double *v, double *w, double omg)
{
    int i, j;
    int n = mat->pat->n;
    int *row = mat->pat->row;
    int *col = mat->pat->col;
    double *ele = mat->ele;
    for (i = 0; i < n; i++)
    {
	w[i] = v[i];
	for (j = row[i] + 1; j < row[i + 1]; j++)
	{
	    if (col[j] > i)
		continue;
	    else
		w[i] -= omg * ele[j] * w[col[j]] / ele[row[col[j]]];
	}
    }
    for (i = n - 1; i >= 0; i--)
    {
	for (j = row[i] + 1; j < row[i + 1]; j++)
	{
	    if (col[j] < i)
		continue;
	    else
		w[i] -= omg * ele[j] * w[col[j]]; 
	}
	w[i] /= ele[row[i]];
    }
    return 0;
};

int pc_im0(const struct MATRIX *mat, const double *v, double *w) 
{
    return 0;
};
