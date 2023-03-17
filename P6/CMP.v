`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:47:48 12/06/2022 
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
    output wire CMPOut
    );
    reg out;
	 
	 always@(*) begin
		  case (CMPOp)
			   `CMP_BEQ : begin
                out = (c1 == c2);
            end
            `CMP_BNE : begin
                out = (c1 != c2);
            end
            
            default: ; 
        endcase
    end
	 assign CMPOut = out;

endmodule