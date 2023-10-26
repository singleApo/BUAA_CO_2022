`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:01 10/16/2022 
// Design Name: 
// Module Name:    unblocked 
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
module blocked_and_non_blocked(
   input clk,
   input a,
   output reg b_blocked,
   output reg c_blocked,
   output reg b_non_blocked,
   output reg c_non_blocked
   );

   // ������ֵ
   always @(posedge clk) begin
      b_blocked = a;
      c_blocked = b_blocked;
   end
   // ��������ֵ
   always @(posedge clk) begin
      b_non_blocked <= a;
      c_non_blocked <= b_non_blocked;
   end

endmodule