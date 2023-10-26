`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:09 11/28/2022 
// Design Name: 
// Module Name:    CMP 
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

module CMP(
    input wire [31:0] c1,
    input wire [31:0] c2,
    input wire [1:0] CMPOp,
    output wire zero,
	output wire overflow
    );
    reg out;
	reg out2;
	reg [63:0] flag;
	 
	always @(*) begin
		case (CMPOp)
			`CMP_BEQ: begin
                out = (c1 == c2);
				out2 = 1;
            end
            `CMP_BIOAL: begin
                flag = {c1[31], c1[31:0]} + {c2[31], c2[31:0]};
				out2 = (flag[32] != flag[31]);
            end
            default: ; 
        endcase
    end

	assign zero = out;
	assign overflow = out2;

endmodule
