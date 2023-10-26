`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:49 12/12/2022 
// Design Name: 
// Module Name:    DE 
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

module DE(
    input wire [31:0] addr,
    input wire [31:0] in,
    input wire [2:0] MemOp,
    output wire [31:0] out
    );
    reg [31:0] tmp;
	 
	always @(*) begin
		case (MemOp)
			`MEM_LW: begin
				tmp = in;
			end
			`MEM_LH: begin
				if (addr[1] == 1'b0) begin
					tmp = {{16{in[15]}}, in[15:0]};
				end
				else begin
					tmp = {{16{in[31]}}, in[31:16]};
				end
			end
			`MEM_LB: begin
				if (addr[1:0] == 2'b00) begin
					tmp = {{24{in[7]}}, in[7:0]};
				end
				else if (addr[1:0] == 2'b01) begin
					tmp = {{24{in[15]}}, in[15:8]};
				end
				else if (addr[1:0] == 2'b10) begin
					tmp = {{24{in[23]}}, in[23:16]};
				end
				else begin
					tmp = {{24{in[31]}}, in[31:24]};
				end
			end
			default: tmp = in; 
		endcase
	end

	assign out = tmp;

endmodule
