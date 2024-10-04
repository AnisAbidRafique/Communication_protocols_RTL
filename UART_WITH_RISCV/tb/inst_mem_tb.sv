`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2024 06:49:29 PM
// Design Name: 
// Module Name: inst_mem_tb
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


module inst_mem_tb#(parameter IMEM_DEPTH = 21,PROG_VALUE = 32);

    logic [PROG_VALUE - 1 :0] addr;
    logic [PROG_VALUE - 1:0] instr_addr;

// Instantiate the ALU module
instruction #(.IMEM_DEPTH(IMEM_DEPTH),.PROG_VALUE(PROG_VALUE)) 
instruut(
        .addr(addr),
        .instr_addr(instr_addr)
    );

// Test bench
initial 
begin
$stop;
    
    #10
    addr  = 0;
    #10 
    addr  = 4;
    #10 
    addr  = 8;
    #10  
    addr  = 12;
    #10 
    addr  = 16;
    #10 
    addr  = 20;
    #10 
    addr  = 24;
    #10 
    addr  = 28;
    #10 
    addr  = 5;
    #10 
        $stop;
end
/*
initial
begin
    $display("A = %b, B = %b, S = %b", A, B, S);
    $display("Result: R = %b, C = %b, V = %b", R, C, V);
end*/
endmodule
