`timescale 1ns / 1ps

module slave
(
input CS, SCLK, SDI, reset,
output logic SDO
    );
    
    logic [10:0] instr_addr;
    logic [8 - 1:0] reg_data_in;
    logic [8 -1:0] reg_data_out;
    
    register_file #(.REGF_WIDTH(8 ),.depth(2048))
    ok (
    .clk(SCLK),
    .instr_addr(instr_addr),
    .reg_data_in(reg_data_in),
    .reg_data_out(reg_data_out)
    );
    
    logic [3:0] addrCount, dataCountRx, dataCountTx;
    logic [1:0] writeCount;
    logic [7:0] RxHoldReg;
    logic [10:0] addrHoldReg;
    logic [10:0] TxHoldReg;
    logic [2:0] current_state, next_state;
    logic rwCtrl; //read write bit

    parameter [2:0] idle       = 3'b000;
    parameter [2:0] checkBit   = 3'b001;
    parameter [2:0] readAddr   = 3'b010;
    parameter [2:0] dataRx     = 3'b011; //data receive bit by bit receive ffrom SDI
    parameter [2:0] dataTx     = 3'b100; //data transfer MISO transfer bit by bit on SDO
    parameter [2:0] writeRx    = 3'b101;
    parameter [2:0] error      = 3'b110;
    
    always_ff@(posedge SCLK)
    begin
        if(current_state==idle)
            begin
                addrCount   <= 0; 
                dataCountRx <= 0; 
                dataCountTx <= 0; 
                RxHoldReg <= 0;
                TxHoldReg <= 0;
                writeCount <= 0;
            end
        else if(current_state==checkBit)
            begin
                rwCtrl <= SDI; //first bit
                addrCount <= addrCount+1; //first count
            end
        else if(current_state==readAddr)
            begin
                if(addrCount>3 && addrCount<15)
                    begin
                        addrCount <= addrCount+1;
                        addrHoldReg<={addrHoldReg[9:0], SDI};
                    end
                else
                    addrCount <= addrCount+1;
            end
       else if(current_state==dataTx)
            begin
                if(dataCountTx==0)
                    begin
                        instr_addr <= addrHoldReg;
                        TxHoldReg <= reg_data_out;
                        SDO <= TxHoldReg[7];
                        TxHoldReg <= {TxHoldReg[6:0], 1'b0};
                        dataCountTx <= dataCountTx+1;
                    end
                else if (dataCountTx < 7) begin
                        SDO <= TxHoldReg[7];
                        TxHoldReg <= {TxHoldReg[6:0], 1'b0};
                        dataCountTx <= dataCountTx+1;
                        end
                else 
                        TxHoldReg <= TxHoldReg;
            end
        else if(current_state==dataRx)
            begin
                if(dataCountRx<8)
                    begin
                        RxHoldReg <= {RxHoldReg[6:0], SDI};
                        dataCountRx <= dataCountRx+1;
                    end
                else 
                    RxHoldReg <= RxHoldReg;
            end
        else if(current_state==writeRx)
            begin
                if(writeCount<3)
                    begin
                        instr_addr <= addrHoldReg;
                        reg_data_in<= RxHoldReg;
                        writeCount <= writeCount+1;
                    end
//                else 
//                    RxHoldReg <= RxHoldReg;
            end
        else if(current_state==error)
            begin
                addrCount   <= 0; 
                dataCountRx <= 0; 
                dataCountTx <= 0; 
                RxHoldReg <= 0;
                TxHoldReg <= 0;
                writeCount <= 0;
            end
        else 
            RxHoldReg <= RxHoldReg;
    end
    
    always_comb
    begin
        case(current_state)
            idle:   
                begin
                    if(CS)
                        next_state=idle;
                    else
                        next_state=checkBit;
                end
            checkBit:   
                begin
                    if(addrCount<1 && CS==0)
                        next_state=checkBit;
                    else if(addrCount>=1 && CS==0)
                        next_state=readAddr; 
                    else if(addrCount>=1 && CS==1)
                        next_state=error;
                    else   
                        next_state=checkBit;
                end
            readAddr:
                begin
                    if(addrCount<15 && !CS)
                        next_state = readAddr;
                    else if(addrCount>=15 && !CS && rwCtrl)
                        next_state = dataTx;
                    else if(addrCount>=15 && !CS && !rwCtrl)
                        next_state = dataRx;
                    else if(CS==1)
                        next_state=error;
                    else    
                        next_state = readAddr;
                end 
            dataTx:
                begin
                    if(dataCountTx<8 && !CS)
                        next_state = dataTx;
                    else if(dataCountTx>=8 && !CS)
                        next_state = idle;
                    else if(CS==1)
                        next_state=error;
                    else    
                        next_state = dataTx;
                end 
            dataRx:
                begin
                    if(dataCountRx<8 && !CS)
                        next_state = dataRx;
                    else if(dataCountRx>=8 && !CS)
                        next_state = writeRx;
                    else if(CS==1)
                        next_state=error;
                    else    
                        next_state = dataRx;
                end  
            writeRx:
                begin
                    if(writeCount<3)
                        next_state = writeRx;
                    else if(writeCount>=3)
                        next_state = idle;
                    else    
                        next_state = writeRx;
                end 
            error:
                begin
                    next_state=idle;
                end
            default: next_state=current_state;
       endcase
    end
    
    
    
    always_ff@(posedge SCLK)
    begin
        if(!reset)
        begin
            current_state<=idle;
            SDO<=0;
            addrCount   <= 0; 
            dataCountRx <= 0; 
            dataCountTx <= 0; 
            RxHoldReg <= 0;
            TxHoldReg <= 0;
            writeCount <= 0;
        end
        else 
            begin
                current_state<=next_state;
            end
    end
endmodule
