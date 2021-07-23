`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2018 00:04:56
// Design Name: 
// Module Name: ssd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SSD(
input [3:0] hex, //hexadecimal number, 2^4=16 from 0 to F. Use until 9
output reg [6:0] segment // 7 segment output
    );

//active low logic to turn on the segment
//use case statement to represent each hexadecimal number
always @ (hex)
   case (hex) 
		0: segment = 7'b1000000;
		1: segment = 7'b1111001;
		2: segment = 7'b0100100;
		3: segment = 7'b0110000;
		4: segment = 7'b0011001;
		5: segment = 7'b0010010;
		6: segment = 7'b0000010;
		7: segment = 7'b1011000;
		8: segment = 7'b0000000;
		9: segment = 7'b0010000;
		10: segment = 7'b0000000;    //lit af
      default: segment = 7'b1111111; //default is off 
   endcase	
    
endmodule
