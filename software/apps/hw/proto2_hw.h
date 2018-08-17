#define		BASE_ADDRESS		0x80000000
#define		PROTO_SIZE		0x80000000

#define 	AXI_REGFILE_0		0x00000000

#define 	FPGA_ID     		AXI_REGFILE_0+0x04*0  // Currently returns 0xDEADBEEF
#define 	FPGA_VERSION		AXI_REGFILE_0+0x04*1  // Returns major and minor version numbers.
#define 	LED_CONTROL		AXI_REGFILE_0+0x04*2  // Returns major and minor version numbers.

#define         TEST_BRAM_OFFSET    0x20000000
#define         TEST_BRAM_SIZE      0x00001000 // 4KB

#define         AXI_MATINV          0x00010000 // This is the AXI control bus into the matrix inverter.

#define         MATINV_CONTROL      AXI_MATINV+0x04*0
// bit 0 = ap_start  (read/write/COH)
// bit 1 = ap_done   (read/COR)
// bit 2 = ap_idle   (read)
// bit 3 = ap_ready  (read)
// bit 7 = auto_restart (read/write)

#define         MATINV_IBRAM        0x00020000 // This is the input bram of the matrix inverter.
#define         MATINV_OBRAM        0x00030000 // This is the output bram of the matrix inverter.



