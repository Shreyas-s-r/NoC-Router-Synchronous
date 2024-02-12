`timescale 10ns/ 1ns

module tb();
import interact::*;

 logic clk,reset;
 router_port_f in_f;
 
 router_port_b in_b;
 router_port_f out_f;
 
 router_port_b out_b;


always #10 clk = ~clk;

router  UUT (.clk(clk),.reset(reset),.inPort_f(in_f), .inPort_b(in_b),.outPort_f(out_f),.outPort_b(out_b));

initial
	begin
	clk =0 ;reset = 1;

	#10
	reset = 0;

		in_f[0].data  =35'b0;
		in_f[1].data  =35'b0;
		in_f[2].data  =35'b0;
		in_f[3].data  =35'b0;
		//in_f[4].data  =35'b0;
	
		in_f[4].req = 1;
		in_f[4].data[LINK_WIDTH-1] = 1'b1;
		in_f[4].data[LINK_WIDTH-2] = 1'b1;
		in_f[4].data[LINK_WIDTH-3] = 1'b0;
	   in_f[4].data [LINK_WIDTH-4:0] = 32'b 110_00000_11111_000000_000000_0000_001011;
	   
		# 50
		in_f[4].data[LINK_WIDTH-3] = 1'b1;
	   out_b[4].ack = 1;
		
		#200
	
		in_f[0].data  =35'b0;
		in_f[2].data  =35'b0;
		in_f[3].data  =35'b0;
		in_f[4].data  =35'b0;
		
		in_f[1].req = 1;
		in_f[1].data[LINK_WIDTH-1] = 1;
		in_f[1].data[LINK_WIDTH-2] = 1;
	   in_f[1].data  = 35'b 110_00000_11111_000000_000000_000000_0010;
		
		# 50
		in_f[1].data[LINK_WIDTH-3] = 1;
	   out_b[1].ack = 1;
		 
		#200
	
		in_f[1].data  =35'b0;
		in_f[2].data  =35'b0;
		in_f[3].data  =35'b0;
		in_f[4].data  =35'b0;
		in_f[1].data  =35'b0;
		
		in_f[0].req = 1;
		in_f[0].data[LINK_WIDTH-1] = 1;
		in_f[0].data[LINK_WIDTH-2] = 1;
	   in_f[0].data  = 35'b 110_00000_11111_000000_000000_00000000_00;
		
		# 50
		in_f[0].data[LINK_WIDTH-3] = 1;
	   out_b[0].ack = 1;		 

end

endmodule