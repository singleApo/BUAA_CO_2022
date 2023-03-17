`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:42:42 12/06/2022 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input wire clk,
    input wire reset,
	 input wire en,
    input wire [31:0] in,
    output wire [31:0] out
    );
    reg [31:0] tmp = 32'h00003000;
    assign out = tmp;

    always @(posedge clk) begin
        if(reset) begin
            tmp <= 32'h00003000;
        end
        else if(en) begin
            tmp <= in;
        end
    end

endmodule
