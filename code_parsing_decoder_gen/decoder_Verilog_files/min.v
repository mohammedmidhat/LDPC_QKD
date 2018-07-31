module min #(parameter INT = 8, parameter FRAC = 8)(
input [INT+FRAC-1:0] msg_1,
input [INT+FRAC-1:0] msg_2,
input [INT+FRAC-1:0] msg_3,
input [INT+FRAC-1:0] msg_4,
input [INT+FRAC-1:0] msg_5,
input [INT+FRAC-1:0] msg_6,
input [INT+FRAC-1:0] msg_7,
input [INT+FRAC-1:0] msg_8,
input [INT+FRAC-1:0] msg_9,
output [INT+FRAC-1:0] msg
);

wire [INT+FRAC-1:0] abs_msg_1;
wire [INT+FRAC-1:0] abs_msg_2;
wire [INT+FRAC-1:0] abs_msg_3;
wire [INT+FRAC-1:0] abs_msg_4;
wire [INT+FRAC-1:0] abs_msg_5;
wire [INT+FRAC-1:0] abs_msg_6;
wire [INT+FRAC-1:0] abs_msg_7;
wire [INT+FRAC-1:0] abs_msg_8;
wire [INT+FRAC-1:0] abs_msg_9;
wire [INT+FRAC-1:0] abs_msg;

assign abs_msg_1 = (msg_1[INT+FRAC-1])? -msg_1:msg_1;
assign abs_msg_2 = (msg_2[INT+FRAC-1])? -msg_2:msg_2;
assign abs_msg_3 = (msg_3[INT+FRAC-1])? -msg_3:msg_3;
assign abs_msg_4 = (msg_4[INT+FRAC-1])? -msg_4:msg_4;
assign abs_msg_5 = (msg_5[INT+FRAC-1])? -msg_5:msg_5;
assign abs_msg_6 = (msg_6[INT+FRAC-1])? -msg_6:msg_6;
assign abs_msg_7 = (msg_7[INT+FRAC-1])? -msg_7:msg_7;
assign abs_msg_8 = (msg_8[INT+FRAC-1])? -msg_8:msg_8;
assign abs_msg_9 = (msg_9[INT+FRAC-1])? -msg_9:msg_9;

wire [INT+FRAC-1:0] r1
wire [INT+FRAC-1:0] r2
wire [INT+FRAC-1:0] r3
wire [INT+FRAC-1:0] r4
wire [INT+FRAC-1:0] r5
wire [INT+FRAC-1:0] r6
wire [INT+FRAC-1:0] r7

assign abs_msg = (r1<r2)? r1:r2;
assign r1 = (r3<r4)? r3:r4;
assign r2 = (r5<r6)? r5:r6;
assign r3 = (r7<abs_msg_1)? r7:abs_msg_1;
assign r4 = (abs_msg_2<abs_msg_3)? abs_msg_2:abs_msg_3;
assign r5 = (abs_msg_4<abs_msg_5)? abs_msg_4:abs_msg_5;
assign r6 = (abs_msg_6<abs_msg_7)? abs_msg_6:abs_msg_7;
assign r7 = (abs_msg_8<abs_msg_9)? abs_msg_8:abs_msg_9;

assign msg = (msg_1[INT+FRAC-1]^msg_2[INT+FRAC-1]^msg_3[INT+FRAC-1]^msg_4[INT+FRAC-1]^msg_5[INT+FRAC-1]^msg_6[INT+FRAC-1]^msg_7[INT+FRAC-1]^msg_8[INT+FRAC-1]^msg_9[INT+FRAC-1])? -abs_msg:abs_msg;

endmodule