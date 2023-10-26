`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:11 11/20/2022 
// Design Name: 
// Module Name:    NPC 
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

module NPC(
    input wire [31:0] in,
    input wire [25:0] Imm26,
    input wire [31:0] RA,
    input wire [2:0] NPCOp,
	input wire zero,
	input wire bne_zero,
    output wire [31:0] PC4,
    output wire [31:0] out
    );
    reg [31:0] tmp;

    assign PC4 = in + 4;
    assign out = tmp;

    always @(*) begin
		case (NPCOp)
			`NPC_PC4: begin
                tmp = in + 4;
            end
            `NPC_BEQ: begin
                if (zero) begin
                    tmp = in + 4 + {{14{Imm26[15]}}, Imm26[15:0], 2'b00};
                end
                else begin
                    tmp = in + 4;
                end
            end
            `NPC_JAL: begin
                tmp = {in[31:28], Imm26, 2'b00};
            end
            `NPC_JR: begin
                tmp = RA;
            end
			`NPC_BNEZALC: begin
                if (bne_zero == 0) begin
                    tmp = in + 4 + {{14{Imm26[15]}}, Imm26[15:0], 2'b00};
                end
                else begin
                    tmp = in + 4;
                end
            end
            default: ; 
        endcase
    end

endmodule
