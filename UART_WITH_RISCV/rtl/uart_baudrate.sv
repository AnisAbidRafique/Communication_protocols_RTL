`timescale 1ns / 1ps


module baud_rate(input sys_clk, reset, input [1:0] sel_baud, output logic t_clk, r_clk);
parameter DIV_2400 = 50_000_000 / (8 * 2400);
parameter DIV_4800 = 50_000_000 / (8 * 4800);
parameter DIV_9600 = 50_000_000 / (8 * 9600);
parameter DIV_19200 = 50_000_000 / (8 * 19200);
logic [31:0] divisor;
logic [31:0] counter=0;
logic clk_div_8;
logic [2:0] clk_counter=0, r_clk_count=0;

always_comb begin
    case (sel_baud)
        2'b00: divisor = DIV_2400;
        2'b01: divisor = DIV_4800;
        2'b10: divisor = DIV_9600;
        2'b11: divisor = DIV_19200;
        default: divisor = DIV_9600;
    endcase
end

always @(posedge sys_clk or negedge reset) begin
        if (!reset) begin 
            clk_counter <= 0;
            clk_div_8 <= 0;
        end else if (clk_counter == 3) begin
            clk_counter <= 0;
            clk_div_8 <= ~clk_div_8;
        end else begin
            clk_counter <= clk_counter + 1;
        end
end

always @(posedge clk_div_8 or negedge reset) begin
        if (!reset) begin
            r_clk <= 0;
            counter <= 0;
        end else if (counter == divisor) begin
            counter <= 0;
            r_clk <= ~r_clk;
        end else begin
            counter <= counter + 1;
        end
 end

 always @(posedge r_clk or negedge reset) begin
        if (!reset) begin
            t_clk <= 0;
            r_clk_count <= 0;
        end else if (r_clk_count == 3) begin
            r_clk_count <= 0;
            t_clk <= ~t_clk;
        end else begin
            r_clk_count <= r_clk_count + 1;
        end
end

endmodule
