 module FIR_filter
 #(
	parameter b0 = 2,
	parameter b1 = 3,
	
	parameter NB_IN = 10,
	parameter NB_OUT = 25
 )
 (
	input clk,
	input      signed [NB_IN - 1:0] x, 
	output reg signed [NB_OUT- 1:0] y
 );
 
always @ (posedge clk)
begin
	y <= x;
	

end
 
endmodule 