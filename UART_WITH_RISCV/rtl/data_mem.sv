`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2024 03:00:28 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem#(parameter IMEM_DEPTH = 30,PROG_VALUE = 32)
(
    input [PROG_VALUE - 1 : 0] addr,
    input [PROG_VALUE - 1 : 0]dataW,
    input MemRW,
    input clk,
    input [2:0] funct3,
    output logic [PROG_VALUE - 1 : 0]dataR
);

logic [PROG_VALUE - 1 : 0] DMEM [IMEM_DEPTH - 1:0];
logic [31:0] actual_offset,data_fetched_word,data_fetch;
logic [7:0] data_fetched_byte;
logic [15:0] data_fetched_half_word;
logic [1:0] first_two_bits;
logic msb;
logic [31:0] eight_bit_dataW;
logic [31:0] sixteen_bit_dataW;

/*always_comb
    begin
        if(!MemRW)  //Reading memory from the address
            dataR = DMEM[addr];
        else
            dataR = dataR;
    end

always_ff @(posedge clk)
    begin
        if(MemRW) //Writing to data memory
            DMEM[addr] = dataW;
        else
            DMEM[addr] = DMEM[addr]; 
    end
*/

initial
    begin
        //$readmemb("data_m.mem", DMEM);
	for(int i = 0 ; i < IMEM_DEPTH ; i++) begin
	DMEM[i] = 0;
	end
    end

always_ff @(posedge clk)
begin
    if(MemRW) 
    begin
    case(funct3)
        3'b000: //store byte
            begin
                // actual_offset <=  addr & (-4);
                // actual_offset <= {2'b00,addr[31:2]};
                // first_two_bits <= addr & 3;
                if(first_two_bits == 0)
                    begin
                        // eight_bit_dataW <= dataW & 255;
                        // data_fetch    <= ((DMEM[actual_offset] & -256) | eight_bit_dataW);
                        DMEM[actual_offset]      <= data_fetch;
                    end
                else if(first_two_bits == 1)
                    begin
                        // eight_bit_dataW <= (dataW << 8) & 255;
                        // data_fetch <= (DMEM[actual_offset] & ~65280) | eight_bit_dataW;
                        DMEM[actual_offset]      <= data_fetch;
                    end
               else if(first_two_bits == 2)
                    begin
                        // eight_bit_dataW <= (dataW << 16) & 255;
                        // data_fetch <= (DMEM[actual_offset] & ~16711680) | eight_bit_dataW;
                        DMEM[actual_offset]      <= data_fetch;
                    end
               else if(first_two_bits == 3)
                    begin
                        // eight_bit_dataW <= (dataW << 24) & 255;
                        // data_fetch <= (DMEM[actual_offset] & 16777215) | eight_bit_dataW;
                        DMEM[actual_offset]      <= data_fetch;
                    end
                else
                    DMEM[addr] <= DMEM[addr];  // do nothing
            end
            
        3'b001: //store half byte
        begin
            // actual_offset <=  addr & (-4);
            // actual_offset <= {2'b00,addr[31:2]};
            // first_two_bits <= addr & 3;
            if(first_two_bits == 0 || first_two_bits == 1)
                begin
                    // sixteen_bit_dataW <= dataW & 65535;
                    // data_fetch      <= (DMEM[actual_offset] & ~65536) | sixteen_bit_dataW;
                    DMEM[actual_offset]      <= data_fetch;
                end
           else if(first_two_bits == 2 || first_two_bits == 3)
                begin
                    // sixteen_bit_dataW <= (dataW & 65536) << 16;
                    // data_fetch <= (DMEM[actual_offset] & 65535) | sixteen_bit_dataW;
                    DMEM[actual_offset]      <= data_fetch;
                end
            else
                DMEM[addr] <= DMEM[addr];  // do nothing
        end
        3'b010: //store word
            begin
                // actual_offset <=  addr & (-4);
                // actual_offset <= {2'b00,addr[31:2]};
                DMEM[actual_offset] <= dataW;
            end
        
        default: DMEM[addr] <= DMEM[addr]; //nothing
    endcase
    end
else
        DMEM[addr] <= DMEM[addr]; 
end

//store combinational logic
always_comb
begin
    if(MemRW) 
    begin
    case(funct3)
        3'b000: //store byte
            begin
                actual_offset   =  addr & (-4);
                actual_offset   = {2'b00,addr[31:2]};
                first_two_bits  = addr & 3;
                if(first_two_bits == 0)
                    begin
                        eight_bit_dataW     = dataW & 255;
                        data_fetch          = ((DMEM[actual_offset] & -256) | eight_bit_dataW);
                        //DMEM[actual_offset]      <= data_fetch;
                    end
                else if(first_two_bits == 1)
                    begin
                        eight_bit_dataW     = (dataW & 255) << 8;
                        data_fetch          = (DMEM[actual_offset] & ~65280) | eight_bit_dataW;
                        //DMEM[actual_offset]      <= data_fetch;
                    end
               else if(first_two_bits == 2)
                    begin
                        eight_bit_dataW         = (dataW & 255) << 16;
                        data_fetch              = (DMEM[actual_offset] & ~16711680) | eight_bit_dataW;
                        //DMEM[actual_offset]      <= data_fetch;
                    end
               else if(first_two_bits == 3)
                    begin
                        eight_bit_dataW     = (dataW & 255) << 24;
                        data_fetch          = (DMEM[actual_offset] & 16777215) | eight_bit_dataW;
                        //DMEM[actual_offset]      <= data_fetch;
                    end
                else begin
                    eight_bit_dataW = eight_bit_dataW;
                    data_fetch      = data_fetch;
                    end
                    //DMEM[addr] <= DMEM[addr];  // do nothing
            end
            
        3'b001: //store half byte
        begin
            actual_offset       =  addr & (-4);
            actual_offset       = {2'b00,addr[31:2]};
            first_two_bits      = addr & 3;
            if(first_two_bits == 0 || first_two_bits == 1)
                begin
                    sixteen_bit_dataW       = dataW & 65535;
                    data_fetch              = (DMEM[actual_offset] & ~65535) | sixteen_bit_dataW;
                    // DMEM[actual_offset]      <= data_fetch;
                end
           else if(first_two_bits == 2 || first_two_bits == 3)
                begin
                    sixteen_bit_dataW       = (dataW & 65535) << 16;
                    data_fetch              = (DMEM[actual_offset] & 65535) | sixteen_bit_dataW;
                    // DMEM[actual_offset]      <= data_fetch;
                end
            else begin
                sixteen_bit_dataW       = sixteen_bit_dataW;
                data_fetch              = data_fetch;
                end
                // DMEM[addr] <= DMEM[addr];  // do nothing
        end
        3'b010: //store word
            begin
                actual_offset       =  addr & (-4);
                actual_offset       = {2'b00,addr[31:2]};
                // DMEM[actual_offset] <= dataW;
            end
        
        // default: DMEM[addr] <= DMEM[addr]; //nothing
    endcase
    end
else begin
    case(funct3)
        3'b000: //load byte
            begin
                actual_offset =  addr & (-4);
                actual_offset = {2'b00,addr[31:2]};
                first_two_bits = addr & 3;
                data_fetched_word = DMEM[actual_offset];
                if(first_two_bits == 0)
                    begin
                        data_fetched_byte = data_fetched_word & 255;
                        msb = data_fetched_byte[7];
                        dataR = {{24{msb}},data_fetched_byte};
                    end
                else if(first_two_bits == 1)
                    begin
                        data_fetched_word = data_fetched_word & 65280;
                        data_fetched_byte = data_fetched_word >> 8;
                        msb = data_fetched_byte[7];
                        dataR = {{24{msb}},data_fetched_byte};
                    end
               else if(first_two_bits == 2)
                    begin
                        data_fetched_word = data_fetched_word & 16711680;
                        data_fetched_byte = data_fetched_word >> 16;
                        msb = data_fetched_byte[7];
                        dataR = {{24{msb}},data_fetched_byte};
                    end
               else if(first_two_bits == 3)
                    begin
                        data_fetched_word = data_fetched_word >> 24;
                        data_fetched_byte = data_fetched_word & 255;
                        msb = data_fetched_byte[7];
                        dataR = {{24{msb}},data_fetched_byte};
                    end
                else
                    DMEM[addr] = DMEM[addr];  // do nothing
            end
            
        3'b001: //load half byte
        begin
            actual_offset =  addr & (-4);
            actual_offset = {2'b00,addr[31:2]};
            first_two_bits = addr & 3;
            data_fetched_word = DMEM[actual_offset];
            if(first_two_bits == 0 || first_two_bits == 1)
                begin
                    data_fetched_half_word = data_fetched_word & 65535;
                    msb = data_fetched_half_word[15];
                    dataR = {{16{msb}},data_fetched_half_word};
                end
           else if(first_two_bits == 2 || first_two_bits == 3)
                begin
                    data_fetched_word = data_fetched_word >> 16;
                    data_fetched_half_word = data_fetched_word & 65535;
                    msb = data_fetched_half_word[15];
                    dataR = {{16{msb}},data_fetched_half_word};
                end
            else
                DMEM[addr] = DMEM[addr];  // do nothing
        end
        3'b010: //load word
            begin
                actual_offset =  addr & (-4);
                actual_offset = {2'b00,addr[31:2]};
                dataR = DMEM[actual_offset];
            end
        
        3'b100: //load byte unsigned
        begin
            actual_offset =  addr & (-4);
            actual_offset = {2'b00,addr[31:2]};
            first_two_bits = addr & 3;
            data_fetched_word = DMEM[actual_offset];
            if(first_two_bits == 0)
                begin
                    data_fetched_byte = data_fetched_word & 255;
                    msb = 0;
                    dataR = {{24{msb}},data_fetched_byte};
                end
            else if(first_two_bits == 1)
                begin
                    data_fetched_word = data_fetched_word & 65280;
                    data_fetched_byte = data_fetched_word >> 8;
                    msb = 0;
                    dataR = {{24{msb}},data_fetched_byte};
                end
           else if(first_two_bits == 2)
                begin
                    data_fetched_word = data_fetched_word & 16711680;
                    data_fetched_byte = data_fetched_word >> 16;
                    msb = 0;
                    dataR = {{24{msb}},data_fetched_byte};
                end
           else if(first_two_bits == 3)
                begin
                    data_fetched_word = data_fetched_word >> 24;
                    data_fetched_byte = data_fetched_word & 255;
                    msb = 0;
                    dataR = {{24{msb}},data_fetched_byte};
                end
            else
                DMEM[addr] = DMEM[addr];  // do nothing
        end
        
        3'b101: //load half byte unsigned
        begin
            actual_offset =  addr & (-4);
            actual_offset = {2'b00,addr[31:2]};
            first_two_bits = addr & 3;
            data_fetched_word = DMEM[actual_offset];
            if(first_two_bits == 0 || first_two_bits == 1)
                begin
                    data_fetched_half_word = data_fetched_word & 65535;
                    msb = 0;
                    dataR = {{16{msb}},data_fetched_half_word};
                end
           else if(first_two_bits == 2 || first_two_bits == 3)
                begin
                    data_fetched_word = data_fetched_word >> 16;
                    data_fetched_half_word = data_fetched_word & 65535;
                    msb = 0;
                    dataR = {{16{msb}},data_fetched_half_word};
                end
            else
                DMEM[addr] = DMEM[addr];  // do nothing
        end
        default: DMEM[addr] = DMEM[addr]; //nothing
    endcase
    end

end


endmodule
