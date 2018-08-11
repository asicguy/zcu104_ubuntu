############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
open_project csynth
set_top cholesky_inverse_top
add_files ./cholesky_inverse.h
add_files ./cholesky_inverse.cpp
add_files -tb cholesky_inverse_tb.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xczu7ev-ffvc1156-2-e} -tool vivado
create_clock -period 35 -name default
source "./csynth/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -description "Matrix inversion using the Xilinx linear algebra library." -vendor "hdlguy" -display_name "cholesky_inverse"
