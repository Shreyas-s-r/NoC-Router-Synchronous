
`timescale 10ns/ 1ns

module tb1();
import interact::*;

reg clk,reset;//in_f,out_b; // i/p
router_port_f in_f;
router_port_b in_b;
router_port_f out_f;
router_port_b out_b;
//wire in_b,out_f; // o/p

router  instantiate_router (.clk(clk),.reset(reset),.inPort_f(in_f), .inPort_b(in_b),.outPort_f(out_f),.outPort_b(out_b));

always #10 clk = ~clk;

initial
	begin
	reset = 1;
	// sel0 = 0; sel1=0; sel2=0 sel3; sel4=0;
	//xbarSel = 0;
	
	reset = 0;
	// router_port_f HPUin
	   in_f[0].data  = 35'b 110_00000_00000_000000_000000_00000_00000;
	// in_f.data[0][LINK_WIDTH-2] = 1;
	// in_f.data[0][LINK_WIDTH-3] = 0;
	// in_f.data[0][0:1] = 2'b00;
	
	
	//xbarSel = 20'b 00010000000000000000;
	
	// in_f.data[0][LINK_WIDTH-3] = 1;
	
	reset = 1;
	
	
	end

endmodule

