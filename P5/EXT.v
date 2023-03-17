`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:17 11/28/2022 
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
	 
	 always@(*) begin
		  case (EXTOp)
			   `EXT_ZERO : begin
                out = {16'h0000,Imm16};
            end
            `EXT_SIGN : begin
                out = {{16{Imm16[15]}},Imm16};
            end
            `EXT_LUI : begin
                out = {Imm16,16'h0000};
            end
				`EXT_ONE : begin
                out = {16'hffff,Imm16};
            end

            default: ; 
        endcase
    end
	 assign EXTOut = out;

endmodule
