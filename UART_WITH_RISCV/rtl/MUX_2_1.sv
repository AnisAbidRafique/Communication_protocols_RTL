`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2024 05:11:58 PM
// Design Name: 
// Module Name: MUX_2_1
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


module MUX_2_1#(parameter BUS_WIDTH = 32)
(
    input [BUS_WIDTH - 1 : 0] in_1,in_2,
    input BSel,
    output logic [BUS_WIDTH - 1 : 0] mux_out
);
    
    always_comb
        begin
            mux_out = (BSel) ? in_2:in_1;
        end
        
endmodule
