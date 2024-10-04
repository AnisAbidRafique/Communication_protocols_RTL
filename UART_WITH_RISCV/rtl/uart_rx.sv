`timescale 1ns / 1ps


module receiver(
input  logic 		r_clk, reset, 
input  logic 		data_in,
output logic [7:0] 	data_out,
output logic 		rx_status
 );
parameter idle = 0;
parameter start = 1;
parameter data = 2;
parameter stop = 3;

logic [1:0] current_state, next_state;
logic [3:0] counter=0 , index=0;
logic [7:0] d_out;

always@(posedge r_clk or negedge reset)
begin
    if (!reset)
    begin
        current_state<=idle;
        index<=0;
        rx_status<=0;
	
    end
     else if (current_state == idle)
     begin
             current_state <= next_state;
	     rx_status<=0;
	     index<=0;
	     counter<= 0;
	end
     else if (current_state == start)
     begin
         if (counter==3)
        begin
            counter<=0;
            current_state<=next_state;
        end
        else
            counter<=counter+1;
        end  
     else if (current_state == data)
     begin
        if (counter==7)
        begin
            counter<=0;
            d_out[index] <= data_in;
            index<=index+1;
        end
        else
        begin
             counter<=counter+1;
        end  
        current_state <= next_state;    
     end
     else if (current_state==stop)
     begin 
          rx_status = 1;
          current_state <= next_state;
     end
     else   
        current_state <= next_state;
  
end

always_comb
begin
    case(current_state)
    idle: next_state = (data_in==0 && rx_status ==0)? start:idle;
    start: next_state = data; 
    data: next_state = (index==8) ? stop : data;
    stop: next_state = (rx_status==1)? idle: stop;
    default: next_state = idle;
endcase

if(rx_status) begin
 $display("%c" ,data_out );
end

end
assign data_out=d_out;

endmodule
