`timescale 1ns / 1ps

module register_file#(parameter REGF_WIDTH = 8, parameter depth=2048)
(
    input clk,
    input [10:0] instr_addr,
    input [REGF_WIDTH - 1:0] reg_data_in,
    output logic [REGF_WIDTH -1:0] reg_data_out
);
    logic [REGF_WIDTH-1 : 0] reg_mem [depth-1:0]; //REGF_WIDTH wide and 2048 total location


    initial
    begin
    $readmemb("spiReg.mem", reg_mem);
    end
    
    always_comb 
    begin
        reg_data_out = reg_mem[instr_addr]; //read data and sending to output
    end    
    
    always_ff @(posedge clk)
    begin
        reg_mem[instr_addr] <= reg_data_in; //write data from the data 
    end

endmodule