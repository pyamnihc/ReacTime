`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2019 20:10:21
// Design Name: 
// Module Name: Bin2Hex
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

`timescale 1ns / 1ps
 
module BIN2HEX (
    input  [9:0] number,
    output reg [3:0] sec1,
    output reg [3:0] milli100,
    output reg [3:0] milli10,
    output reg [3:0] milli1
    ); 
   
   // Internal variable for storing bits
   reg [25:0] shift;
   integer i;
   
   always @(number)
   begin
      // Clear previous number and store new number in shift register
      shift[25:10] = 0;
      shift[9:0] = number;
      
      // Loop eight times
      for (i=0; i<10; i=i+1) begin
         if (shift[13:10] >= 5)
            shift[13:10] = shift[13:10] + 3;
            
         if (shift[17:14] >= 5)
            shift[17:14] = shift[17:14] + 3;
            
         if (shift[21:18] >= 5)
            shift[21:18] = shift[21:18] + 3;
         
         if (shift[25:22] >= 5)
            shift[25:22] = shift[25:22] + 3;
         // Shift entire register left once
         shift = shift << 1;
      end   
     
      milli1    = shift[13:10];
      milli10   = shift[17:14];
      milli100  = shift[21:18];
      sec1      = shift[25:22];
   
   end
 
endmodule