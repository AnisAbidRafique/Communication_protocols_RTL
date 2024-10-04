`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2024 10:09:46 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [8:0] Inst,
    input BrEq,BrLT,
    output logic PCSel,BrUn,ASel,BSel,MemRW,RegWEn,
    output logic [2:0] ImmSel,
    output logic [3:0] ALUSel,
    output logic [1:0] WBSel
    );
    
    always_comb
        begin
            casex(Inst)
                 9'b000001100 : //add
                    begin
                        PCSel  = 1'b0; // PC+4
                        ImmSel = 3'bx;
                        BrUn   = 1'bx;
                        ASel   = 1'b0; //Reg A
                        BSel   = 1'b0; //Reg B
                        ALUSel = 4'b0000; // ADD
                        MemRW  = 1'b0;      //Read
                        RegWEn = 1'b1;      //Reg WB Enabled
                        WBSel  = 2'b01; 
                    end
                  9'b100001100 : //sub
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = 3'bx;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = 1'b0;      // Reg B
                        ALUSel = 4'b0001;   // Sub
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end  
                  9'bx0010x100 : //(Op R-R) sll
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0010;   // shift left logical
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     //ALU
                    end  
                  9'bx0100x100 : //(Op R-R) slt
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0011;   // set less then
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end
                  9'bx0110x100 : //(Op R-R) sltu
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0100;   // set less then unsigned
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end  
                  9'bx1000x100 : //(Op R-R) xor
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0101;   // xor
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end 
                  9'b01010x100 : //(Op R-R) srl
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b001;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0110;   // SRL
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end 
                  9'b11010x100 : //(Op R-R) sra
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b001;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b0111;   // SRA
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end 
                  9'bx1100x100 : //(Op R-R) or
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b1000;   // OR
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end 
                  9'bx1110x100 : //(Op R-R) and and andi Both handled
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = (Inst[3]) ? 3'bx : 3'b000 ;
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = (Inst[3]) ? 1'b0 :1'b1;      //Reg B or immi
                        ALUSel = 4'b1001;   // AND
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     
                    end 
                  9'bx00000100 : //addi
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = 3'b000;    // load instruction
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = 1'b1;      //immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     //ALU  
                    end 
                   9'bxxxx00000 : //lw
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = 3'b000;    // Load instr
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b00;     //Mem  
                    end
                  9'bxxxx01000 : //sw
                    begin
                        PCSel  = 1'b0;      // PC+4
                        ImmSel = 3'b010;    // store instr
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b1;      // Write
                        RegWEn = 1'b0;      // Register WB not enabled
                        WBSel  = 2'bxx;     //Dont care  
                    end
                  9'bx00011000 : //beq
                    begin
                        if(!BrEq)
                            begin
                                PCSel  = 1'b0;      // PC+4
                                ImmSel = 3'b011;    // branch instr
                                BrUn   = 1'bx;
                                ASel   = 1'b1;      //PC
                                BSel   = 1'b1;      //B immi
                                ALUSel = 4'b0000;   // add
                                MemRW  = 1'b0;      // Read
                                RegWEn = 1'b0;      // Register WB not enabled
                                WBSel  = 2'bxx;     //Dont care
                            end  
                        else
                            begin
                                PCSel  = 1'b1;      // ALU
                                ImmSel = 3'b011;    // branch instr
                                BrUn   = 1'bx;
                                ASel   = 1'b1;      //PC
                                BSel   = 1'b1;      //B immi
                                ALUSel = 4'b0000;   // add
                                MemRW  = 1'b0;      // Read
                                RegWEn = 1'b0;      // Register WB not enabled
                                WBSel  = 2'bxx;     //Dont care
                            end
                    end
                    9'bx00111000 : //bne
                    begin
                        if(!BrEq)
                            begin
                                PCSel  = 1'b1;      // ALU
                                ImmSel = 3'b011;    // branch instr
                                BrUn   = 1'bx;
                                ASel   = 1'b1;      //PC
                                BSel   = 1'b1;      //B immi
                                ALUSel = 4'b0000;   // add
                                MemRW  = 1'b0;      // Read
                                RegWEn = 1'b0;      // Register WB not enabled
                                WBSel  = 2'bxx;     //Dont care
                            end  
                        else
                            begin
                                PCSel  = 1'b0;      // PC + 4
                                ImmSel = 3'b011;    // branch instr
                                BrUn   = 1'bx;
                                ASel   = 1'b1;      //PC
                                BSel   = 1'b1;      //B immi
                                ALUSel = 4'b0000;   // add
                                MemRW  = 1'b0;      // Read
                                RegWEn = 1'b0;      // Register WB not enabled
                                WBSel  = 2'bxx;     //Dont care
                            end
                    end
                    9'bx10011000 : //blt
                     begin
                     if(BrLT)
                        begin
                            PCSel  = 1'b1;      // ALU
                            ImmSel = 3'b011;    // branch instr
                            BrUn   = 1'b0;
                            ASel   = 1'b1;      //PC
                            BSel   = 1'b1;      //B immi
                            ALUSel = 4'b0000;   // add
                            MemRW  = 1'b0;      // Read
                            RegWEn = 1'b0;      // Register WB not enabled
                            WBSel  = 2'bxx;     //Dont care
                        end
                    end
                   9'bx11011000 : //bltu
                     begin
                     if(BrLT)
                        begin
                            PCSel  = 1'b1;      // ALU
                            ImmSel = 3'b011;    // branch instr
                            BrUn   = 1'b1;
                            ASel   = 1'b1;      //PC
                            BSel   = 1'b1;      //B immi
                            ALUSel = 4'b0000;   // add
                            MemRW  = 1'b0;      // Read
                            RegWEn = 1'b0;      // Register WB not enabled
                            WBSel  = 2'bxx;     //Dont care
                        end
                    end
                   9'bx00011001 : //jalr
                    begin
                        PCSel  = 1'b1;      // ALU
                        ImmSel = 3'b000;    // immi instr
                        BrUn   = 1'bx;
                        ASel   = 1'b0;      //Reg A
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b10;     //PC + 4  
                    end
                   9'bxxxx11011 : //jal
                    begin
                        PCSel  = 1'b1;      // ALU
                        ImmSel = 3'b101;    // j instr
                        BrUn   = 1'bx;
                        ASel   = 1'b1;      //PC
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b10;     //PC + 4  
                    end
                  9'bxxxx00101 : //auipc
                    begin
                        PCSel  = 1'b0;      // PC + 4
                        ImmSel = 3'b100;    // U instr
                        BrUn   = 1'bx;
                        ASel   = 1'b1;      //PC
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b0000;   // add
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     //ALU  
                    end
                  9'bxxxx01101 : //lui
                    begin
                        PCSel  = 1'b0;      // PC + 4
                        ImmSel = 3'b100;    // U instr
                        BrUn   = 1'bx;
                        ASel   = 1'bx;      //PC
                        BSel   = 1'b1;      //B immi
                        ALUSel = 4'b1010;   // b out only
                        MemRW  = 1'b0;      // Read
                        RegWEn = 1'b1;      // Register WB enabled
                        WBSel  = 2'b01;     //ALU  
                    end
            endcase    
        end
    
    
endmodule
