`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:17:03 11/19/2022 
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
    output wire [31:0] ALUResult,
    output wire zero,
	 output wire bne_zero
    );
	 reg [31:0] rev;
	 reg [31:0] tmp;
	 wire [4:0] imm;
	 assign imm = b[4:0];
	 integer i;
	 
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
            `ALU_RLB : begin
					for(i=0; i<imm; i=i+1) begin
						tmp[i] = ~a[i];
					end
					for(i=imm; i<32; i=i+1) begin
						tmp[i] = a[i];
					end
				end
				`ALU_BNEZALC : begin
                tmp = a;
            end
            default: ; 
        endcase
    end
	 
	 assign ALUResult = tmp;
    assign zero = (ALUResult == 0);
	 assign bne_zero = (ALUResult == 0)&(ALUOp == `ALU_BNEZALC);
               	
endmodule

