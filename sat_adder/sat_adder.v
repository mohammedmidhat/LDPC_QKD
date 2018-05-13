module sat_adder#(parameter INT = 8, parameter FRAC = 8)(
        input [INT+FRAC-1:0] a,
        input [INT+FRAC-1:0] b,
        output [INT+FRAC-1:0] c
    );

wire [INT+FRAC-1:0] sum;
assign sum = a+b;

wire [INT+FRAC-1:0] pos_sum;
assign pos_sum = (sum[INT+FRAC-1])? 16'b0111111111111111:sum;

wire [INT+FRAC-1:0] neg_sum;
assign neg_sum = (sum[INT+FRAC-1])? sum:16'b1000000000000000;

wire [INT+FRAC-1:0] result;
assign result = (a[INT+FRAC-1])? neg_sum:pos_sum;

assign c = (a[INT+FRAC-1]^b[INT+FRAC-1]) ? sum:result;

endmodule
