/*****************************************************************************
 *     Author: Xilinx, Inc.
 *****************************************************************************/

#include "cholesky_inverse.h"

// The top-level function to synthesize
int cholesky_inverse_top(MATRIX_IN_T  A[ROWS_COLS_A][ROWS_COLS_A], MATRIX_OUT_T InverseA[ROWS_COLS_A][ROWS_COLS_A]){

  MATRIX_IN_T  a_i[ROWS_COLS_A][ROWS_COLS_A];
  MATRIX_OUT_T inverse_a_i[ROWS_COLS_A][ROWS_COLS_A];
  int inverse_OK;
  
  // Copy input data to local memory
  a_row_loop : for (int r=0;r<ROWS_COLS_A;r++) {
    a_col_loop : for (int c=0;c<ROWS_COLS_A;c++) {
      a_i[r][c] = A[r][c];
    }
  }

  // Call Cholesky Inverse
  hls::cholesky_inverse<ROWS_COLS_A, MATRIX_IN_T, MATRIX_OUT_T>(a_i, inverse_a_i, inverse_OK);
  
  // Copy local memory contents to output
  inverse_a_row_loop : for (int r=0;r<ROWS_COLS_A;r++) {
    inverse_a_col_loop : for (int c=0;c<ROWS_COLS_A;c++) {
      InverseA[r][c] = inverse_a_i[r][c];
    }
  }
  
  return inverse_OK;
}


