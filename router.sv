module router(clk,reset,inPort_f, inPort_b,outPort_f,outPort_b);

import interact::*;

	input  clk,reset;
	input router_port_f inPort_f;
	output router_port_b inPort_b;
	output router_port_f outPort_f;
	input router_port_b outPort_b;

	wire [3:0] sel0, sel1, sel2, sel3, sel4;


	reg [19:0] xbarSel;
	wire [19:0]  XbarSelNext;
	
	 router_port_f HPUin,HPUout;
	 router_port_f XbarOut;
	 router_port_f XbarOutNext;
	 router_port_f	HPUoutNext;



	HPU port0 (.clk(clk), .reset(reset), .inLine(HPUin[0]), .outLine(HPUoutNext[0]), .sel(sel0) );

	HPU port1 (.clk(clk), .reset(reset), .inLine(HPUin[1]), .outLine(HPUoutNext[1]), .sel(sel1) );

	HPU port2 (.clk(clk), .reset(reset), .inLine(HPUin[2]), .outLine(HPUoutNext[2]), .sel(sel2) );

	HPU port3 (.clk(clk), .reset(reset), .inLine(HPUin[3]), .outLine(HPUoutNext[3]), .sel(sel3) );

	HPU port4 (.clk(clk), .reset(reset), .inLine(HPUin[4]), .outLine(HPUoutNext[4]), .sel(sel4) );

	assign XbarSelNext = {sel4, sel3 , sel2 , sel1 , sel0};

	Xbar xbarinst (.func(xbarSel), .inPort(HPUout), .outPort(XbarOutNext));

	assign outPort_f = XbarOut;
	
	always @( posedge clk ) // reset to be added or not? if added some error occurs and if addede with trigger assgn of value to reset gives error
	begin
		if( reset)
		begin
			xbarSel <= 0;
			reset_router_port_f(XbarOut);
			reset_router_port_f(HPUin);
			reset_router_port_f(HPUout);  
		   reset_router_port_f(XbarOutNext);	
		
		end 
		else
		begin	
			HPUin <= inPort_f;
			
			xbarSel <= XbarSelNext;
			HPUout <= HPUoutNext; 
			XbarOut <= XbarOutNext;
	   
		end 
  end

	
endmodule