`timescale 1ns / 1ps



module tranmitter(input t_clk, reset, input [9:0] data_in, output logic d_out, output logic tx_status );
parameter idle = 0;
parameter start = 1;
parameter data = 2;
parameter stop = 3;

logic [1:0] current_state, next_state;
logic [3:0] counter=0;

always@(posedge t_clk or negedge reset)
begin
    if (!reset)
    begin
        current_state<=idle;
        tx_status<=0;
    end
    else if (current_state == idle)
     begin
         tx_status<=0;
	 counter <= 0;
         if(data_in[0]==0) current_state <= next_state;
     end
    else if (current_state == start)
     begin
        d_out <= data_in[counter];
        counter <= counter+1;
        current_state <= next_state;
     end
    else if (current_state == data)
    begin
        d_out <= data_in[counter];
        counter <= counter+1;
        current_state <= next_state;
     end
     else if (current_state==stop)
     begin
         d_out <= data_in[counter];
         current_state <= next_state;
         tx_status<=1;
     end
     else
     begin 
         counter <=0;
         current_state <= next_state;
     end
     
end

always_comb
begin
    case(current_state)
    idle: next_state = (data_in[0]==0 && tx_status==0)? start:idle;
    start: next_state = data; 
    data: next_state = (counter==10) ? stop : data;
    stop: next_state = (tx_status==1)?idle: stop;
    default: next_state = idle;
endcase
end
endmodule
