module program_counter#(parameter PROG_VALUE = 32)
(
input clk,
input rst_n,
input [31:0] pc_in,
output logic [31:0] MUX_4_1_in,
output logic [PROG_VALUE-1:0] A_out
);

//initial A_out = -4;

//always @(posedge clk or negedge rst_n)
//begin
 //  if(!rst_n)
//        A_out <= 0;
 //  else
 //       begin
 //           if(PCSel)
 //               A_out <= ALU_out;
 //           else
 //               A_out <= A_out + 4;
 //       end   
//end


always_comb
begin
    MUX_4_1_in = A_out + 4;  // pc + 4 adder
end




always @(posedge clk) begin
if (!rst_n)	A_out <= 32'h0000_0000;
else  		A_out <= pc_in;
end



endmodule