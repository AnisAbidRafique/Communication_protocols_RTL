`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2024 08:58:04 PM
// Design Name: 
// Module Name: branch_comp
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


module branch_comp(
    input [31:0] A,B,
    input BrUn,
    output logic Eq,Lt
    );
    
    always_comb
        begin
            Eq = (A == B);
            if(BrUn) //unsigned comparsion
                    Lt = A < B ;  
            else
                begin
                    Lt = $signed(A) < $signed(B) ;
                end
        end
endmodule
