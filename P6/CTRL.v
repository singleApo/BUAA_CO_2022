`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:29 12/06/2022 
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
    output wire [2:0] MemOp,
    output wire [1:0] WDSrc1,
	output wire WDSrc2,
    output wire [2:0] NPCOp,
    output wire [2:0] ALUOp,
    output wire [1:0] EXTOp,
	output wire [1:0] CMPOp,
	output wire [3:0] MDUOp,
	output wire [1:0] Tnew
    );
    reg [21:0] tmp;
	 
    always @(*) begin
		if (op == 0 && func == 0) begin
            tmp = 0;
        end
        else begin
            case (op)
                6'b0: begin
                    if (func == `ADD) begin
                       tmp = 22'b1_01_0_000_00_0_000_000_00_00_01; 
                    end
                    else if (func == `SUB) begin
                       tmp = 22'b1_01_0_000_00_0_000_001_00_00_01; 
                    end
					else if (func == `AND) begin
                       tmp = 22'b1_01_0_000_00_0_000_011_00_00_01; 
                    end
					else if (func == `OR) begin
                       tmp = 22'b1_01_0_000_00_0_000_010_00_00_01; 
                    end
					else if (func == `SLT) begin
                       tmp = 22'b1_01_0_000_00_0_000_100_00_00_01; 
                    end
					else if (func == `SLTU) begin
                       tmp = 22'b1_01_0_000_00_0_000_101_00_00_01; 
                    end
                    else if (func == `JR) begin
                       tmp = 22'b0_00_0_000_00_0_011_000_00_00_00; 
                    end
					else if (func == `MULT || func == `MULTU || func == `DIV || func == `DIVU || func == `MTHI || func == `MTLO) begin
                       tmp = 22'b0_00_0_000_00_0_000_000_00_00_00; 
                    end
					else if (func == `MFHI || func == `MFLO) begin
                       tmp = 22'b1_01_0_000_10_0_000_000_00_00_01; 
                    end
                end
                `ADDI: begin
                    tmp = 22'b1_00_1_000_00_0_000_000_01_00_01;    
                end
				`ANDI: begin
                    tmp = 22'b1_00_1_000_00_0_000_011_00_00_01;    
                end
				`ORI: begin
                    tmp = 22'b1_00_1_000_00_0_000_010_00_00_01;    
                end
				`LUI: begin
                    tmp = 22'b1_00_1_000_00_0_000_000_10_00_01;  
                end
                `LW: begin
                    tmp = 22'b1_00_1_100_00_1_000_000_01_00_10;  
                end
				`LH: begin
                    tmp = 22'b1_00_1_101_00_1_000_000_01_00_10;  
                end
				`LB: begin
                    tmp = 22'b1_00_1_110_00_1_000_000_01_00_10;  
                end
                `SW: begin
                    tmp = 22'b0_00_1_001_00_0_000_000_01_00_00;  
                end
				`SH: begin
                    tmp = 22'b0_00_1_010_00_0_000_000_01_00_00;  
                end
				`SB: begin
                    tmp = 22'b0_00_1_011_00_0_000_000_01_00_00;  
                end
                `BEQ: begin
                    tmp = 22'b0_00_0_000_00_0_001_000_00_00_00;  
                end
				`BNE: begin
                    tmp = 22'b0_00_0_000_00_0_001_000_00_01_00;  
                end
                `JAL: begin
                    tmp = 22'b1_10_0_000_01_0_010_000_00_00_00;
				end
					 
                default: tmp = 0; 
            endcase
        end
    end

    assign {RegWrite, RegDst, ALUSrc, MemOp, WDSrc1, WDSrc2, NPCOp, ALUOp, EXTOp, CMPOp, Tnew} = tmp;
	 
	assign MDUOp = (op == 0 && func == `MULT) ? 4'b0001 :
                (op == 0 && func == `MULTU) ? 4'b0010 :
				(op == 0 && func == `DIV) ? 4'b0011 :
				(op == 0 && func == `DIVU) ? 4'b0100 :
				(op == 0 && func == `MFHI) ? 4'b0101 :
				(op == 0 && func == `MFLO) ? 4'b0110 :
				(op == 0 && func == `MTHI) ? 4'b0111 :
				(op == 0 && func == `MTLO) ? 4'b1000 : 4'b0000;
	 
endmodule
