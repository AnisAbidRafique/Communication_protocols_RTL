module soc_top
(
    input clk,
    output tx_data,
    input rst_n
);

logic [31:0] A_out;
logic [31:0] instr_addr;
logic [31:0] Result,addr_ALU_result;
logic [2:0] funct3,funct3_out;
logic MemRW,MemRW_out;
logic [31:0] dataR_from_mmu,dataW_to_mmu;
logic t_clk, r_clk,tx_done,t_d_out,rx_status;
logic [7:0] r_d_out,uart_tx;
wire [31:0] Core_data_inout;

// input [31 : 0] instr_addr,
// input rst_n,
// inout data_WR_inout,
// output [31 : 0] A_out,  //pc for instruction mem input
// output logic [2 : 0 ]funct3, //funct3 for data memory
// output MemRW     

instruction#(.IMEM_DEPTH(),.PROG_VALUE ()) uinst
(    .addr(A_out),
     .instr_addr(instr_addr)
);

top 
ucore
(
    .clk(clk),
    .instr_addr(instr_addr),
    .rst_n(rst_n),
    .data_WR_inout(Core_data_inout),
    .A_out(A_out),  //pc for instruction mem input
    .funct3(funct3), //funct3 for data memory
    .Result(Result),
    .MemRW(MemRW)            // control signal for data mem
);

memory_map_unit
ummu
(
    .data_core(Core_data_inout),
    .funct3(funct3),
    .addr_ALU_OUT(Result),
    .MemRW_in(MemRW),
    .tx_done(tx_done),
    .dataR_mmu(dataR_from_mmu),
    .dataW_mmu(dataW_to_mmu),
    .MemRW_out(MemRW_out),
    .funct3_out(funct3_out),
    .uart_tx(uart_tx),
    .addr_ALU_result(addr_ALU_result)


);

//data memory
data_mem#(.IMEM_DEPTH(),.PROG_VALUE()) udatamem_inst
(
    .addr(addr_ALU_result), 
    .dataW(dataW_to_mmu),
    .MemRW(MemRW_out),
    .clk(clk),
    .funct3(funct3_out),
    .dataR(dataR_from_mmu)
);

//uart module
baud_rate b1(   .sys_clk(clk), 
                .reset(rst_n), 
                .sel_baud(2'b10), 
                .t_clk(t_clk), 
                .r_clk(r_clk));

tranmitter t1(
                .t_clk(t_clk), 
                .reset(rst_n), 
                .data_in({1'b1,uart_tx,1'b0}), 
                .d_out(t_d_out),
                .tx_status(tx_done)
                );
receiver r1(
                .r_clk(r_clk), 
                .reset(rst_n),
                .data_in(t_d_out),
                .data_out(r_d_out),
                .rx_status(rx_status)
    );



endmodule