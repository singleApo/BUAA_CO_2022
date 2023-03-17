`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:03 10/17/2022 
// Design Name: 
// Module Name:    expr 
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
`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11
module expr(
    input [7:0] in,
    input clk,
    input clr,
    output out
    );

    reg [1:0] status;
	 
    initial begin
        status <= `S0;
    end

    always @(posedge clk or posedge clr) begin
        if(clr == 1) begin
            status <= `S0;
        end
        else begin
            case(status)
            `S0 : begin
                        if (in >= 48 && in <= 57) //0-9
                        begin
                            status <= `S1;
                        end
                        else if (in == 42 || in == 43) //+*
                        begin
                            status <= `S2;
                        end
                        else 
                        begin
                            status <= `S2; //对于一切非正常输出，回到状态2
                        end
                    end
            
            `S1 : begin
                        if (in >= 48 && in <= 57)
                        begin
                            status <= `S2;
                        end
                        else if (in == 42 || in == 43)
                        begin
                            status <= `S3;
                        end
                        else 
                        begin
                            status <= `S2; 
                        end
                    end
            
            `S2 : begin
                        status <= `S2; 
                    end
            
            `S3 : begin
                        if (in >= 48 && in <= 57)
                        begin
                            status <= `S1;
                        end
                        else if (in == 42 || in == 43)
                        begin
                            status <= `S2;
                        end
                        else 
                        begin
                            status <= `S2; 
                        end
                    end
            default : status <= `S2;
            endcase
		  end

    end
	 
	 assign out = (status == `S1)? 1 : 0;

endmodule