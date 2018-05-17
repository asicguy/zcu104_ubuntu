//
module top (
    output  logic [39:0]    M00_AXI_araddr,
    output  logic [2:0]     M00_AXI_arprot,
    input   logic           M00_AXI_arready,
    output  logic           M00_AXI_arvalid,
    output  logic [39:0]    M00_AXI_awaddr,
    output  logic [2:0]     M00_AXI_awprot,
    input   logic           M00_AXI_awready,
    output  logic           M00_AXI_awvalid,
    output  logic           M00_AXI_bready,
    input   logic [1:0]     M00_AXI_bresp,
    input   logic           M00_AXI_bvalid,
    input   logic [31:0]    M00_AXI_rdata,
    output  logic           M00_AXI_rready,
    input   logic [1:0]     M00_AXI_rresp,
    input   logic           M00_AXI_rvalid,
    output  logic [31:0]    M00_AXI_wdata,
    input   logic           M00_AXI_wready,
    output  logic [3:0]     M00_AXI_wstrb,
    output  logic           M00_AXI_wvalid,
    output  logic           axi_aclk,
    output  logic [0:0]     axi_aresetn
);


    system system_i (
        .M00_AXI_araddr(M00_AXI_araddr),
        .M00_AXI_arprot(M00_AXI_arprot),
        .M00_AXI_arready(M00_AXI_arready),
        .M00_AXI_arvalid(M00_AXI_arvalid),
        .M00_AXI_awaddr(M00_AXI_awaddr),
        .M00_AXI_awprot(M00_AXI_awprot),
        .M00_AXI_awready(M00_AXI_awready),
        .M00_AXI_awvalid(M00_AXI_awvalid),
        .M00_AXI_bready(M00_AXI_bready),
        .M00_AXI_bresp(M00_AXI_bresp),
        .M00_AXI_bvalid(M00_AXI_bvalid),
        .M00_AXI_rdata(M00_AXI_rdata),
        .M00_AXI_rready(M00_AXI_rready),
        .M00_AXI_rresp(M00_AXI_rresp),
        .M00_AXI_rvalid(M00_AXI_rvalid),
        .M00_AXI_wdata(M00_AXI_wdata),
        .M00_AXI_wready(M00_AXI_wready),
        .M00_AXI_wstrb(M00_AXI_wstrb),
        .M00_AXI_wvalid(M00_AXI_wvalid),
        .axi_aclk(axi_aclk),
        .axi_aresetn(axi_aresetn)
    );

endmodule
