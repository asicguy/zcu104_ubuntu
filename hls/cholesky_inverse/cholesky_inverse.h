/*****************************************************************************
 *     Author: Xilinx, Inc.
 *****************************************************************************/

#ifndef CHOLESKY_INVERSE_H
#define CHOLESKY_INVERSE_H

#include "hls_linear_algebra.h"

const unsigned ROWS_COLS_A = 4;

typedef float MATRIX_IN_T;
typedef float MATRIX_OUT_T;

int cholesky_inverse_top(MATRIX_IN_T  A[ROWS_COLS_A][ROWS_COLS_A], MATRIX_OUT_T InverseA[ROWS_COLS_A][ROWS_COLS_A]);

#endif

