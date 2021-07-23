`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2019 16:13:54
// Design Name: 
// Module Name: ClkDiv
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

module ClkDiv(
    input clk_100M,
    output refresh_clk,
    output milli1_clk
    );
    
    reg [15:0] count = 0;
    reg [12:0] refresh = 0;
    
    reg tmp_count = 0;
    reg tmp_refresh = 0;
    
    assign milli1_clk = tmp_count;
    assign refresh_clk = tmp_refresh;
    
    always @(posedge clk_100M) begin
        if (count < 50000) begin
            count <= count + 1;
        end
        
        else begin
            tmp_count <= ~tmp_count;
            count <= 0;
        end                   
    end
    
    always @(posedge clk_100M) begin
        if (refresh < 5000) begin
            refresh <= refresh + 1;
        end
    
        else begin
            tmp_refresh <= ~tmp_refresh;
            refresh <= 0;
        end                   
    end
        
endmodule
