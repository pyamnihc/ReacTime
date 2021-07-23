`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2019 16:44:09
// Design Name: 
// Module Name: LFSR_12
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

module LFSR_8(
    input clk, rst,
    output [7:0] num
    );
    
    reg [7:0] out = 0;
    wire feedback;
    
    assign num = out;
    assign feedback = ~(out[7] ^ out[5] ^ out[4] ^ out[3]);
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 0;
        else
            out <= {out[6:0],feedback};
        end
    
endmodule
