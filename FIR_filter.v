 module FIR_filter
 #(
	parameter NB_IN = 10,
	parameter NB_OUT = 25,
	parameter NB_W = 10,
	parameter NUMBER_W = 5
 )
 (
	input clk,
	input rst,
	input  signed [NB_IN - 1:0] x, 
	output reg signed [NB_OUT- 1:0] y
 );
 
// READ WEIGHTS
reg signed [NB_W - 1:0] b [0:NUMBER_W-1];
initial begin
    $readmemb("weights.mem", b); // read in binary
end

// shifter registers 
reg signed [NB_IN - 1:0] sr [NUMBER_W - 2:0];

integer i;
// accumulator
reg signed [NB_OUT-1:0] acc;

always @ (posedge clk) begin
	if(rst) begin
		sr[0] <= 0;
		y <= 0;
	end else begin
		sr[0] <= x;
		y <= b[0]*x + b[1]*sr[0];
	end
end

always @ (posedge clk) begin
    if  (rst) begin
        y <= 0;
        for (i = 0; i < NUMBER_W-1; i = i + 1)
            sr[i] <= 0;
    end else begin
        sr[0] <= x;
        for (i = 1; i < NUMBER_W-1; i = i + 1)
            sr[i] <= sr[i-1];
        
        acc = b[0] * x;
        for (i = 1; i < NUMBER_W; i = i + 1)
            acc = acc + b[i]*sr[i-1];   
        y <= acc;
    end 
end

endmodule 