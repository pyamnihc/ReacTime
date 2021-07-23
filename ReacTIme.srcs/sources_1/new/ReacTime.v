`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2019 16:27:28
// Design Name: 
// Module Name: ReacTime
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

module ReacTime(
    input clk,
    input stop,
    output [7:0] an,
    output [6:0] segment,
    output DP
    );
    
    wire refresh_clk;
    wire milli_clk;
    
    ClkDiv cd0 (
        .clk_100M (clk),
        .refresh_clk (refresh_clk),
        .milli1_clk (milli_clk)
        );
    
    reg lfsr_clk;
    reg rst_l8 = 0;
    wire [7:0] rand;
       
    LFSR_8 l8 (
        .clk (lfsr_clk),
        .rst (rst_l8),
        .num (rand)
        );
    
    reg count_start;
    reg count_stop;       
    reg rst_cr0;
    wire timed_out;
    wire [9:0] result;    
    
    CountReg cr0 (
            .start (count_start),
            .stop (count_stop),
            .rst (rst_cr0),
            .clk (milli_clk),
            .timed_out (timed_out),
            .count (result)
            );

    EnGen engn0 (
        .refresh_clk (refresh_clk),
        .dig_en (an),
        .DP (DP)
        );
    
    wire [3:0] sec1;
    wire [3:0] milli100;
    wire [3:0] milli10;
    wire [3:0] milli1;
    
    BIN2HEX b2h0 (
        .number (result),
        .sec1 (sec1),        
        .milli100 (milli100),
        .milli10 (milli10),
        .milli1 (milli1)
    ); 
    
    reg [3:0] hex_digit = 0;
 
    SSD d0(
        .hex (hex_digit),
        .segment (segment)
    );

    reg [11:0] r_count;   
    reg state;
    reg [10:0] t_count;
    reg disp_count;
    reg flash;
    reg rst = 1;
    
    always @(posedge milli_clk) begin
        if (rst == 1) begin 
            rst <= 0;
            lfsr_clk <= 0;
            state <= `STOP;
            count_start <= 0;
            count_stop <= 0;
            t_count <= 0;
            r_count <= 0;
        end
        else begin 
            case (state)
                `RUN: begin
                        if (r_count < 16*rand) begin
                            r_count <= r_count + 1;
                        end
                        else begin
                            count_start <= 1;
                            flash <= 1;
                        end
                        
                        if ((r_count == 16*rand && stop == 1) || timed_out == 1) begin
                            count_stop <= 1;
                            r_count <= 0;
                            state <= `STOP;
                        end
                    end
                 
                `STOP: begin 
                        if (t_count < 2000) begin
                            t_count <= t_count + 1;
                            if (t_count < 1000) begin
                                disp_count <= 1;
                                flash <= 0;
                            end
                            else begin
                                disp_count <= 0;
                                flash <= 0;
                                lfsr_clk <= 1;
                                rst_cr0 <= 1;
                                count_start <= 0;
                                count_stop <= 0;
                            end
                        end
                        else begin
                            t_count <= 0;
                            lfsr_clk <= 0;
                            rst_cr0 <= 0;
                            state <= `RUN;
                        end
                       end
                default:;     
            endcase
        end        
    end

    always @(*) begin
        if (disp_count == 1 && flash == 0) begin
            case (an)
                8'b11111110: hex_digit <= milli1;
                8'b11111101: hex_digit <= milli10;
                8'b11111011: hex_digit <= milli100;
                8'b11110111: hex_digit <= sec1;
                default: hex_digit = 15; 
            endcase
        end
        
        else if (disp_count == 0 && flash == 0) begin
            hex_digit <= 15;
        end
        
        else if (flash == 1) begin
            hex_digit <= 10;
        end
    end 
       
endmodule