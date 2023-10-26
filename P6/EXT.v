`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:48 12/06/2022 
// Design Name: 
// Module Name:    EXT 
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

module EXT(
    input wire [15:0] Imm16,
    input wire [1:0] EXTOp,
    output wire [31:0] EXTOut
    );
    reg [31:0] out;
	 
	always @(*) begin
		case (EXTOp)
			`EXT_ZERO: begin
                out = {16'h0000, Imm16};
            end
            `EXT_SIGN: begin
                out = {{16{Imm16[15]}}, Imm16};
            end
            `EXT_LUI: begin
                out = {Imm16, 16'h0000};
            end
            default: ; 
        endcase
    end
	assign EXTOut = out;

endmodule
