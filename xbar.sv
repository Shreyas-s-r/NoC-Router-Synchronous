/*
 	  Func format:
		source port:  	   4    3    2    1    0
		dest port:	     3210 4210 3410 3240 3214
*/

module Xbar(func,inPort,outPort);

	import interact::*;

	input [19:0] func;
	input router_port_f inPort;
	output router_port_f outPort;
	
	wire [3:0] sel0, sel1, sel2, sel3, sel4;


	assign sel0 = func[3:0];
	assign sel1 = func[7:4];
	assign sel2 = func[11:8];
	assign sel3 = func[15:12];
	assign sel4 = func[19:16];

assign outPort[0].data =  ( inPort[1].data & {(LINK_WIDTH ){sel1[0]}}	) | 
								  ( inPort[2].data & {(LINK_WIDTH ){sel2[0]}}	) | 
								  ( inPort[3].data & {(LINK_WIDTH ){sel3[0]}}	) | 
								  ( inPort[4].data & {(LINK_WIDTH ){sel4[0]}}	) ;

assign outPort[1].data =  ( inPort[0].data & {(LINK_WIDTH ){sel0[1]}}	) | 
							     ( inPort[2].data & {(LINK_WIDTH ){sel2[1]}}	) | 
								  ( inPort[3].data & {(LINK_WIDTH ){sel3[1]}}	) | 
								  ( inPort[4].data & {(LINK_WIDTH ){sel4[1]}}	) ;

assign outPort[2].data =  ( inPort[0].data & {(LINK_WIDTH ){sel0[2]}}	) | 
								  ( inPort[1].data & {(LINK_WIDTH ){sel1[2]}}	) | 
								  ( inPort[3].data & {(LINK_WIDTH ){sel3[2]}}	) | 
								  ( inPort[4].data & {(LINK_WIDTH ){sel4[2]}}	) ;

assign outPort[3].data =  ( inPort[0].data & {(LINK_WIDTH ){sel0[3]}}	) | 
								  ( inPort[1].data & {(LINK_WIDTH ){sel1[3]}}	) | 
								  ( inPort[2].data & {(LINK_WIDTH ){sel2[3]}}	) | 
								  ( inPort[4].data & {(LINK_WIDTH ){sel4[3]}}	) ;
								  
assign outPort[4].data =  ( inPort[0].data & {(LINK_WIDTH ){sel0[0]}}	) | 
								  ( inPort[1].data & {(LINK_WIDTH ){sel1[1]}}	) | 
								  ( inPort[2].data & {(LINK_WIDTH ){sel2[2]}}	) | 
								  ( inPort[3].data & {(LINK_WIDTH ){sel3[3]}}	) ;

endmodule

