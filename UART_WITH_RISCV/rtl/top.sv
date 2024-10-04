module top
(
    input clk,
    input [31 : 0] instr_addr,
    input rst_n,
    inout [31:0] data_WR_inout,
    output [31 : 0] A_out,  //pc for instruction mem input
    output logic [2 : 0 ]funct3, //funct3 for data memory
    output logic [31 : 0 ] Result,
    output MemRW            // control signal for data mem
);

logic [32 -1:0] mux_out_A;
logic [32 -1:0] mux_out_B;
logic [32 -1:0] PC_mux_out;
//logic [31:0] instr_addr;
// logic    [32 - 1:0] Result;
//logic [PROG_VALUE - 1:0] addr;
// logic [32 - 1 :0] A_out;

logic [32 - 1 : 0] operand,data2,data1;
logic [31:0] dataR; 
logic [31:0] MUX_4_1_in;
logic [31:0] ALU_out_mux;
logic BrUn,BrLT,BrEq,RegWEn,PCSel,ASel,BSel;

logic [3:0] ALUSel;
logic [2:0] ImmSel;
logic [1:0] WBSel;
logic [31:0] pc_in;
//logic rd;

MUX_2_1#(.BUS_WIDTH()) uMUX_A
(
    .in_1(data1),
    .in_2(A_out),
    .BSel(ASel),
    .mux_out(mux_out_A)
);

MUX_2_1#(.BUS_WIDTH()) uMUX_B
(
    .in_1(data2),
    .in_2(operand),
    .BSel(BSel),
    .mux_out(mux_out_B)
);

MUX_4_1#(.BUS_WIDTH ()) uALU_out_mux
(
    .in_1(dataR),
    .in_2(Result),
    .in_3(MUX_4_1_in),
    .Sel(WBSel),
    .mux_out(ALU_out_mux)
);
    

alu#(.ALU_WIDTH()) ualu
(
     .data1(mux_out_A),
     .data2(mux_out_B),
     .ALUSel(ALUSel),
     .Result(Result)
);

// data_mem#(.IMEM_DEPTH(),.PROG_VALUE()) udatamem_inst
// (
//     .addr(Result),
//     .dataW(data2),
//     .MemRW(MemRW),
//     .clk(clk),
//     .funct3(instr_addr[14:12]),
//     .dataR(dataR)
// );

assign data_WR_inout = MemRW ? data2 : 32'bz;
assign dataR = data_WR_inout;

assign funct3 = instr_addr[14:12];

register_file#(.REGF_WIDTH(),.SELECTORS())ureg
(   .clk(clk),
    .rsW(instr_addr[11:7]),
    .rs1(instr_addr[19:15]),
    .rs2(instr_addr[24:20]),
    .RegWEn(RegWEn),
    .rd(ALU_out_mux),
    .data1(data1),
    .data2(data2)
);

branch_comp ubranch_comp
(
    .A(data1),
    .B(data2),
    .BrUn(BrUn),
    .Eq(BrEq),
    .Lt(BrLT)
    );
    

    
MUX_2_1#(.BUS_WIDTH()) uMUX_pc
(
    .in_1(MUX_4_1_in),
    .in_2(Result),
    .BSel(PCSel),
    .mux_out(pc_in)
);



//output logic [31:0] MUX_4_1_in,
program_counter#(.PROG_VALUE()) pc
(    .clk(clk),
     .rst_n(rst_n),
     .pc_in(pc_in),
     .MUX_4_1_in(MUX_4_1_in),
     .A_out(A_out)
);


//instruction#(.IMEM_DEPTH(),.PROG_VALUE ()) uinst
//(    .addr(A_out),
//     .instr_addr(instr_addr)
//);
//input [2:0] ImmSel,
imm_gen img
(
    .instr_addr(instr_addr),
    .ImmSel(ImmSel),
    .operand(operand)
);

control_unit ucrtl_unit(
    .Inst({instr_addr[30],instr_addr[14:12],instr_addr[6:2]}),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .PCSel(PCSel),
    .BrUn(BrUn),
    .ASel(ASel),
    .BSel(BSel),
    .MemRW(MemRW),
    .RegWEn(RegWEn),
    .ImmSel(ImmSel),
    .ALUSel(ALUSel),
    .WBSel(WBSel)
    );

//Please uncomment for checking thanks

//tracer tracer_ip (
//                    .clk_i(clk),
//                    .rst_ni(rst_n),
//                    .hart_id_i(32'b0),

//                    .rvfi_valid(1'b1),
//                    .rvfi_insn_t(instr_addr),
//                    .rvfi_rs1_addr_t(instr_addr[19:15]),
//                    .rvfi_rs2_addr_t(instr_addr[24:20]),

//                    .rvfi_rs1_rdata_t(data1),
//                    .rvfi_rs2_rdata_t(data2),

//                    .rvfi_rd_addr_t(instr_addr[11:7]) ,
//                    .rvfi_rd_wdata_t(ALU_out_mux),
//                    .rvfi_pc_rdata_t(A_out),               
//                    .rvfi_pc_wdata_t(pc_in),     
//                    .rvfi_mem_addr(0),
//                    .rvfi_mem_rmask(0),
//                    .rvfi_mem_wmask(0),
//                    .rvfi_mem_rdata(0),
//                    .rvfi_mem_wdata(0)
//                );

endmodule