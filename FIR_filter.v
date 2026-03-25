 module FIR_filter
 #(
	parameter NB_IN = 10,
	parameter NB_OUT = 25,
	parameter NB_W = 10
 )
 (
	input clk,
	input rst,
	input  signed [NB_IN - 1:0] x, 
	output reg signed [NB_OUT- 1:0] y
 );
 
// READ WEIGHTS
reg [NB_W - 1:0] b [0:1];
initial begin
    $readmemb("weights.mem", b); // read in binary
end

reg signed [NB_IN - 1:0] rx;
 
always @ (posedge clk) begin
	if(rst) begin
		rx <= 0;
		y <= 0;
	end else begin
		rx <= x;
		y <= b[0]*x + b[1]*rx;
	end
end
endmodule 