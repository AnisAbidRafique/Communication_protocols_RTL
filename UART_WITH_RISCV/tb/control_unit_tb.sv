`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2024 10:10:25 PM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb;

    logic [8:0] Inst;
    logic BrEq,BrLT;
    logic PCSel,BrUn,ASel,BSel,MemRW,RegWEn;
    logic [2:0] ImmSel;
    logic [3:0] ALUSel;
    logic [1:0] WBSel;

control_unit crtut(
    .Inst(Inst),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .PCSel(PCSel),
    .BrUn(BrUn),
    .ASel(ASel),
    .BSel(BSel),
    .MemRW(MemRW),
    .RegWEn(RegWEn),
    .ImmSel(ImmSel),
    .ALUSel(ALUSel),
    .WBSel(WBSel)
    );
    
    initial
    begin
    Inst =  9'b000001100; //add
    #10
    Inst = 9'b100001100 ; //sub
    #10
    Inst = 9'b000101100 ; //(Op R-R) sll
    #10
    Inst = 9'b001001100 ; //(Op R-R) slt
    #10
    Inst = 9'b001101100 ; //(Op R-R) sltu
    #10
    Inst = 9'b010001100 ; //(Op R-R) xor
    #10
    Inst = 9'b010101100 ; //(Op R-R) srl
    #10
    Inst = 9'b110101100 ; //(Op R-R) sra
    #10
    Inst = 9'b011001100 ; //(Op R-R) or
    #10
    Inst = 9'b011101100 ; //(Op R-R) and
    #10
    Inst = 9'bx00000100 ; //addi
    #10
    Inst = 9'bxxxx00000 ; //lw
    #10
    Inst = 9'bxxxx01000 ; //sw
    #10
    Inst = 9'bx00011000 ; //beq
    BrEq = 0;
    #10
    Inst = 9'bx00011000 ; //beq
    BrEq = 1;
    #10
    Inst = 9'bx00111000 ; //bne
    #10
    Inst = 9'bx00111000 ; //bne
    BrEq = 0;
    #10
    Inst = 9'b010011000 ; //blt
    BrLT = 1;
    #10
    Inst = 9'bx11011000 ; //bltu
    #10
    Inst = 9'b100011001 ; //jalr
    #10
    Inst = 9'b1xxx11011 ; //jal
    #10
    Inst = 9'b1xxx00101 ; //auipc
    
    #10 
            $stop;
    end

endmodule
