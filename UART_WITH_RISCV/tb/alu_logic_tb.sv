`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2024 04:45:45 PM
// Design Name: 
// Module Name: alu_logic_tb
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


module alu_logic_tb;

logic [31:0] data1,data2;
logic [3:0]  ALUSel;
logic [31:0] Result;

alu #(.ALU_WIDTH())uutALU
        (
            .data1(data1),
            .data2(data2),
            .ALUSel(ALUSel),
            .Result(Result)
         );
initial
begin
ALUSel = 4'b0000;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0001;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0010;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0011;
data1  = 32'h7EFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0011;
data1  = 32'hFFFFFF27;
data2  = 32'h7FFF5656;
#10
ALUSel = 4'b0100;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0101;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0110;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b0111;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b1000;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;
#10
ALUSel = 4'b1001;
data1  = 32'hEEFF4567;
data2  = 32'hFFFF5656;

end


endmodule
