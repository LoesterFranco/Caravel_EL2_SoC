
`default_nettype none
`timescale 1ns/1ns

`ifndef AW
`define AW 32
`endif

`ifndef DW
`define DW 64
`endif

module soc_core (
`ifdef USE_POWER_PINS
	input VPWR,
	input VGND,
`endif
	input HCLK, 
	input HRESETn,
	
	input wire 			NMI,

	input  wire [3: 0] 	fdi_Sys0_S0,
	output wire [3: 0] 	fdo_Sys0_S0,
	output wire [0: 0] 	fdoe_Sys0_S0,
	output wire [0: 0] 	fsclk_Sys0_S0,
	output wire [0: 0] 	fcen_Sys0_S0,

	input  wire [15: 0] GPIOIN_Sys0_S2,
	output wire [15: 0] GPIOOUT_Sys0_S2,
	output wire [15: 0] GPIOPU_Sys0_S2,
	output wire [15: 0] GPIOPD_Sys0_S2,
	output wire [15: 0] GPIOOEN_Sys0_S2,

	input  wire [0: 0] RsRx_Sys0_SS0_S0,
	output wire [0: 0] RsTx_Sys0_SS0_S0,

	input  wire [0: 0] RsRx_Sys0_SS0_S1,
	output wire [0: 0] RsTx_Sys0_SS0_S1,

	input wire [0: 0] MSI_Sys0_SS0_S2,
	output wire [0: 0] MSO_Sys0_SS0_S2,
	output wire [0: 0] SSn_Sys0_SS0_S2,
	output wire [0: 0] SCLK_Sys0_SS0_S2,
	input wire [0: 0] MSI_Sys0_SS0_S3,
	output wire [0: 0] MSO_Sys0_SS0_S3,
	output wire [0: 0] SSn_Sys0_SS0_S3,
	output wire [0: 0] SCLK_Sys0_SS0_S3,
	input wire [0: 0] scl_i_Sys0_SS0_S4,
	output wire [0: 0] scl_o_Sys0_SS0_S4,
	output wire [0: 0] scl_oen_o_Sys0_SS0_S4,
	input wire [0: 0] sda_i_Sys0_SS0_S4,
	output wire [0: 0] sda_o_Sys0_SS0_S4,
	output wire [0: 0] sda_oen_o_Sys0_SS0_S4,

	input wire [0: 0] scl_i_Sys0_SS0_S5,
	output wire [0: 0] scl_o_Sys0_SS0_S5,
	output wire [0: 0] scl_oen_o_Sys0_SS0_S5,
	input wire [0: 0] sda_i_Sys0_SS0_S5,
	output wire [0: 0] sda_o_Sys0_SS0_S5,
	output wire [0: 0] sda_oen_o_Sys0_SS0_S5,

	output wire [0: 0] pwm_Sys0_SS0_S6,
	output wire [0: 0] pwm_Sys0_SS0_S7
);

	wire [`AW-1: 0] HADDR_Sys0;
	wire [`DW-1: 0] HWDATA_Sys0;
	wire HWRITE_Sys0;
	wire [1: 0] HTRANS_Sys0;
	wire [2:0] HSIZE_Sys0;

	wire HREADY_Sys0;
	wire [`DW-1: 0] HRDATA_Sys0;

	wire [`DW-1: 0] SRAMRDATA_Sys0_S1;
	wire [7: 0] SRAMWEN_Sys0_S1;
	wire [`DW-1: 0] SRAMWDATA_Sys0_S1;
	wire [0: 0] SRAMCS0_Sys0_S1;
	wire [9: 0] SRAMADDR_Sys0_S1;

	wire [31: 0] M0_IRQ;

	// AHB LITE Master Signals
	wire [`AW-1:0] HADDR;
	wire [0:0]  HREADY;
	wire [0:0]  HWRITE;
	wire [1:0]  HTRANS;
	wire [2:0]  HSIZE;
	wire [`DW-1:0] HWDATA;
	wire [`DW-1:0] HRDATA;
	
	assign HRDATA = HRDATA_Sys0;
	assign HREADY = HREADY_Sys0; 

	assign HADDR_Sys0  = HADDR; 
	assign HWDATA_Sys0 = HWDATA; 
	assign HWRITE_Sys0 = HWRITE; 
	assign HTRANS_Sys0 = HTRANS; 
	assign HSIZE_Sys0  = HSIZE;

	//AHBlite_SYS0 instantiation
	AHBlite_sys_0 ahb_sys_0_uut(
	`ifdef USE_POWER_PINS
		.VPWR(VPWR),
		.VGND(VGND),
	`endif
		.HCLK(HCLK),
		.HRESETn(HRESETn),
	
		.HADDR(HADDR_Sys0),
		.HWDATA(HWDATA_Sys0),
		.HWRITE(HWRITE_Sys0),
		.HTRANS(HTRANS_Sys0),
		.HSIZE(HSIZE_Sys0),
    
		.HREADY(HREADY_Sys0),
		.HRDATA(HRDATA_Sys0),
		
		// QSPI Interface
		.fdi_S0(fdi_Sys0_S0),
		.fdo_S0(fdo_Sys0_S0),
		.fdoe_S0(fdoe_Sys0_S0),
		.fsclk_S0(fsclk_Sys0_S0),
		.fcen_S0(fcen_Sys0_S0),

		// SRAM Interface
		.SRAMRDATA_S1(SRAMRDATA_Sys0_S1),
		.SRAMWEN_S1(SRAMWEN_Sys0_S1),
		.SRAMWDATA_S1(SRAMWDATA_Sys0_S1),
		.SRAMCS0_S1(SRAMCS0_Sys0_S1),
		.SRAMADDR_S1(SRAMADDR_Sys0_S1),

		// GPIO Interface
		.GPIOIN_S2(GPIOIN_Sys0_S2),
		.GPIOOUT_S2(GPIOOUT_Sys0_S2),
		.GPIOPU_S2(GPIOPU_Sys0_S2),
		.GPIOPD_S2(GPIOPD_Sys0_S2),
		.GPIOOEN_S2(GPIOOEN_Sys0_S2),
		
		// APB Bus
		// UART 0
		.RsRx_SS0_S0(RsRx_Sys0_SS0_S0),
		.RsTx_SS0_S0(RsTx_Sys0_SS0_S0),
		
		// UART 1
		.RsRx_SS0_S1(RsRx_Sys0_SS0_S1),
		.RsTx_SS0_S1(RsTx_Sys0_SS0_S1),

		// SPI 0 Interface
		.MSI_SS0_S2(MSI_Sys0_SS0_S2),
		.MSO_SS0_S2(MSO_Sys0_SS0_S2),
		.SSn_SS0_S2(SSn_Sys0_SS0_S2),
		.SCLK_SS0_S2(SCLK_Sys0_SS0_S2),

		// SPI 1 Interface
		.MSI_SS0_S3(MSI_Sys0_SS0_S3),
		.MSO_SS0_S3(MSO_Sys0_SS0_S3),
		.SSn_SS0_S3(SSn_Sys0_SS0_S3),
		.SCLK_SS0_S3(SCLK_Sys0_SS0_S3),

		// I2C 0 Interface
		.scl_i_SS0_S4(scl_i_Sys0_SS0_S4),
		.scl_o_SS0_S4(scl_o_Sys0_SS0_S4),
		.scl_oen_o_SS0_S4(scl_oen_o_Sys0_SS0_S4),
		.sda_i_SS0_S4(sda_i_Sys0_SS0_S4),
		.sda_o_SS0_S4(sda_o_Sys0_SS0_S4),
		.sda_oen_o_SS0_S4(sda_oen_o_Sys0_SS0_S4),

		// I2C 1 Interface
		.scl_i_SS0_S5(scl_i_Sys0_SS0_S5),
		.scl_o_SS0_S5(scl_o_Sys0_SS0_S5),
		.scl_oen_o_SS0_S5(scl_oen_o_Sys0_SS0_S5),
		.sda_i_SS0_S5(sda_i_Sys0_SS0_S5),
		.sda_o_SS0_S5(sda_o_Sys0_SS0_S5),
		.sda_oen_o_SS0_S5(sda_oen_o_Sys0_SS0_S5),

		// PMW 0 & 1 Interfaces
		.pwm_SS0_S6(pwm_Sys0_SS0_S6),
		.pwm_SS0_S7(pwm_Sys0_SS0_S7),

		.IRQ(M0_IRQ)

	);


	RAM_1024x64 RAM (
	`ifdef USE_POWER_PINS
		.VPWR(VPWR),
		.VGND(VGND),
	`endif
		.CLK(HCLK),
		.WE(SRAMWEN_Sys0_S1),
		.EN(SRAMCS0_Sys0_S1),
		.Di(SRAMWDATA_Sys0_S1),
		.Do(SRAMRDATA_Sys0_S1),
		.A(SRAMADDR_Sys0_S1[9:0])
	);

	el2_n5_soc_wrapper EL2 (
	`ifdef USE_POWER_PINS
		.VPWR(VPWR),
		.VGND(VGND),
	`endif
		.HCLK(HCLK),
		.HRESETn(HRESETn),

		.HADDR(HADDR),
		.HREADY(HREADY),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HWDATA(HWDATA),
		.HRDATA(HRDATA),

		//NMI
		.NMI(NMI),

		//Interrupts
		.IRQ(M0_IRQ[30:0])
	);

  endmodule
  