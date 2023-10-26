`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:07:41 11/28/2022 
// Design Name: 
// Module Name:    GRF 
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

module GRF(
    input wire clk,
    input wire reset,
    input wire RegWrite,
    input wire [4:0] a1,
    input wire [4:0] a2,
    input wire [4:0] a3,
    input wire [31:0] WD,
    input wire [31:0] pc,
    output wire [31:0] RD1,
    output wire [31:0] RD2
    );
    reg [31:0] GRF_reg[0:31];

    integer i;
    initial begin
      for (i = 0; i < 32; i = i + 1) begin
        GRF_reg[i] = 0;
      end
    end

    always @(posedge clk) begin
        if (reset) begin
          for (i = 0; i < 32; i = i + 1) begin
			      GRF_reg[i] <= 0;
		      end
        end
        else if (RegWrite == 1 && a3 > 0) begin
            GRF_reg[a3] <= WD;
            $display("%d@%h: $%d <= %h", $time, pc, a3, WD);
        end
    end

    assign RD1 = GRF_reg[a1];
    assign RD2 = GRF_reg[a2];

endmodule

