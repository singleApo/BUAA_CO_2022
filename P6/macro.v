`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:46 12/06/2022 
// Design Name: 
// Module Name:    macro 
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
`define NPC_PC4 3'b000
`define NPC_Br 3'b001
`define NPC_JAL 3'b010
`define NPC_JR 3'b011

`define EXT_ZERO 2'b00
`define EXT_SIGN 2'b01
`define EXT_LUI 2'b10

`define CMP_BEQ 2'b00
`define CMP_BNE 2'b01

`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_OR 3'b010
`define ALU_AND 3'b011
`define ALU_SLT 3'b100
`define ALU_SLTU 3'b101

`define MDU_NONE 4'b0000
`define MDU_MULT 4'b0001
`define MDU_MULTU 4'b0010
`define MDU_DIV 4'b0011
`define MDU_DIVU 4'b0100
`define MDU_MFHI 4'b0101
`define MDU_MFLO 4'b0110
`define MDU_MTHI 4'b0111
`define MDU_MTLO 4'b1000

`define MEM_NONE 3'b000
`define MEM_SW 3'b001
`define MEM_SH 3'b010
`define MEM_SB 3'b011
`define MEM_LW 3'b100
`define MEM_LH 3'b101
`define MEM_LB 3'b110


`define ADD 6'b100000
`define SUB 6'b100010
`define AND 6'b100100
`define OR 6'b100101
`define SLT 6'b101010
`define SLTU 6'b101011
`define JR 6'b001000

`define MULT 6'b011000
`define MULTU 6'b011001
`define DIV 6'b011010
`define DIVU 6'b011011
`define MFHI 6'b010000
`define MFLO 6'b010010
`define MTHI 6'b010001
`define MTLO 6'b010011


`define ADDI 6'b001000
`define ANDI 6'b001100
`define ORI 6'b001101
`define LUI 6'b001111

`define LW 6'b100011
`define LH 6'b100001
`define LB 6'b100000
`define SW 6'b101011
`define SH 6'b101001
`define SB 6'b101000

`define BEQ 6'b000100
`define BNE 6'b000101
`define JAL 6'b000011
