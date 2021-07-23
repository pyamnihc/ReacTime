`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2018 17:42:17
// Design Name: 
// Module Name: en_gen
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

module EnGen(
    input refresh_clk,
    output [7:0] dig_en,
    output reg DP
    );
    reg [7:0] pattern = 8'b11111110;
   
    assign dig_en = pattern;
    
    always @(posedge refresh_clk) begin
        case(pattern)
        8'b11111011: DP <= 0;
        default DP <= 1;
        endcase
        
        pattern <= {pattern[6:0], pattern[7]};

    end
    
endmodule
