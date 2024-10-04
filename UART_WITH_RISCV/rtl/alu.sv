module alu#(parameter ALU_WIDTH = 32)
(
    input           [ALU_WIDTH - 1:0] data1,data2,
    input           [3:0]   ALUSel, //Opcode
    output logic    [ALU_WIDTH - 1:0] Result
);
logic [4:0] temp; 
always_comb
begin
    case(ALUSel)
            4'b0000: Result = data1 + data2;    // Add
            4'b0001: Result = data1 - data2;    //sub
            4'b0010: begin
                    if (data2 > 31)
                        begin
                        temp = data2 & 31;
                        Result = data1 << temp;   // B shifted 1 bit left
                        end
                    else
                        Result = data1 << data2;   // B shifted 1 bit left
                     end
            4'b0011: Result = ($signed(data1) < $signed(data2)) ? 1 : 0 ;  //Set less then
            4'b0100: Result = (data1 < data2) ? 1 : 0 ;  //Set less then unsigned
            4'b0101: Result = data1 ^ data2;     // xor
            4'b0110: begin
                        if (data2 > 31)
                        begin
                            temp = data2 & 31;
                            Result = data1 >> temp;   
                        end
                        else
                            Result = data1 >> data2;// a shifted right logical
                     end       
            4'b0111: begin
                         if (data2 > 31)
                         begin
                             temp = data2 & 31;
                             Result = $signed(data1) >>> temp; 
                         end
                         else
                             Result = $signed(data1) >>> data2; // a shifted right arthematic 
                      end   
            4'b1000: Result = data1 | data2;     // OR
            4'b1001: Result = data1 & data2;     //AND
            4'b1010: Result = data2;             //B out only
            default: Result = Result;
    endcase  
end
endmodule