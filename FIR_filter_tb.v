module FIR_filter_tb();

reg clk;
reg rst;
reg signed [9:0] x;
wire signed [24:0] y;

initial begin
	clk = 0;
	rst = 1;
	x = 0;
	
	#12 rst = 0;
	
	#3 x = 1;
	#10 x = 0;
	
	#50 $finish;
end

always #5 clk = ~clk;

FIR_filter fir(clk, rst, x, y);

endmodule