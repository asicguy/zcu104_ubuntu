//
module top (
    output logic [3:0] led
);

    logic [39:0]    M00_AXI_araddr;
    logic [2:0]     M00_AXI_arprot;
    logic           M00_AXI_arready;
    logic           M00_AXI_arvalid;
    logic [39:0]    M00_AXI_awaddr;
    logic [2:0]     M00_AXI_awprot;
    logic           M00_AXI_awready;
    logic           M00_AXI_awvalid;
    logic           M00_AXI_bready;
    logic [1:0]     M00_AXI_bresp;
    logic           M00_AXI_bvalid;
    logic [31:0]    M00_AXI_rdata;
    logic           M00_AXI_rready;
    logic [1:0]     M00_AXI_rresp;
    logic           M00_AXI_rvalid;
    logic [31:0]    M00_AXI_wdata;
    logic           M00_AXI_wready;
    logic [3:0]     M00_AXI_wstrb;
    logic           M00_AXI_wvalid;

    logic [39:0]    M01_AXI_araddr;
    logic [2:0]     M01_AXI_arprot;
    logic           M01_AXI_arready;
    logic           M01_AXI_arvalid;
    logic [39:0]    M01_AXI_awaddr;
    logic [2:0]     M01_AXI_awprot;
    logic           M01_AXI_awready;
    logic           M01_AXI_awvalid;
    logic           M01_AXI_bready;
    logic [1:0]     M01_AXI_bresp;
    logic           M01_AXI_bvalid;
    logic [31:0]    M01_AXI_rdata;
    logic           M01_AXI_rready;
    logic [1:0]     M01_AXI_rresp;
    logic           M01_AXI_rvalid;
    logic [31:0]    M01_AXI_wdata;
    logic           M01_AXI_wready;
    logic [3:0]     M01_AXI_wstrb;
    logic           M01_AXI_wvalid;

    logic           axi_aclk;
    logic [0:0]     axi_aresetn;
    
    logic [11:0]matinv_bram0_addr;
    logic matinv_bram0_clk;
    logic [31:0]matinv_bram0_din;
    logic [31:0]matinv_bram0_dout;
    logic matinv_bram0_en;
    logic matinv_bram0_rst;
    logic [3:0]matinv_bram0_we;
    logic [11:0]matinv_bram1_addr;
    logic matinv_bram1_clk;
    logic [31:0]matinv_bram1_din;
    logic [31:0]matinv_bram1_dout;
    logic matinv_bram1_en;
    logic matinv_bram1_rst;
    logic [3:0]matinv_bram1_we;    

    system system_i (
        .M00_AXI_araddr     (M00_AXI_araddr),
        .M00_AXI_arprot     (M00_AXI_arprot),
        .M00_AXI_arready    (M00_AXI_arready),
        .M00_AXI_arvalid    (M00_AXI_arvalid),
        .M00_AXI_awaddr     (M00_AXI_awaddr),
        .M00_AXI_awprot     (M00_AXI_awprot),
        .M00_AXI_awready    (M00_AXI_awready),
        .M00_AXI_awvalid    (M00_AXI_awvalid),
        .M00_AXI_bready     (M00_AXI_bready),
        .M00_AXI_bresp      (M00_AXI_bresp),
        .M00_AXI_bvalid     (M00_AXI_bvalid),
        .M00_AXI_rdata      (M00_AXI_rdata),
        .M00_AXI_rready     (M00_AXI_rready),
        .M00_AXI_rresp      (M00_AXI_rresp),
        .M00_AXI_rvalid     (M00_AXI_rvalid),
        .M00_AXI_wdata      (M00_AXI_wdata),
        .M00_AXI_wready     (M00_AXI_wready),
        .M00_AXI_wstrb      (M00_AXI_wstrb),
        .M00_AXI_wvalid     (M00_AXI_wvalid),
        //
        .M01_AXI_araddr     (M01_AXI_araddr),
        .M01_AXI_arprot     (M01_AXI_arprot),
        .M01_AXI_arready    (M01_AXI_arready),
        .M01_AXI_arvalid    (M01_AXI_arvalid),
        .M01_AXI_awaddr     (M01_AXI_awaddr),
        .M01_AXI_awprot     (M01_AXI_awprot),
        .M01_AXI_awready    (M01_AXI_awready),
        .M01_AXI_awvalid    (M01_AXI_awvalid),
        .M01_AXI_bready     (M01_AXI_bready),
        .M01_AXI_bresp      (M01_AXI_bresp),
        .M01_AXI_bvalid     (M01_AXI_bvalid),
        .M01_AXI_rdata      (M01_AXI_rdata),
        .M01_AXI_rready     (M01_AXI_rready),
        .M01_AXI_rresp      (M01_AXI_rresp),
        .M01_AXI_rvalid     (M01_AXI_rvalid),
        .M01_AXI_wdata      (M01_AXI_wdata),
        .M01_AXI_wready     (M01_AXI_wready),
        .M01_AXI_wstrb      (M01_AXI_wstrb),
        .M01_AXI_wvalid     (M01_AXI_wvalid),
        //
        .axi_aclk           (axi_aclk),
        .axi_aresetn        (axi_aresetn),
        //
        .matinv_bram0_addr  (matinv_bram0_addr),
        .matinv_bram0_clk   (matinv_bram0_clk),
        .matinv_bram0_din   (matinv_bram0_din),
        .matinv_bram0_dout  (matinv_bram0_dout),
        .matinv_bram0_en    (matinv_bram0_en),
        .matinv_bram0_rst   (matinv_bram0_rst),
        .matinv_bram0_we    (matinv_bram0_we),
        //
        .matinv_bram1_addr  (matinv_bram1_addr),
        .matinv_bram1_clk   (matinv_bram1_clk),
        .matinv_bram1_din   (matinv_bram1_din),
        .matinv_bram1_dout  (matinv_bram1_dout),
        .matinv_bram1_en    (matinv_bram1_en),
        .matinv_bram1_rst   (matinv_bram1_rst),
        .matinv_bram1_we    (matinv_bram1_we)        
    );
    
    logic [27:0] led_count;
    always_ff @(posedge axi_aclk) led_count <= led_count + 1;
    assign led[3:2] = led_count[27:26]; 

    // This register file gives software contol over unit under test (UUT).
    logic [15:0][31:0] slv_reg, slv_read;

    assign slv_read[0] = 32'hdeadbeef;
    assign slv_read[1] = 32'h76543210;
    
    assign led[1:0] = slv_reg[2][1:0];

    assign slv_read[15:2] = slv_reg[15:2];

	axi_regfile_v1_0_S00_AXI #	(
		.C_S_AXI_DATA_WIDTH(32),
		.C_S_AXI_ADDR_WIDTH(6) // 16 32 bit registers.
	) axi_regfile_inst (
        // register interface
        .slv_read(slv_read), 
        .slv_reg (slv_reg),  
        // axi interface
		.S_AXI_ACLK    (axi_aclk),
		.S_AXI_ARESETN (axi_aresetn),
        //
		.S_AXI_ARADDR  (M00_AXI_araddr ),
		.S_AXI_ARPROT  (M00_AXI_arprot ),
		.S_AXI_ARREADY (M00_AXI_arready),
		.S_AXI_ARVALID (M00_AXI_arvalid),
		.S_AXI_AWADDR  (M00_AXI_awaddr ),
		.S_AXI_AWPROT  (M00_AXI_awprot ),
		.S_AXI_AWREADY (M00_AXI_awready),
		.S_AXI_AWVALID (M00_AXI_awvalid),
		.S_AXI_BREADY  (M00_AXI_bready ),
		.S_AXI_BRESP   (M00_AXI_bresp  ),
		.S_AXI_BVALID  (M00_AXI_bvalid ),
		.S_AXI_RDATA   (M00_AXI_rdata  ),
		.S_AXI_RREADY  (M00_AXI_rready ),
		.S_AXI_RRESP   (M00_AXI_rresp  ),
		.S_AXI_RVALID  (M00_AXI_rvalid ),
		.S_AXI_WDATA   (M00_AXI_wdata  ),
		.S_AXI_WREADY  (M00_AXI_wready ),
		.S_AXI_WSTRB   (M00_AXI_wstrb  ),
		.S_AXI_WVALID  (M00_AXI_wvalid )
	);

    logic [3:0] mat_addr, inv_addr;
    logic mat_ce, inv_ce, inv_we;
    logic [31:0] mat_data, inv_data;
    matinv matinv_i (
        .s_axi_AXILiteS_AWADDR  (M01_AXI_araddr ),   // input wire [4 : 0] s_axi_AXILiteS_AWADDR
        .s_axi_AXILiteS_AWVALID (M01_AXI_wvalid ),   // input wire s_axi_AXILiteS_AWVALID
        .s_axi_AXILiteS_AWREADY (M01_AXI_awready),   // output wire s_axi_AXILiteS_AWREADY
        .s_axi_AXILiteS_WDATA   (M01_AXI_wdata  ),   // input wire [31 : 0] s_axi_AXILiteS_WDATA
        .s_axi_AXILiteS_WSTRB   (M01_AXI_wstrb  ),   // input wire [3 : 0] s_axi_AXILiteS_WSTRB
        .s_axi_AXILiteS_WVALID  (M01_AXI_wvalid ),   // input wire s_axi_AXILiteS_WVALID
        .s_axi_AXILiteS_WREADY  (M01_AXI_wready ),   // output wire s_axi_AXILiteS_WREADY
        .s_axi_AXILiteS_BRESP   (M01_AXI_bresp  ),   // output wire [1 : 0] s_axi_AXILiteS_BRESP
        .s_axi_AXILiteS_BVALID  (M01_AXI_bvalid ),   // output wire s_axi_AXILiteS_BVALID
        .s_axi_AXILiteS_BREADY  (M01_AXI_bready ),   // input wire s_axi_AXILiteS_BREADY
        .s_axi_AXILiteS_ARADDR  (M01_AXI_araddr ),   // input wire [4 : 0] s_axi_AXILiteS_ARADDR
        .s_axi_AXILiteS_ARVALID (M01_AXI_arvalid),   // input wire s_axi_AXILiteS_ARVALID
        .s_axi_AXILiteS_ARREADY (M01_AXI_arready),   // output wire s_axi_AXILiteS_ARREADY
        .s_axi_AXILiteS_RDATA   (M01_AXI_rdata  ),   // output wire [31 : 0] s_axi_AXILiteS_RDATA
        .s_axi_AXILiteS_RRESP   (M01_AXI_rresp  ),   // output wire [1 : 0] s_axi_AXILiteS_RRESP
        .s_axi_AXILiteS_RVALID  (M01_AXI_rvalid ),   // output wire s_axi_AXILiteS_RVALID
        .s_axi_AXILiteS_RREADY  (M01_AXI_rready ),   // input wire s_axi_AXILiteS_RREADY
        //
        .ap_clk                 (axi_aclk),          // input wire ap_clk
        .ap_rst_n               (axi_aresetn),       // input wire ap_rst_n        
        //
        .A_ce0                  (mat_ce),            // output wire A_ce0
        .A_address0             (mat_addr),          // output wire [3 : 0] A_address0
        .A_q0                   (mat_data),          // input wire [31 : 0] A_q0
        //
        .InverseA_address0      (inv_addr),          // output wire [3 : 0] InverseA_address0
        .InverseA_d0            (inv_data),          // output wire [31 : 0] InverseA_d0
        .InverseA_ce0           (inv_ce),            // output wire InverseA_ce0
        .InverseA_we0           (inv_we),            // output wire InverseA_we0  
        //      
        .interrupt()                                 // output wire interrupt        
    );

    matinv_ram input_ram (
        .clka   (axi_aclk),    // input wire clka
        .ena    (matinv_bram0_en),      // input wire ena
        .wea    (matinv_bram0_we),      // input wire [3 : 0] wea
        .addra  (matinv_bram0_addr[5:2]), // input wire [3 : 0] addra
        .dina   (matinv_bram0_din),    // input wire [31 : 0] dina
        .douta  (matinv_bram0_dout),  // output wire [31 : 0] douta
        //
        .clkb   (axi_aclk), // input wire clkb
        .enb    (mat_ce),   // input wire enb
        .web    (4'h0),     // input wire [3 : 0] web
        .addrb  (mat_addr), // input wire [3 : 0] addrb
        .dinb   (32'd0),    // input wire [31 : 0] dinb
        .doutb  (mat_data)  // output wire [31 : 0] doutb
    );

    matinv_ram output_ram (
        .clka   (axi_aclk),    // input wire clka
        .ena    (matinv_bram1_en),      // input wire ena
        .wea    (matinv_bram1_we),      // input wire [3 : 0] wea
        .addra  (matinv_bram1_addr[5:2]),  // input wire [3 : 0] addra
        .dina   (matinv_bram1_din),    // input wire [31 : 0] dina
        .douta  (matinv_bram1_dout),  // output wire [31 : 0] douta
        //
        .clkb   (axi_aclk), // input wire clkb
        .enb    (mat_ce),   // input wire enb
        .web    (4'h0),     // input wire [3 : 0] web
        .addrb  (inv_addr), // input wire [3 : 0] addrb
        .dinb   (inv_data), // input wire [31 : 0] dinb
        .doutb  ()          // output wire [31 : 0] doutb
    );

endmodule
    
