module FIR_filter
#(
    parameter NB_IN = 10,
    parameter NB_OUT = 25,
    parameter NB_W = 10,
    parameter NUMBER_W = 2
)
(
    input clk,
    input rst,
    input signed [NB_IN-1:0] x,
    output reg signed [NB_OUT-1:0] y
);

reg signed [NB_W-1:0] b [0:NUMBER_W-1];
reg signed [NB_IN-1:0] delay_line [0:NUMBER_W-2];

integer i;
reg signed [NB_OUT-1:0] acc;

initial begin
    $readmemh("weights.mem", b);
end

always @(posedge clk) begin
    if (rst) begin
        y <= 0;
        for (i = 0; i < NUMBER_W-1; i = i + 1)
            delay_line[i] <= 0;
    end else begin
        delay_line[0] <= x;
        for (i = 1; i < NUMBER_W-1; i = i + 1)
            delay_line[i] <= delay_line[i-1];

        acc = b[0] * x;
        for (i = 1; i < NUMBER_W; i = i + 1)
            acc = acc + b[i] * delay_line[i-1];

        y <= acc;
    end
end

endmodule