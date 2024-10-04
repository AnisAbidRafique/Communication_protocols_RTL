`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2024 04:44:40 PM
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb;

logic clk;
logic rst_n;
logic [32-1:0] A_out;

program_counter #(.PROG_VALUE())uutpc
        (
            .clk(clk),
            .rst_n(rst_n),
            .A_out(A_out)
         );

always #5 clk = ~clk;

// Test bench
initial 
begin
    clk = 0;
    rst_n = 0;
    #20
    rst_n = 1;
    
    #200
    rst_n = 0;
    #20
    rst_n = 1;
        
        $stop;
end
endmodule
