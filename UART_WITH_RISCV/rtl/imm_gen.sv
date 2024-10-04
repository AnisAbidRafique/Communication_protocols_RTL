`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2024 03:45:15 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
    input [31:0] instr_addr,
    input [2:0] ImmSel,
    output logic [31:0] operand
    );
    
    logic msb;
    logic [11:0] I_instr,S_instr;
    logic [12:0] B_instr;
    logic [20 : 0]J_instr;
    logic [19:0] U_instr;
    logic [4:0] I_Star_instr;
        
    always_comb
        begin
            case(ImmSel)
                3'b000 : // I type
                        begin
                            msb = instr_addr[31];
                            I_instr = instr_addr[31:20];
                            operand = {{20{msb}},I_instr};
                        end
                        
                3'b001 : // I* type
                        begin
                            msb = 1'b0;
                            I_Star_instr = instr_addr[24:20];
                            operand = {{27{msb}},I_Star_instr};
                        end
                3'b010 : // S type
                        begin
                            msb = instr_addr[31];
                            S_instr = {instr_addr[31:25],instr_addr[11:7]};
                            operand = {{20{msb}},S_instr};
                        end
                3'b011 : // B type
                        begin
                            msb = instr_addr[31];
                            B_instr = {instr_addr[31],instr_addr[7],instr_addr[30:25],instr_addr[11:8],1'b0};
                            operand = {{19{msb}},B_instr};
                        end
                3'b100 :// U type
                        begin
                            msb = 0;
                            U_instr = instr_addr[31:12];
                            operand = {U_instr,{12{msb}}};
                        end
                3'b101 : // J type
                        begin
                           // msb = instr_addr[31];
                            //J_instr = {instr_addr[31],instr_addr[21:12],instr_addr[22],instr_addr[30:23]};
                            //operand = {{12{msb}},J_instr};
                            msb = instr_addr[31];
                            J_instr = {instr_addr[31],instr_addr[19:12],instr_addr[20],instr_addr[30:21],1'b0};
                            operand = {{11{msb}},J_instr};
                        end
                default : operand = 32'bz;
            endcase
        end
        
endmodule
