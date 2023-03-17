`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:59 11/28/2022 
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
	 reg [63:0] overflow;
	 
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
            `ALU_ADDEI : begin
                overflow = {b[31],b[31:0]} + {a[31],a[31:0]};
					 if(overflow[32] != overflow[31]) begin
						tmp = b;
					 end
					 else begin
						tmp = overflow[31:0];
					 end
            end
				
            default: ; 
        endcase
    end
	 
	 assign ALUOut = tmp;

endmodule
