`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:04 10/17/2022 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output reg [31:0] ext
    );
	reg high;

    always @(*) begin
		high = imm[15];
		case (EOp)
			2'b00: begin
                if (high == 1) ext = {16'b1111111111111111, imm};
				else ext = {16'b0000000000000000, imm};
            end
            2'b01: begin
                ext = {16'b0000000000000000, imm};
            end
            2'b10: begin
                ext = {imm, 16'b0000000000000000};
            end
            2'b11:  begin
                if (high == 1) ext = {16'b1111111111111111, imm} << 2;
				else ext = {16'b0000000000000000, imm} << 2;
            end
            default: ; 
        endcase
    end

endmodule
