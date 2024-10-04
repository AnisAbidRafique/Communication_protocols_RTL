`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2024 06:50:29 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb#(parameter REGF_WIDTH = 32,SELECTORS = 5);

    logic clk;
    logic [SELECTORS - 1 :0] rsW;
    logic [SELECTORS - 1 :0] rs1;
    logic [SELECTORS - 1 :0] rs2;
    logic    RegWEn;
    logic [REGF_WIDTH - 1:0] rd;
    logic [REGF_WIDTH -1:0] data1,data2;

// Instantiate the ALU module
register_file #(.REGF_WIDTH(32),.SELECTORS(5)) 
reguut(
        .clk(clk),
        .rsW(rsW),
        .rs1(rs1),
        .rs2(rs2),
        .RegWEn(RegWEn),
        .rd(rd),
        .data1(data1),
        .data2(data2)
    );


always #5 clk = ~clk;

// Test bench
initial 
begin
$stop;
    clk = 0;
    
    #10
    rs1 = 5'b00001;
    rs2 = 5'b10000;
    rsW = 5'b00000;
    RegWEn = 1'b0;
    rd     = 32'hFFFF_00FF;
    #10 
    
    rs1 = 5'b00010;
    rs2 = 5'b00001;
    rsW = 5'b00000;
    RegWEn = 1'b1;
    rd     = 32'hFFFF_00FF;
    #10 
    
    rs1 = 5'b00000;
    rs2 = 5'b00000;
    rsW = 5'b00011;
    RegWEn = 1'b1;
    rd     = 32'hFFFF_00FF;
    #10 
    
    rs1 = 5'b00100;
    rs2 = 5'b00001;
    rsW = 5'b11111;
    RegWEn = 1'b1;
    rd     = 32'hFFFF_00FF;
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
