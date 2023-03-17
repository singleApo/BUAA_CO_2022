`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:28 12/05/2022 
// Design Name: 
// Module Name:    reg_E 
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
`default_nettype none
module reg_E(
    input wire clk,
    input wire reset,
	 
	 input wire [31:0] ALU1_D,
	 input wire [31:0] ALU2_D,
	 input wire [4:0] rs_D,
	 input wire [4:0] rt_D,
	 input wire [4:0] rd_D,
	 input wire [31:0] EXTOut_D,
	 input wire [31:0] instr_D,
	 input wire [31:0] PC_D,
	 
	 input wire RegWrite_D,
    input wire [1:0] RegDst_D,
    input wire ALUSrc_D,
    input wire MemWrite_D,
    input wire WDSrc1_D,
	 input wire WDSrc2_D,
    input wire [2:0] ALUOp_D,
	 input wire [1:0] Tnew_D,
	 
	 output wire [31:0] ALU1_E,
	 output wire [31:0] ALU2_E,
	 output wire [4:0] rs_E,
	 output wire [4:0] rt_E,
	 output wire [4:0] rd_E,
	 output wire [31:0] EXTOut_E,
	 output wire [31:0] instr_E,
	 output wire [31:0] PC_E,
	 
	 output wire RegWrite_E,
    output wire [1:0] RegDst_E,
    output wire ALUSrc_E,
    output wire MemWrite_E,
    output wire WDSrc1_E,
	 output wire WDSrc2_E,
    output wire [2:0] ALUOp_E,
	 output wire [1:0] Tnew_E
    );

	 reg [31:0] ALU1;
	 reg [31:0] ALU2;
	 reg [4:0] rs;
	 reg [4:0] rt;
	 reg [4:0] rd;
	 reg [31:0] EXTOut;
	 reg [31:0] instr;
	 reg [31:0] PC;
	 reg RegWrite;
    reg [1:0] RegDst;
    reg ALUSrc;
    reg MemWrite;
    reg WDSrc1;
	 reg WDSrc2;
    reg [2:0] ALUOp;
	 reg [1:0] Tnew;
	 
	 assign ALU1_E = ALU1;
	 assign ALU2_E = ALU2;
	 assign rs_E = rs;
	 assign rt_E = rt;
	 assign rd_E = rd;
	 assign EXTOut_E = EXTOut;
	 assign instr_E = instr;
	 assign PC_E = PC;
	 assign RegWrite_E = RegWrite;
    assign RegDst_E = RegDst;
    assign ALUSrc_E = ALUSrc;
    assign MemWrite_E = MemWrite;
    assign WDSrc1_E = WDSrc1;
	 assign WDSrc2_E = WDSrc2;
    assign ALUOp_E = ALUOp;
	 assign Tnew_E = Tnew;
	
	 always @(posedge clk) begin
	     if(reset) begin
				ALU1 <= 0;
				ALU2 <= 0;
				rs <= 0;
				rt <= 0;
				rd <= 0;
				EXTOut <= 0;
				instr <= 0;
				PC <= 0;
				RegWrite <= 0;
				RegDst <= 0;
				ALUSrc <= 0;
				MemWrite <= 0;
				WDSrc1 <= 0;
				WDSrc2 <= 0;
				ALUOp <= 0;
				Tnew <= 0;
		  end
		  else begin 
				ALU1 <= ALU1_D;
				ALU2 <= ALU2_D;
				rs <= rs_D;
				rt <= rt_D;
				rd <= rd_D;
				EXTOut <= EXTOut_D;
				instr <= instr_D;
				PC <= PC_D;
				RegWrite <= RegWrite_D;
				RegDst <= RegDst_D;
				ALUSrc <= ALUSrc_D;
				MemWrite <= MemWrite_D;
				WDSrc1 <= WDSrc1_D;
				WDSrc2 <= WDSrc2_D;
				ALUOp <= ALUOp_D;
				Tnew <= Tnew_D;
		  end
	 end
endmodule	

