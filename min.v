module min #(parameter INT = 8, parameter FRAC = 8)(
input [INT+FRAC-1:0] msg_1,
input [INT+FRAC-1:0] msg_2,
input [INT+FRAC-1:0] msg_3,
input [INT+FRAC-1:0] msg_4,
input [INT+FRAC-1:0] msg_5,
output [INT+FRAC-1:0] msg
);

wire [INT+FRAC-1:0] abs_msg_1;
wire [INT+FRAC-1:0] abs_msg_2;
wire [INT+FRAC-1:0] abs_msg_3;
wire [INT+FRAC-1:0] abs_msg_4;
wire [INT+FRAC-1:0] abs_msg_5;
wire [INT+FRAC-1:0] abs_msg;

assign abs_msg_1 = (msg_1[INT+FRAC-1])? -msg_1:msg_1;
assign abs_msg_2 = (msg_2[INT+FRAC-1])? -msg_2:msg_2;
assign abs_msg_3 = (msg_3[INT+FRAC-1])? -msg_3:msg_3;
assign abs_msg_4 = (msg_4[INT+FRAC-1])? -msg_4:msg_4;
assign abs_msg_5 = (msg_5[INT+FRAC-1])? -msg_5:msg_5;

wire [INT+FRAC-1:0] r11;
wire [INT+FRAC-1:0] r12;
wire [INT+FRAC-1:0] r21;

assign r11 = (abs_msg_1<abs_msg_2)? abs_msg_1:abs_msg_2;
assign r12 = (abs_msg_3<abs_msg_4)? abs_msg_3:abs_msg_4;

assign r21 = (r11<r12)? r11:r12;

assign abs_msg = (r21<abs_msg_5)? r21:abs_msg_5;

assign msg = (msg_1[INT+FRAC-1]^msg_2[INT+FRAC-1]^msg_3[INT+FRAC-1]^msg_4[INT+FRAC-1]^msg_5[INT+FRAC-1])? -abs_msg:abs_msg;

endmodule
