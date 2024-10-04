`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2024 10:17:56 AM
// Design Name: 
// Module Name: soc_top_tb
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


module soc_top_tb;

    logic clk;
    logic rst_n;
    

soc_top uSoCtop
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
    #100000000;
        
    $finish;
end
endmodule
