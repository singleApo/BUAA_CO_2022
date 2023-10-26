`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:55 10/17/2022 
// Design Name: 
// Module Name:    gray 
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
module gray(
   input Clk,
   input Reset,
   input En,
   output reg [2:0] Output,
   output reg Overflow
   );

   integer count = 0;
   initial begin
      Output <= 0;
      Overflow <= 0;
   end

   always @(posedge Clk) begin
      if (Reset) begin
         count <= 0;
         Output <= 0;
         Overflow <= 0;
      end

      else if (En) begin
         count = count + 1;
         if (count == 8) begin
            count = 0;
            Overflow <= 1;
         end

         case (count)
            0: Output <= 3'b000;
            1: Output <= 3'b001;
            2: Output <= 3'b011;
            3: Output <= 3'b010;
            4: Output <= 3'b110;
            5: Output <= 3'b111;
            6: Output <= 3'b101;
            7: Output <= 3'b100;
         endcase
      end
   end
      
endmodule
