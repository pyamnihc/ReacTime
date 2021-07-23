`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2018 09:48:31
// Design Name: 
// Module Name: swatch_regs_dbounce
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
`define RUN 1
`define STOP 0

module CountReg(
    input start,
    input stop,
    input clk,
    input rst,
    output reg timed_out,
    output reg [9:0] count
    );
    
    reg state = `STOP;
    reg start_ff;
    reg stop_ff;
     
    always @(posedge clk) begin
        if (rst == 1) begin
            count <= 0;
            timed_out <= 0;
            state <= `STOP;
            start_ff <= 0;
            stop_ff <= 0;
        end
        
        else begin
            start_ff <= start;
            stop_ff <= stop;
        
            if (start == 1 && start_ff == 0) begin
                state <= `RUN; 
            end
            if (stop == 1 && stop_ff == 0) begin
                state <= `STOP;
            end
            
            if (count == 1000) begin
                timed_out <= 1;
                state <= `STOP;
            end
            else if (state == `RUN) begin
                count <= count + 1;
                timed_out <= 0;
            end
        end
    end
    
endmodule
