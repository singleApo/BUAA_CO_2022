`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:25 12/06/2022 
// Design Name: 
// Module Name:    Hazard 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macro.v"
`default_nettype none

module Hazard(
	input wire [1:0] Tnew_E,
	input wire [1:0] Tnew_M,
	input wire [1:0] Tnew_W,
	input wire [5:0] op,
	input wire [5:0] func,
	input wire RegWrite_E,
	input wire RegWrite_M,
	input wire RegWrite_W,
	input wire [4:0] rs_D,
	input wire [4:0] rt_D,
	input wire [4:0] rs_E,
	input wire [4:0] rt_E,
	input wire [4:0] rt_M,
	input wire [4:0] WriteReg_E,
	input wire [4:0] WriteReg_M,
	input wire [4:0] WriteReg_W,
	input wire [3:0] MDUOp,
	input wire start,
	input wire busy,
	output wire stall,
	output wire [1:0] forward_CMP1,
	output wire [1:0] forward_CMP2,
	output wire [1:0] forward_ALU1,
	output wire [1:0] forward_ALU2,
	output wire forward_DM
    );
	
	wire Tuse_rs0;
	wire Tuse_rs1;
	wire Tuse_rt0;
	wire Tuse_rt1;
	wire Tuse_rt2;
	
	wire stall_rs0_E1;
	wire stall_rs0_E2;
	wire stall_rs0_M1;
	wire stall_rs1_E2;
	wire stall_rt0_E1;
	wire stall_rt0_E2;
	wire stall_rt0_M1;
	wire stall_rt1_E2;
	wire stall_rs;
	wire stall_rt;
	wire stall_md;

	 
	assign Tuse_rs0 = (op == `BEQ) | (op == `BNE) | ((op == 0) & (func == `JR));
	assign Tuse_rs1 = ((op == 0) & ((func == `ADD) | (func == `SUB) | (func == `AND) | (func == `OR) | (func == `SLT) | (func == `SLTU) | (func == `MULT) | (func == `MULTU) | (func == `DIV) | (func == `DIVU) | (func == `MTHI) | (func == `MTLO))) | (op == `ADDI) | (op == `ANDI) | (op == `ORI) | (op == `LUI) | (op == `LW) | (op == `LH) | (op == `LB) | (op == `SW) | (op == `SH) | (op == `SB);
	assign Tuse_rt0 = (op == `BEQ) | (op == `BNE);
	assign Tuse_rt1 = (op == 0) & ((func == `ADD) | (func == `SUB) | (func == `AND) | (func == `OR) | (func == `SLT) | (func == `SLTU) | (func == `MULT) | (func == `MULTU) | (func == `DIV) | (func == `DIVU));
	assign Tuse_rt2 = (op == `SW) | (op == `SH) | (op == `SB);
	
	assign stall_rs0_E1 = Tuse_rs0 & (Tnew_E == 1) & (rs_D == WriteReg_E) & RegWrite_E & (rs_D != 0);
	assign stall_rs0_E2 = Tuse_rs0 & (Tnew_E == 2) & (rs_D == WriteReg_E) & RegWrite_E & (rs_D != 0);
	assign stall_rs0_M1 = Tuse_rs0 & (Tnew_M == 1) & (rs_D == WriteReg_M) & RegWrite_M & (rs_D != 0);
	assign stall_rs1_E2 = Tuse_rs1 & (Tnew_E == 2) & (rs_D == WriteReg_E) & RegWrite_E & (rs_D != 0);
	
	assign stall_rt0_E1 = Tuse_rt0 & (Tnew_E == 1) & (rt_D == WriteReg_E) & RegWrite_E & (rt_D != 0);
	assign stall_rt0_E2 = Tuse_rt0 & (Tnew_E == 2) & (rt_D == WriteReg_E) & RegWrite_E & (rt_D != 0);
	assign stall_rt0_M1 = Tuse_rt0 & (Tnew_M == 1) & (rt_D == WriteReg_M) & RegWrite_M & (rt_D != 0);
	assign stall_rt1_E2 = Tuse_rt1 & (Tnew_E == 2) & (rt_D == WriteReg_E) & RegWrite_E & (rt_D != 0);
	
	assign stall_rs = stall_rs0_E1 | stall_rs0_E2 | stall_rs0_M1 | stall_rs1_E2;
	assign stall_rt = stall_rt0_E1 | stall_rt0_E2 | stall_rt0_M1 | stall_rt1_E2;
	assign stall_md = (MDUOp != `MDU_NONE) & (start | busy);
	assign stall = stall_rs | stall_rt | stall_md;

    assign forward_CMP1 = (rs_D == WriteReg_E && rs_D != 0 && Tnew_E == 0 && RegWrite_E == 1) ? 2'b11 :
						(rs_D == WriteReg_M && rs_D != 0 && Tnew_M == 0 && RegWrite_M == 1) ? 2'b10 :
						(rs_D == WriteReg_W && rs_D != 0 && Tnew_W == 0 && RegWrite_W == 1) ? 2'b01 : 2'b00;
								  
	assign forward_CMP2 = (rt_D == WriteReg_E && rt_D != 0 && Tnew_E == 0 && RegWrite_E == 1) ? 2'b11 :
						(rt_D == WriteReg_M && rt_D != 0 && Tnew_M == 0 && RegWrite_M == 1) ? 2'b10 :
						(rt_D == WriteReg_W && rt_D != 0 && Tnew_W == 0 && RegWrite_W == 1) ? 2'b01 : 2'b00;
								 
    assign forward_ALU1 = (rs_E == WriteReg_M && rs_E != 0 && Tnew_M == 0 && RegWrite_M == 1) ? 2'b10 :
						(rs_E == WriteReg_W && rs_E != 0 && Tnew_W == 0 && RegWrite_W == 1) ? 2'b01 : 2'b00;
							
	assign forward_ALU2 = (rt_E == WriteReg_M && rt_E != 0 && Tnew_M == 0 && RegWrite_M == 1) ? 2'b10 :
						(rt_E == WriteReg_W && rt_E != 0 && Tnew_W == 0 && RegWrite_W == 1) ? 2'b01 : 2'b00;
	
	assign forward_DM = (rt_M == WriteReg_W && rt_M != 0 && Tnew_W == 0 && RegWrite_W == 1) ? 1'b1 : 1'b0;

endmodule
