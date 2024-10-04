`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 12:04:31 PM
// Design Name: 
// Module Name: register_file
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
module register_file#(parameter REGF_WIDTH = 32,SELECTORS = 5)
(
    input clk,
    input [SELECTORS - 1 :0] rsW,
    input [SELECTORS - 1 :0] rs1,
    input [SELECTORS - 1 :0] rs2,
    input    RegWEn,
    input [REGF_WIDTH - 1:0] rd,
    output logic [REGF_WIDTH -1:0] data1,data2
);
logic [REGF_WIDTH - 1 : 0] reg_mem [REGF_WIDTH - 1 :0]; //5bits wide and 32 total locations
/*
integer fd; 
integer i; 
initial begin 
 // Create a new file 
 fd = $fopen("regfile.dump", "w"); 
 #100; 
 $fclose(fd); 
end
*/

initial
    begin
        //$readmemh("fib_rf.mem", reg_mem);
	for(int i = 0 ; i < REGF_WIDTH ; i++) begin
	reg_mem[i] = 0;
	end
    end
    
always_comb 
    begin
        if(!rs1)
            data1 = 0;
        else
            data1 = reg_mem[rs1];
        if(!rs2)
            data2 = 0;
        else
            data2 = reg_mem[rs2];
    end    
    
always_ff @(posedge clk)
    begin
        if(RegWEn)
            begin
                if(!rsW)//do nothing
                    reg_mem[rsW] <= reg_mem[rsW];
                else
                    reg_mem[rsW] <= rd;
            end
        else
            reg_mem[rsW] <= reg_mem[rsW]; //Do nothing
    end
/*
always @ (posedge clk) begin
 for (i = 0; i < 32; i=i+1) begin
 $fdisplay(fd,reg_mem[i]); 
end
end
*/
endmodule
