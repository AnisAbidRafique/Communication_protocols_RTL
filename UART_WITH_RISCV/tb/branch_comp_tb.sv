`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2024 09:32:25 PM
// Design Name: 
// Module Name: branch_comp_tb
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


module branch_comp_tb;

    logic [31:0] A,B;
    logic BrUn;
    logic Eq,Lt;

branch_comp  brut(
    .A(A),.B(B),
    .BrUn(BrUn),
    .Eq(Eq),.Lt(Lt)
    );
    
    initial
    begin
    A = -7;
    B = -11;
    BrUn = 1;
    #10
    A = -7;
    B = -11;
    BrUn = 0;
    
    #10
    A = -7;
    B = -7;
    BrUn = 0;
    
    #10
    A = -7;
    B = -7;
    BrUn = 1;
    
    #10
    A = -15;
    B = -16;
    BrUn = 1;
    
    #10
    A = 0;
    B = 0;
    BrUn = 1;
    #10
    $stop;
    end


endmodule
