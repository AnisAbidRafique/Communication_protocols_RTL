module instruction#(parameter IMEM_DEPTH = 64,PROG_VALUE = 32)
(
    input logic [PROG_VALUE - 1 :0] addr,
    output logic [PROG_VALUE - 1:0] instr_addr
);

logic [PROG_VALUE -1 : 0] instr_mem [IMEM_DEPTH - 1:0]; //Instr width and IMEM_DEPTH(words_2bytes) total locations

initial
    begin
        $readmemh("fib_im.mem", instr_mem);
    end


    
logic [PROG_VALUE - 1 :0] temp;

always_comb
    begin
        temp = {2'b00,addr[31:2]};
        instr_addr = instr_mem[temp];
    end
endmodule