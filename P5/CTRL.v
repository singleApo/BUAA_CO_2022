`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:42 11/28/2022 
// Design Name: 
// Module Name:    CTRL 
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

module CTRL(
    input wire [5:0] op,
    input wire [5:0] func,
    output wire RegWrite,
    output wire [1:0] RegDst,
    output wire ALUSrc,
    output wire MemWrite,
    output wire WDSrc1,
	output wire WDSrc2,
    output wire [2:0] NPCOp,
    output wire [2:0] ALUOp,
    output wire [1:0] EXTOp,
	output wire [1:0] CMPOp,
	output wire [1:0] Tnew
    );
    reg [18:0] tmp;

    always @(*) begin
		if (op == 0 && func == 0) begin
            tmp <= 0;
        end
        else begin
            case (op)
                6'b0: begin
                    if (func == `ADD) begin
                       tmp <= 19'b1_01_0_0_0_0_000_000_00_00_01; 
                    end
                    else if (func == `SUB) begin
                       tmp <= 19'b1_01_0_0_0_0_000_001_00_00_01; 
                    end
                    else if (func == `JR) begin
                       tmp <= 19'b0_00_0_0_0_0_011_000_00_00_00; 
                    end
                end
                `ORI: begin
                    tmp <= 19'b1_00_1_0_0_0_000_010_00_00_01;    
                end
				`LUI: begin
                    tmp <= 19'b1_00_1_0_0_0_000_000_10_00_01;  
                end
                `LW: begin
                    tmp <= 19'b1_00_1_0_0_1_000_000_01_00_10;  
                end
                `SW: begin
                    tmp <= 19'b0_00_1_1_0_0_000_000_01_00_00;  
                end
                `BEQ: begin
                    tmp <= 19'b0_00_0_0_0_0_001_000_00_00_00;  
                end
                `JAL: begin
                    tmp <= 19'b1_10_0_0_1_0_010_000_00_00_00;
				end
					 
				`ADDEI: begin
                    tmp <= 19'b1_00_1_0_0_0_000_011_11_00_01;
				end
				`BIOAL : begin
                    tmp <= 19'b1_10_0_0_1_0_100_000_00_01_00;
				end
                default: ; 
            endcase
        end
    end

    assign {RegWrite, RegDst, ALUSrc, MemWrite, WDSrc1, WDSrc2, NPCOp, ALUOp, EXTOp, CMPOp, Tnew} = tmp;
	 
endmodule
