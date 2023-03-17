`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:59:32 11/28/2022 
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
`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_OR 3'b010
`define ALU_ADDEI 3'b011

`define EXT_ZERO 2'b00
`define EXT_SIGN 2'b01
`define EXT_LUI 2'b10
`define EXT_ONE 2'b11

`define NPC_PC4 3'b000
`define NPC_BEQ 3'b001
`define NPC_JAL 3'b010
`define NPC_JR 3'b011
`define NPC_BIOAL 3'b100

`define CMP_BEQ 2'b00
`define CMP_BIOAL 2'b01

`define ADD 6'b100000
`define SUB 6'b100010
`define JR 6'b001000
`define ORI 6'b001101
`define LUI 6'b001111
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define JAL 6'b000011
`define ADDEI 6'b110011
`define BIOAL 6'b101101