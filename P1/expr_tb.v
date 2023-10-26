`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:56:09 10/17/2022
// Design Name:   expr
// Module Name:   D:/VerilogWork/P1/Q5/expr_tb.v
// Project Name:  Q5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: expr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module expr_tb;

	// Inputs
	reg [7:0] in;
	reg clk;
	reg clr;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	expr uut (
		.in(in), 
		.clk(clk), 
		.clr(clr), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		clk = 0;
		clr = 1;

		// Wait 100 ns for global reset to finish
		#100;
		in = 48;
		clr = 0;
		#4;
		in = 42;
		#4;
		in = 57;
		#4;
		in = 42;
		#4;
		in = 42;
		#4;
		in = 57;
		clr = 1;
		#4;
		in = 42;
		clr = 0;
		#4;
		in = 48;
		#4;
		in = 42;
		#4;
		in = 57;
        
		// Add stimulus here

	end
	
	always #2 clk = ~clk;
      
endmodule