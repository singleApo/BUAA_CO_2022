`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:05 11/19/2022 
// Design Name: 
// Module Name:    mips 
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
`default_nettype none

module mips(
    input wire clk,
    input wire reset
    );
    wire [31:0] pc;
    wire [31:0] npc;
    wire [31:0] PC4;
    wire zero;
    wire bne_zero;
    wire [31:0] instr;
	 
    wire [5:0] op;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [5:0] func;
    wire [15:0] Imm16;
    wire [25:0] Imm26;
	 
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [4:0] mux1;
    wire [31:0] mux2;
    wire [31:0] mux3;
    wire [31:0] ALUOut;
    wire [31:0] EXTOut;
    wire [31:0] MemOut;
	 
	 
    wire RegWrite;
    wire RegWrite2;
    wire [1:0] RegDst;
    wire ALUSrc;
    wire MemWrite;
    wire [1:0] WDSrc;
    wire [2:0] NPCOp;
    wire [2:0] ALUOp;
    wire [1:0] EXTOp;
	 
    assign op = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign func = instr[5:0];
    assign Imm26 = instr[25:0];
    assign Imm16 = instr[15:0];
	
	assign mux1 = (RegDst == 2'b00) ? rt :
                  (RegDst == 2'b01) ? rd :
                  (RegDst == 2'b10) ? 31 : 0;
	 
	assign mux2 = (ALUSrc == 1'b0) ? RD2 :
                  (ALUSrc == 1'b1) ? EXTOut : 0;
					
	assign mux3 = (WDSrc == 2'b00) ? ALUOut :
                  (WDSrc == 2'b01) ? MemOut :
                  (WDSrc == 2'b10) ? PC4 : 0;
						
	assign RegWrite2 = RegWrite & (~bne_zero);
	 
	PC pc1 (
    .clk(clk), 
    .reset(reset), 
    .in(npc), 
    .out(pc)
    );
	 
	NPC npc1 (
    .in(pc), 
    .Imm26(Imm26), 
    .RA(RD1), 
    .NPCOp(NPCOp), 
    .zero(zero),
	.bne_zero(bne_zero),
    .PC4(PC4), 
    .out(npc)
    );
	 
	IM rom (
    .in(pc), 
    .instr(instr)
    );
	 
	GRF grf32 (
    .clk(clk), 
    .reset(reset), 
    .RegWrite(RegWrite2), 
    .a1(rs), 
    .a2(rt), 
    .a3(mux1), 
    .WD(mux3), 
    .pc(pc), 
    .RD1(RD1), 
    .RD2(RD2)
    );
	 
	CTRL ctrl (
    .op(op), 
    .func(func), 
    .RegWrite(RegWrite), 
    .RegDst(RegDst), 
    .ALUSrc(ALUSrc), 
    .MemWrite(MemWrite), 
    .WDSrc(WDSrc), 
    .NPCOp(NPCOp), 
    .ALUOp(ALUOp), 
    .EXTOp(EXTOp)
    );

	ALU alu (
    .a(RD1), 
    .b(mux2), 
    .ALUOp(ALUOp), 
    .ALUResult(ALUOut), 
    .zero(zero),
	.bne_zero(bne_zero)
    );
	 
	EXT ext (
    .Imm16(Imm16), 
    .EXTOp(EXTOp), 
    .EXTResult(EXTOut)
    );

	DM ram (
    .in(RD2), 
    .addr(ALUOut), 
    .MemWrite(MemWrite), 
    .clk(clk), 
    .reset(reset), 
    .pc(pc), 
    .out(MemOut)
    );
	 
endmodule
