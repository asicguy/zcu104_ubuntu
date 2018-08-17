// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.2
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

/***************************** Include Files *********************************/
#include "xcholesky_inverse_top.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XCholesky_inverse_top_CfgInitialize(XCholesky_inverse_top *InstancePtr, XCholesky_inverse_top_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Axilites_BaseAddress = ConfigPtr->Axilites_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XCholesky_inverse_top_Start(XCholesky_inverse_top *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL) & 0x80;
    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL, Data | 0x01);
}

u32 XCholesky_inverse_top_IsDone(XCholesky_inverse_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XCholesky_inverse_top_IsIdle(XCholesky_inverse_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XCholesky_inverse_top_IsReady(XCholesky_inverse_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XCholesky_inverse_top_EnableAutoRestart(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL, 0x80);
}

void XCholesky_inverse_top_DisableAutoRestart(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_CTRL, 0);
}

u32 XCholesky_inverse_top_Get_return(XCholesky_inverse_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_AP_RETURN);
    return Data;
}
void XCholesky_inverse_top_InterruptGlobalEnable(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_GIE, 1);
}

void XCholesky_inverse_top_InterruptGlobalDisable(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_GIE, 0);
}

void XCholesky_inverse_top_InterruptEnable(XCholesky_inverse_top *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_IER);
    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_IER, Register | Mask);
}

void XCholesky_inverse_top_InterruptDisable(XCholesky_inverse_top *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_IER);
    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_IER, Register & (~Mask));
}

void XCholesky_inverse_top_InterruptClear(XCholesky_inverse_top *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCholesky_inverse_top_WriteReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_ISR, Mask);
}

u32 XCholesky_inverse_top_InterruptGetEnabled(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_IER);
}

u32 XCholesky_inverse_top_InterruptGetStatus(XCholesky_inverse_top *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCholesky_inverse_top_ReadReg(InstancePtr->Axilites_BaseAddress, XCHOLESKY_INVERSE_TOP_AXILITES_ADDR_ISR);
}
