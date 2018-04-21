module vn #(parameter WIDTH = 20)(
input [WIDTH-1:0] msg_in_1,
input [WIDTH-1:0] msg_in_2,
input [WIDTH-1:0] msg_in_3,
output [WIDTH-1:0] msg_out_1,
output [WIDTH-1:0] msg_out_2,
output [WIDTH-1:0] msg_out_3,
input [WIDTH-1:0] belief
);

assign msg_out_1 = belief - msg_in_1;
assign msg_out_2 = belief - msg_in_2;
assign msg_out_3 = belief - msg_in_3;

endmodule
