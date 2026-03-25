`timescale 1ns / 1ps

module iir_filter
#(
    parameter NB_IN = 10,
	parameter NB_OUT = 25,
	parameter NB_W = 10,
	parameter NUMBER_WB = 2, //b0, b1, ...
	parameter NUMBER_WA = 2 //a0, a1, ...

)
(
    input clk,
    input rst,
    input signed [NB_IN-1:0] x,
    output reg signed [NB_OUT-1:0] y
);

//coefficients
reg signed [NB_W - 1:0] coeff [0:NUMBER_WB + NUMBER_WA -1];
initial begin
    $readmemb("weights_iir.mem", coeff);
end

//shiter registers x
reg signed [NB_IN-1:0] srx [0:NUMBER_WB-2];
reg signed [NB_OUT-1:0] sry [0:NUMBER_WA-2];

reg signed [NB_OUT+NB_W:0] acc;

integer i;

always @ (posedge clk) begin
    if (rst) begin
        y <= 0;
        for (i = 0; i < NUMBER_WB-1; i = i + 1)
            srx[i] <= 0;
        for (i = 0; i < NUMBER_WA-1; i = i + 1)
            sry[i] <= 0;
    end else begin
        acc = coeff[0] * x;
        for (i = 1; i < NUMBER_WB; i = i + 1)
            acc = acc + coeff[i]*srx[i-1];
            
        for (i = NUMBER_WB + 1; i < NUMBER_WB + NUMBER_WA; i = i + 1)
            acc = acc - coeff[i] * sry[i - NUMBER_WB - 1];
        
        y <= acc;
        
        srx[0] <= x;
        for (i = 1; i < NUMBER_WB-1; i = i + 1)
            srx[i] <= srx[i-1];
        sry[0] <= acc;
        for (i = 1; i < NUMBER_WA-1; i = i + 1)
            sry[i] <= sry[i-1];
    end
end



endmodule
