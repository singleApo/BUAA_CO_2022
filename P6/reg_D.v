`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:14 12/06/2022 
// Design Name: 
// Module Name:    reg_D 
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

module reg_D(
	input wire clk,
	input wire en,
	input wire reset,
	input wire [31:0] instr_F,
	input wire [31:0] PC_F,
	output wire [31:0] instr_D,
	output wire [31:0] PC_D
	);
	reg [31:0] instr;
	reg [31:0] PC;

	assign instr_D = instr;
	assign PC_D = PC;
	
	always @(posedge clk) begin
		if (reset) begin
			instr <= 0;
			PC <= 0;
		end
		else if (en) begin 
			instr <= instr_F;
			PC <= PC_F;
		end
	end
endmodule	
