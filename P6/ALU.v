`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:19 12/06/2022 
// Design Name: 
// Module Name:    ALU 
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

module ALU(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] ALUOp,
    output wire [31:0] ALUOut
    );
	 reg [31:0] tmp;

    always@(*) begin
		case (ALUOp)
			   `ALU_ADD : begin
                tmp = a + b;
            end
				`ALU_SUB : begin
                tmp = a - b;
            end
				`ALU_OR : begin
                tmp = a | b;
            end
           	`ALU_AND : begin
                tmp = a & b;
            end
				`ALU_SLT : begin
                tmp = {31'b0,($signed(a) < $signed(b))};
            end
				`ALU_SLTU : begin
                tmp = {31'b0,(a < b)};
            end
				
            default: ; 
        endcase
    end
	 
	 assign ALUOut = tmp;

endmodule