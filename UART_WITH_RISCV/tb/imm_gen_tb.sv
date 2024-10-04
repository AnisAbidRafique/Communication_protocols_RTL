`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2024 03:51:52 PM
// Design Name: 
// Module Name: imm_gen_tb
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


module imm_gen_tb;

logic [31:0] instr_addr;
logic [31:0] operand;
logic [2:0]  ImmSel;

imm_gen uutgen(.ImmSel(ImmSel),.instr_addr(instr_addr),.operand(operand));

//always #5 clk = ~clk;

// Test bench
initial 
begin
    #10
    ImmSel = 0;
    instr_addr = 32'b1001_0101_0010_1111_0000_1111_0011_1010;
    #10
    ImmSel = 2;
    instr_addr = 32'b1001_0101_0010_1111_1000_1111_0011_1010;
    #10
    ImmSel = 1;
    instr_addr = 32'b1011_0111_0010_1111_1000_1001_1011_1010;
    #10
    ImmSel = 3;
    instr_addr = 32'b1101_0101_0010_1111_0000_0101_0011_1010;
    #10
    ImmSel = 4;
    instr_addr = 32'b1001_0101_0010_1111_0001_0111_0011_1010;
    
    #10
    ImmSel = 5;
    instr_addr = 32'b0001_0101_0010_1111_0000_1111_0011_1010;
    #10
    ImmSel = 6;
    instr_addr = 32'b1001_0101_0010_1111_0000_1111_0011_1010;
//    rst_n = 1;
    #10 
        $stop;
end
endmodule
