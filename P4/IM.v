`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:42 11/20/2022 
// Design Name: 
// Module Name:    IM 
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

module IM(
  input wire [31:0] in,
  output wire [31:0] instr
  );
  reg [31:0] IM_reg[0:4095];

	integer i;
  initial begin
    for (i = 0; i < 4096; i = i + 1) begin
			IM_reg[i] = 0;
	  end
		$readmemh("code.txt", IM_reg);
  end

  assign instr = IM_reg[in[15:2] - 12'hc00];  // 0x3000 / 4 = 0xc00 = 3072

endmodule
