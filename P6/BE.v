`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:33 12/12/2022 
// Design Name: 
// Module Name:    BE 
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

module BE(
    input wire [31:0] addr,
    input wire [2:0] MemOp,
	 input wire [31:0] DMIn,
    output wire [3:0] m_data_byteen,
	 output wire [31:0] m_data_wdata
    );
	 reg [3:0] out;
	 reg [31:0] data;
	 
	 always@(*) begin
		 case (MemOp)
			 `MEM_SW : begin
				 out = 4'b1111;
				 data = DMIn;
			 end
			 `MEM_SH : begin                        //´æDMIn[15:0]
				 if(addr[1] == 1'b0) begin
					out = 4'b0011;
					data = DMIn;
				 end
				 else begin
					out = 4'b1100;                      
					data = {DMIn[15:0],DMIn[15:0]};   //[15:0]->[31:16]
				 end
			 end
			 `MEM_SB : begin                                 //´æDMIn[7:0]
				 if(addr[1:0] == 2'b00) begin
					out = 4'b0001;
					data = DMIn;
				 end
				 else if(addr[1:0] == 2'b01) begin
					out = 4'b0010;
					data = {DMIn[31:16],DMIn[7:0],DMIn[7:0]};  //[7:0]->[15:8]
				 end
				 else if(addr[1:0] == 2'b10) begin
					out = 4'b0100;
					data = {DMIn[31:24],DMIn[7:0],DMIn[15:0]}; //[7:0]->[23:15]
				 end
				 else begin
					out = 4'b1000;
					data = {DMIn[7:0],DMIn[23:0]};             //[7:0]->[31:23]
				 end
			 end
			 default: begin
				 out = 0;
				 data = 0;
			 end
        endcase
	 end

	 assign m_data_byteen = out;
	 assign m_data_wdata = data;
	
endmodule
