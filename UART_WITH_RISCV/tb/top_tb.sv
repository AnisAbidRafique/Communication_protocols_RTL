`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 03:43:36 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;

    logic clk;
    logic rst_n;
    

top uutop
(
    .clk(clk),
    .rst_n(rst_n)
);

always #5 clk = ~clk;

// Test bench
initial 
begin
    clk = 0;
    rst_n = 0;
    #10; 
    

    rst_n = 1;
    #1000000000;
        
    $finish;
end
endmodule
