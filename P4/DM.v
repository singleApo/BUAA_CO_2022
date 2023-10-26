`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:58 11/20/2022 
// Design Name: 
// Module Name:    DM 
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

module DM(
    input wire [31:0] in,
    input wire [31:0] addr,
    input wire MemWrite,
    input wire clk,
    input wire reset,
	input wire [31:0] pc,
    output wire [31:0] out
    );
    reg [31:0] DM_reg[0:3071];
    assign out = DM_reg[addr[13:2]];
		 
    integer i;
    initial begin
        for (i = 0; i < 3072; i = i + 1) begin
			  DM_reg[i] = 0;
		end
    end

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 3072; i = i + 1) begin
			    DM_reg[i] <= 0;
		    end
        end
        else if (MemWrite) begin
            DM_reg[addr[13:2]] <= in;
            $display("@%h: *%h <= %h", pc, addr, in);
        end
    end
	 
endmodule
