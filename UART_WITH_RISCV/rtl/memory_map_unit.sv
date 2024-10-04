`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 11:52:47 AM
// Design Name: 
// Module Name: memory_map_unit
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


module memory_map_unit
(
    inout logic [31:0] data_core,
    input [2:0] funct3,
    input MemRW_in,
    input [31:0] addr_ALU_OUT,
    input tx_done,
    input [31:0]dataR_mmu,
    output logic [31:0] dataW_mmu,
    output MemRW_out,
    output [2:0] funct3_out,
    output [31:0] addr_ALU_result,
    output logic [7:0] uart_tx


);

// logic [31:0] dataRead_DM;

// assign data_core = !MemRW_in ? dataRead_DM : 32'bz;
// assign dataW_mmu = data_core;

assign data_core = (!MemRW_in && (addr_ALU_OUT != 32'h0000_1604))  ? dataR_mmu : 32'bz;
assign data_core = (!MemRW_in && (addr_ALU_OUT == 32'h0000_1604)) ?  {{7{1'b0}}, tx_done} : 32'bz;

assign MemRW_out = MemRW_in;
assign funct3_out = funct3;
assign addr_ALU_result = addr_ALU_OUT;

always_comb

begin
    if(addr_ALU_OUT == 32'h0000_1600)
        begin
            uart_tx = data_core[7:0];
        end
//    else if (addr_ALU_OUT == 32'h0000_1604)
//        begin
////            data_core = !MemRW_in ? { {7{1'b0}}, tx_done } : 32'bz;
//        end
    else
        begin
            // if(!MemRW_in)
            //     dataRead_DM = dataR_mmu;
            // data_core = !MemRW_in ? data2 : 32'bz;
            // dataRead_DM = data_core;
//            data_core = !MemRW_in ? dataR_mmu : 32'bz;
            dataW_mmu = data_core;

        end
end
endmodule
