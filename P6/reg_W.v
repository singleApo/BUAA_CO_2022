`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:13 12/06/2022 
// Design Name: 
// Module Name:    reg_W 
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
module reg_W(
    input wire clk,
    input wire reset,
	 
	 input wire [31:0] ALUOut_M,
	 input wire [31:0] DMOut_M,
	 input wire [4:0] WriteReg_M,
	 input wire [31:0] instr_M,
	 input wire [31:0] PC_M,
	 
	 input wire RegWrite_M,
    input wire WDSrc2_M,
	 input wire [1:0] Tnew_M,
	 
	 output wire [31:0] ALUOut_W,
	 output wire [31:0] DMOut_W,
	 output wire [4:0] WriteReg_W,
	 output wire [31:0] instr_W,
	 output wire [31:0] PC_W,
	 
	 output wire RegWrite_W,
    output wire WDSrc2_W,
	 output wire [1:0] Tnew_W
    );

	 reg [31:0] ALUOut;
	 reg [31:0] DMOut;
	 reg [4:0] WriteReg;
	 reg [31:0] instr;
	 reg [31:0] PC;
	 reg RegWrite;
    reg WDSrc;
	 reg [1:0] Tnew;
	 
	 assign ALUOut_W = ALUOut;
	 assign DMOut_W = DMOut;
	 assign WriteReg_W = WriteReg;
	 assign instr_W = instr;
	 assign PC_W = PC;
	 assign RegWrite_W = RegWrite;
    assign WDSrc2_W = WDSrc;
	 assign Tnew_W = Tnew;
	
	 always @(posedge clk) begin
	     if(reset) begin
				ALUOut <= 0;
				DMOut <= 0;
				WriteReg <= 0;
				instr <= 0;
				PC <= 0;
				RegWrite <= 0;
				WDSrc <= 0;
				Tnew <= 0;
		  end
		  else begin 
				ALUOut <= ALUOut_M;
				DMOut <= DMOut_M;
				WriteReg <= WriteReg_M;
				instr <= instr_M;
				PC <= PC_M;
				RegWrite <= RegWrite_M;
				WDSrc <= WDSrc2_M;
				if(Tnew_M != 0) begin
					Tnew <= Tnew_M - 2'b01;
				end
				else begin
					Tnew <= Tnew_M;
				end
		  end
	 end
endmodule
