`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:34 11/28/2022 
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
    input wire [31:0] PC_D,
	 input wire [31:0] PC_F,
    input wire [25:0] Imm26,
    input wire [31:0] RA,
    input wire [2:0] NPCOp,
	 input wire zero,
	 input wire overflow,
    output wire [31:0] out
    );
    reg [31:0] tmp;

    assign out = tmp;

    always@(*) begin
		case (NPCOp)
			   `NPC_PC4 : begin
                tmp = PC_F + 4;
            end
            `NPC_BEQ : begin
                if(zero) begin
                    tmp = PC_D + 4 + {{14{Imm26[15]}},Imm26[15:0],2'b00};
                end
                else begin
                    tmp = PC_F + 4;
                end
            end
            `NPC_JAL : begin
                tmp = {PC_D[31:28],Imm26,2'b00};
            end
            `NPC_JR : begin
                tmp = RA;
            end
				`NPC_BIOAL : begin
                if(overflow) begin
                    tmp = PC_D + 4 + {{14{Imm26[15]}},Imm26[15:0],2'b00};
                end
                else begin
                    tmp = PC_F + 4;
                end
            end
            default: ; 
        endcase
    end

endmodule
