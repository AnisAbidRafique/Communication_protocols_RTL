`timescale 1ns / 1ps

module slaveDUT;
    logic CS, SCLK, SDI, reset;
    logic SDO;

    slave sv(
        .CS(CS), 
        .SCLK(SCLK), 
        .SDI(SDI), 
        .reset(reset),
        .SDO(SDO)
    );
    
    initial begin
        SCLK = 1;
        forever #5 SCLK = ~SCLK;
    end
    
    initial begin
        // Reset sequence
        reset = 0;
        #10
        reset = 1;
        
        // Perfect state scenario
        CS = 1;
        #10 CS = 0;

        // Sending data sequence (assume this sequence)
        // 1 bit for rwCtrl, 11 bits for address, 8 bits for data
        // rwCtrl = 1, address = 11'b11000111001, data = 8'b10110011

        #10 SDI = 1; // rwCtrl
        #10 SDI = 1; // address bit 10
        #10 SDI = 1; // address bit 9
        #10 SDI = 0; // address bit 8
        #10 SDI = 0; // address bit 7
        #10 SDI = 0; // address bit 6
        #10 SDI = 1; // address bit 5
        #10 SDI = 1; // address bit 4
        #10 SDI = 1; // address bit 3
        #10 SDI = 0; // address bit 2
        #10 SDI = 0; // address bit 1
        #10 SDI = 1; // address bit 0

        // Start receiving data bits
        #10 SDI = 1; // data bit 7
        #10 SDI = 0; // data bit 6
        #10 SDI = 1; // data bit 5
        #10 SDI = 1; // data bit 4
        #10 SDI = 0; // data bit 3
        #10 SDI = 0; // data bit 2
        #10 SDI = 1; // data bit 1
        #10 SDI = 1; // data bit 0

        // Wait to finish transfer
        #40 CS = 1;

        // Discard state scenario
        #10 CS = 0;
        #10 SDI = 1;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 1;
        #10 SDI = 1;
        #10 SDI = 1;
        CS = 1;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 1;
        #10 SDI = 0;
        #10 SDI = 1;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 1;
        #10 SDI = 1;
        #10 SDI = 1;
        #10 SDI = 0;
        #10 SDI = 0;
        #10 SDI = 1;
        CS = 1;
    end
endmodule
