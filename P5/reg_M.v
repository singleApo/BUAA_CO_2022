`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:03 12/05/2022 
// Design Name: 
// Module Name:    reg_M 
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
module reg_M(
    input wire clk,
    input wire reset,
	 
	 input wire [31:0] ALUOut_E,
	 input wire [31:0] WriteData_E,
	 input wire [4:0] rs_E,
	 input wire [4:0] rt_E,
	 input wire [4:0] WriteReg_E,
	 input wire [31:0] instr_E,
	 input wire [31:0] PC_E,
	 
	 input wire RegWrite_E,
    input wire MemWrite_E,
    input wire WDSrc2_E,
	 input wire [1:0] Tnew_E,
	 
	 output wire [31:0] ALUOut_M,
	 output wire [31:0] WriteData_M,
	 output wire [4:0] rs_M,
	 output wire [4:0] rt_M,
	 output wire [4:0] WriteReg_M,
	 output wire [31:0] instr_M,
	 output wire [31:0] PC_M,
	 
	 output wire RegWrite_M,
    output wire MemWrite_M,
    output wire WDSrc2_M,
	 output wire [1:0] Tnew_M
    );

	 reg [31:0] ALUOut;
	 reg [31:0] WriteData;
	 reg [4:0] rs;
	 reg [4:0] rt;
	 reg [4:0] WriteReg;
	 reg [31:0] instr;
	 reg [31:0] PC;
	 reg RegWrite;
    reg MemWrite;
    reg WDSrc;
	 reg [1:0] Tnew;
	 
	 assign ALUOut_M = ALUOut;
	 assign WriteData_M = WriteData;
	 assign rs_M = rs;
	 assign rt_M = rt;
	 assign WriteReg_M = WriteReg;
	 assign instr_M = instr;
	 assign PC_M = PC;
	 assign RegWrite_M = RegWrite;
    assign MemWrite_M = MemWrite;
    assign WDSrc2_M = WDSrc;
	 assign Tnew_M = Tnew;
	
	 always @(posedge clk) begin
	     if(reset) begin
				ALUOut <= 0;
				WriteData <= 0;
				rs <= 0;
				rt <= 0;
				WriteReg <= 0;
				instr <= 0;
				PC <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				WDSrc <= 0;
				Tnew <= 0;
		  end
		  else begin 
				ALUOut <= ALUOut_E;
				WriteData <= WriteData_E;
				rs <= rs_E;
				rt <= rt_E;
				WriteReg <= WriteReg_E;
				instr <= instr_E;
				PC <= PC_E;
				RegWrite <= RegWrite_E;
				MemWrite <= MemWrite_E;
				WDSrc <= WDSrc2_E;
				if(Tnew_E != 0) begin
					Tnew <= Tnew_E - 2'b01;
				end
				else begin
					Tnew <= Tnew_E;
				end
		  end
	 end
endmodule	