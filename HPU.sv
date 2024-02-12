
module HPU(clk,reset,inLine,outLine,sel);

	import interact::*;

	input   clk,reset;
	input channel_forward inLine;
	output channel_forward outLine;
	output reg [3:0] sel;


	reg VLD, SOP, MOP,EOP;
	wire [1:0] dest;

	reg [3:0] selInt, selIntNext,decodedSel;
	reg [LINK_WIDTH-1 : 0] outInt;



	assign VLD = inLine.data[LINK_WIDTH-1];
	assign SOP = inLine.data[LINK_WIDTH-2];
	assign EOP = inLine.data[LINK_WIDTH-3];
	assign dest = inLine.data[1:0];
	
	assign outLine.data = outInt;

	always @ ( dest)
	begin

		if ( dest == 2'b00 )
			decodedSel[0] <= 1'b1;
		else
			decodedSel[0] <= 1'b0;
	
		if ( dest == 2'b01 )
			decodedSel[1] <= 1'b1;
		else
			decodedSel[1] <= 1'b0;

		if ( dest == 2'b10 )
			decodedSel[2] <= 1'b1;
		else
			decodedSel[2] <= 1'b0;
		
		if ( dest == 2'b11 )
			decodedSel[3] <= 1'b1;
		else
			decodedSel[3] <= 1'b0;

	end		
	always @ ( SOP or decodedSel or selInt or VLD or EOP )
	begin
		if (SOP)
			selIntNext <= decodedSel;
		else
         selIntNext <= (selInt & {4{VLD | EOP}});
   end
	
	always @ ( SOP or selIntNext or selInt or VLD or EOP )
	begin
	if ( ( ( EOP == 1'b1 ) | ( VLD  == 1'b1 ) ) & ( SOP == 1'b0 ) )
			sel <= selInt ;
		else 
			sel <= selIntNext;
	 end
	
	always @ ( SOP)
	begin
		if (SOP) 
			outInt <= {  inLine.data[34:16],2'b00,inLine.data[15:2] }; // 2bit shift occurs
		else 
			outInt <= inLine.data;
	 end
// reset to be added or not? if added some error occurs and if addede with trigger assgn of value to reset gives error
	always @ ( posedge clk)
	begin
		if ( reset == 1'b1 )
			selInt <= 0;
		else  
 			begin
			selInt <= selIntNext; 
			end
	end 


endmodule

