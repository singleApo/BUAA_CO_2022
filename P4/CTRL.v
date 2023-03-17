`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:17 11/20/2022 
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
    output wire [1:0] WDSrc,
    output wire [2:0] NPCOp,
    output wire [2:0] ALUOp,
    output wire [1:0] EXTOp
    );
    reg [14:0] tmp;

    always@(*) begin
		  if(op == 0 && func == 0) begin
            tmp <= 0;
        end
        else begin
            case (op)
                6'b0 : begin
                    if(func == `ADD) begin
                       tmp <= 15'b1_01_0_0_00_000_000_00; 
                    end
                    else if(func == `SUB) begin
                       tmp <= 15'b1_01_0_0_00_000_001_00; 
                    end
                    else if(func == `JR) begin
                       tmp <= 15'b0_00_0_0_00_011_000_00; 
                    end
                end
                `ORI : begin
                    tmp <= 15'b1_00_1_0_00_000_010_00;    
                end
                `LW: begin
                    tmp <= 15'b1_00_1_0_01_000_000_01;  
                end
                `SW : begin
                    tmp <= 15'b0_00_1_1_00_000_000_01;  
                end
                `BEQ : begin
                    tmp <= 15'b0_00_0_0_00_001_001_00;  
                end
                `LUI : begin
                    tmp <= 15'b1_00_1_0_00_000_000_10;  
                end
                `JAL : begin
                    tmp <= 15'b1_10_0_0_10_010_000_00;
					 end
					 `RLB : begin
                    tmp <= 15'b1_00_1_0_00_000_011_00;						  
                end
					 `BNEZALC : begin
                    tmp <= 15'b1_10_0_0_10_100_100_00;						  
                end
                default: ; 
            endcase
        end
    end

    assign {RegWrite, RegDst, ALUSrc, MemWrite, WDSrc, NPCOp, ALUOp, EXTOp} = tmp;

endmodule

