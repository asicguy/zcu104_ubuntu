// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.2
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xcholesky_inverse_top.h"

extern XCholesky_inverse_top_Config XCholesky_inverse_top_ConfigTable[];

XCholesky_inverse_top_Config *XCholesky_inverse_top_LookupConfig(u16 DeviceId) {
	XCholesky_inverse_top_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XCHOLESKY_INVERSE_TOP_NUM_INSTANCES; Index++) {
		if (XCholesky_inverse_top_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XCholesky_inverse_top_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XCholesky_inverse_top_Initialize(XCholesky_inverse_top *InstancePtr, u16 DeviceId) {
	XCholesky_inverse_top_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XCholesky_inverse_top_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XCholesky_inverse_top_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif
