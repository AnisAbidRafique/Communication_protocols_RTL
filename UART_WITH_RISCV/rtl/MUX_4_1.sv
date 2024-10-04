`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2024 11:27:40 AM
// Design Name: 
// Module Name: MUX_4_1
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


module MUX_4_1#(parameter BUS_WIDTH = 32)
(
    input [BUS_WIDTH - 1 : 0] in_1,in_2,in_3,
    input [1:0] Sel,
    output logic [BUS_WIDTH - 1 : 0] mux_out
);
    
always_comb
    begin
        case(Sel)
            2'b00: mux_out = in_1;
            2'b01: mux_out = in_2;
            2'b10: mux_out = in_3;
            2'b11: mux_out = 32'bx;
            
            default: mux_out = mux_out;
        
        endcase
    end
        
endmodule
