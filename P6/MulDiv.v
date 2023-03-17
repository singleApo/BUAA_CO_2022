`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:08 12/06/2022 
// Design Name: 
// Module Name:    MulDiv 
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

module MulDiv(
	 input wire clk,
	 input wire reset,
	 input wire [31:0] a,
	 input wire [31:0] b,
	 input wire [3:0] MDUOp,
	 output wire [31:0] out,
	 output wire Busy
    );
	 reg busy;
	 reg [31:0] HI;
	 reg [31:0] HI_tmp;
	 reg [31:0] LO;
	 reg [31:0] LO_tmp;
	 reg [31:0] count;
	 
	 assign out = (MDUOp == `MDU_MFHI) ? HI : 
                 (MDUOp == `MDU_MFLO) ? LO : 0;
	 assign Busy = busy;
					  
	 always @(posedge clk) begin
        if(reset) begin
            HI <= 0;
            LO <= 0;
            HI_tmp <= 0;
            LO_tmp <= 0;
				count <= 0;
				busy <= 0;
        end
        else if(count == 0) begin
			case(MDUOp)
				`MDU_MTHI: begin 
					HI <= a;
				end
				`MDU_MTLO: begin 
					LO <= a;
				end
				`MDU_MULT: begin 
					{HI_tmp, LO_tmp} <= $signed(a) * $signed(b);
					busy <= 1;
					count <= 5;
				end
				`MDU_MULTU: begin 
					{HI_tmp, LO_tmp} <= $unsigned(a) * $unsigned(b);
					busy <= 1;
					count <= 5;
				end
				`MDU_DIV: begin 
					{HI_tmp, LO_tmp} <= {$signed(a) % $signed(b), $signed(a) / $signed(b)};
					busy <= 1;
					count <= 10;
				end
				`MDU_DIVU: begin 
					{HI_tmp, LO_tmp} <= {$unsigned(a) % $unsigned(b), $unsigned(a) / $unsigned(b)};
					busy <= 1;
					count <= 10;
				end
				`MDU_NONE: begin 
					count <= 0;
				end
			endcase
        end
        
		  else if(count == 1) begin
				busy <= 0;
				count <= 0;
				HI <= HI_tmp;
				LO <= LO_tmp;
		  end
		  
		  else begin
            count <= count - 1;
        end
	 end

endmodule
