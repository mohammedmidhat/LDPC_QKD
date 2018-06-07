//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Author:          Mohammed Al Ai Baky
// 
// Create Date:     6/6/2018 
// Design Name:     LDPC_decoder_Frolov_1024_0.5
// Module Name:     decoder
// Project Name:    LDPC_decoder_Frolov_1024_0.5
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   Vivado 2017.4
// Description:     The LDPC decoder
//
// Dependencies:    syn.v
//                  cn.v
//                  vr.v
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder#(parameter max_iter = 30, parameter log2max_iter = 5, parameter INT = 8, parameter FRAC = 8, parameter deg_v = 7, parameter deg_c = 10,
				parameter circ = 128, parameter log2circ = 8, parameter n = 2048)(
	input clk,
	input rst,
    input [n-1:0] data,
	output success,
	output [log2max_iter-1:0] iterations
	);

reg [log2circ-1:0] circ_iter;
reg [log2circ-1:0] circ_iter_;
reg chk_r = 0;
reg chk_w = 0;

wire [INT+FRAC-1:0] LLR = 16'b0000000000001011;
reg [n-1:0] dec_cw;
reg [4:0] FSM;
reg non_zero_syn;

reg [2:0] nop = 0;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;


wire [log2circ-1:0] circ_addr;
assign circ_addr = (chk_r)? circ+circ_iter: circ_iter;

wire [log2circ-2:0] circ_1_data;
circ_1 circ_1_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_1_data)
);

wire [log2circ-2:0] circ_2_data;
circ_2 circ_2_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_2_data)
);

wire [log2circ-2:0] circ_3_data;
circ_3 circ_3_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_3_data)
);

wire [log2circ-2:0] circ_4_data;
circ_4 circ_4_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_4_data)
);

wire [log2circ-2:0] circ_5_data;
circ_5 circ_5_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_5_data)
);

wire [log2circ-2:0] circ_6_data;
circ_6 circ_6_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_6_data)
);

wire [log2circ-2:0] circ_7_data;
circ_7 circ_7_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_7_data)
);

wire [log2circ-2:0] circ_8_data;
circ_8 circ_8_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_8_data)
);

wire [log2circ-2:0] circ_9_data;
circ_9 circ_9_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_9_data)
);

wire [log2circ-2:0] circ_10_data;
circ_10 circ_10_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_10_data)
);

wire [log2circ-2:0] circ_11_data;
circ_11 circ_11_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_11_data)
);

wire [log2circ-2:0] circ_12_data;
circ_12 circ_12_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_12_data)
);

wire [log2circ-2:0] circ_13_data;
circ_13 circ_13_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_13_data)
);

wire [log2circ-2:0] circ_14_data;
circ_14 circ_14_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_14_data)
);

wire [log2circ-2:0] circ_15_data;
circ_15 circ_15_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_15_data)
);

wire [log2circ-2:0] circ_16_data;
circ_16 circ_16_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_16_data)
);

wire [log2circ-2:0] circ_17_data;
circ_17 circ_17_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_17_data)
);

wire [log2circ-2:0] circ_18_data;
circ_18 circ_18_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_18_data)
);

wire [log2circ-2:0] circ_19_data;
circ_19 circ_19_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_19_data)
);

wire [log2circ-2:0] circ_20_data;
circ_20 circ_20_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_20_data)
);

wire [log2circ-2:0] circ_21_data;
circ_21 circ_21_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_21_data)
);

wire [log2circ-2:0] circ_22_data;
circ_22 circ_22_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_22_data)
);

wire [log2circ-2:0] circ_23_data;
circ_23 circ_23_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_23_data)
);

wire [log2circ-2:0] circ_24_data;
circ_24 circ_24_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_24_data)
);

wire [log2circ-2:0] circ_25_data;
circ_25 circ_25_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_25_data)
);

wire [log2circ-2:0] circ_26_data;
circ_26 circ_26_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_26_data)
);

wire [log2circ-2:0] circ_27_data;
circ_27 circ_27_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_27_data)
);

wire [log2circ-2:0] circ_28_data;
circ_28 circ_28_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_28_data)
);

wire [log2circ-2:0] circ_29_data;
circ_29 circ_29_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_29_data)
);

wire [log2circ-2:0] circ_30_data;
circ_30 circ_30_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_30_data)
);

wire [log2circ-2:0] circ_31_data;
circ_31 circ_31_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_31_data)
);

wire [log2circ-2:0] circ_32_data;
circ_32 circ_32_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_32_data)
);

wire [log2circ-2:0] circ_33_data;
circ_33 circ_33_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_33_data)
);

wire [log2circ-2:0] circ_34_data;
circ_34 circ_34_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_34_data)
);

wire [log2circ-2:0] circ_35_data;
circ_35 circ_35_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_35_data)
);

wire [log2circ-2:0] circ_36_data;
circ_36 circ_36_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_36_data)
);

wire [log2circ-2:0] circ_37_data;
circ_37 circ_37_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_37_data)
);

wire [log2circ-2:0] circ_38_data;
circ_38 circ_38_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_38_data)
);

wire [log2circ-2:0] circ_39_data;
circ_39 circ_39_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_39_data)
);

wire [log2circ-2:0] circ_40_data;
circ_40 circ_40_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_40_data)
);

wire [log2circ-2:0] circ_41_data;
circ_41 circ_41_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_41_data)
);

wire [log2circ-2:0] circ_42_data;
circ_42 circ_42_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_42_data)
);

wire [log2circ-2:0] circ_43_data;
circ_43 circ_43_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_43_data)
);

wire [log2circ-2:0] circ_44_data;
circ_44 circ_44_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_44_data)
);

wire [log2circ-2:0] circ_45_data;
circ_45 circ_45_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_45_data)
);

wire [log2circ-2:0] circ_46_data;
circ_46 circ_46_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_46_data)
);

wire [log2circ-2:0] circ_47_data;
circ_47 circ_47_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_47_data)
);

wire [log2circ-2:0] circ_48_data;
circ_48 circ_48_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_48_data)
);

wire [log2circ-2:0] circ_49_data;
circ_49 circ_49_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_49_data)
);

wire [log2circ-2:0] circ_50_data;
circ_50 circ_50_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_50_data)
);

wire [log2circ-2:0] circ_51_data;
circ_51 circ_51_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_51_data)
);

wire [log2circ-2:0] circ_52_data;
circ_52 circ_52_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_52_data)
);

wire [log2circ-2:0] circ_53_data;
circ_53 circ_53_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_53_data)
);

wire [log2circ-2:0] circ_54_data;
circ_54 circ_54_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_54_data)
);

wire [log2circ-2:0] circ_55_data;
circ_55 circ_55_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_55_data)
);

wire [log2circ-2:0] circ_56_data;
circ_56 circ_56_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_56_data)
);

wire [log2circ-2:0] circ_57_data;
circ_57 circ_57_inst(
.clka(clk),
.addra(circ_addr),
.douta(circ_57_data)
);


wire [log2circ-1:0] circ_msg_addr_w;
assign circ_msg_addr_w = (chk_w)? circ+circ_iter_: circ_iter_;

wire [log2circ-1:0] circ_1_msg_addr_r;
assign circ_1_msg_addr_r = (chk_r)? circ+circ_1_data: circ_1_data;
wire [INT+FRAC-1:0] circ_1_msg_data_in;
wire [INT+FRAC-1:0] circ_1_msg_data_out;
circ_1_msg circ_1_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_1_msg_data_in),
.clkb(clk),
.addrb(circ_1_msg_addr_r),
.doutb(circ_1_msg_data_out)
);

wire [log2circ-1:0] circ_2_msg_addr_r;
assign circ_2_msg_addr_r = (chk_r)? circ+circ_2_data: circ_2_data;
wire [INT+FRAC-1:0] circ_2_msg_data_in;
wire [INT+FRAC-1:0] circ_2_msg_data_out;
circ_2_msg circ_2_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_2_msg_data_in),
.clkb(clk),
.addrb(circ_2_msg_addr_r),
.doutb(circ_2_msg_data_out)
);

wire [log2circ-1:0] circ_3_msg_addr_r;
assign circ_3_msg_addr_r = (chk_r)? circ+circ_3_data: circ_3_data;
wire [INT+FRAC-1:0] circ_3_msg_data_in;
wire [INT+FRAC-1:0] circ_3_msg_data_out;
circ_3_msg circ_3_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_3_msg_data_in),
.clkb(clk),
.addrb(circ_3_msg_addr_r),
.doutb(circ_3_msg_data_out)
);

wire [log2circ-1:0] circ_4_msg_addr_r;
assign circ_4_msg_addr_r = (chk_r)? circ+circ_4_data: circ_4_data;
wire [INT+FRAC-1:0] circ_4_msg_data_in;
wire [INT+FRAC-1:0] circ_4_msg_data_out;
circ_4_msg circ_4_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_4_msg_data_in),
.clkb(clk),
.addrb(circ_4_msg_addr_r),
.doutb(circ_4_msg_data_out)
);

wire [log2circ-1:0] circ_5_msg_addr_r;
assign circ_5_msg_addr_r = (chk_r)? circ+circ_5_data: circ_5_data;
wire [INT+FRAC-1:0] circ_5_msg_data_in;
wire [INT+FRAC-1:0] circ_5_msg_data_out;
circ_5_msg circ_5_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_5_msg_data_in),
.clkb(clk),
.addrb(circ_5_msg_addr_r),
.doutb(circ_5_msg_data_out)
);

wire [log2circ-1:0] circ_6_msg_addr_r;
assign circ_6_msg_addr_r = (chk_r)? circ+circ_6_data: circ_6_data;
wire [INT+FRAC-1:0] circ_6_msg_data_in;
wire [INT+FRAC-1:0] circ_6_msg_data_out;
circ_6_msg circ_6_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_6_msg_data_in),
.clkb(clk),
.addrb(circ_6_msg_addr_r),
.doutb(circ_6_msg_data_out)
);

wire [log2circ-1:0] circ_7_msg_addr_r;
assign circ_7_msg_addr_r = (chk_r)? circ+circ_7_data: circ_7_data;
wire [INT+FRAC-1:0] circ_7_msg_data_in;
wire [INT+FRAC-1:0] circ_7_msg_data_out;
circ_7_msg circ_7_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_7_msg_data_in),
.clkb(clk),
.addrb(circ_7_msg_addr_r),
.doutb(circ_7_msg_data_out)
);

wire [log2circ-1:0] circ_8_msg_addr_r;
assign circ_8_msg_addr_r = (chk_r)? circ+circ_8_data: circ_8_data;
wire [INT+FRAC-1:0] circ_8_msg_data_in;
wire [INT+FRAC-1:0] circ_8_msg_data_out;
circ_8_msg circ_8_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_8_msg_data_in),
.clkb(clk),
.addrb(circ_8_msg_addr_r),
.doutb(circ_8_msg_data_out)
);

wire [log2circ-1:0] circ_9_msg_addr_r;
assign circ_9_msg_addr_r = (chk_r)? circ+circ_9_data: circ_9_data;
wire [INT+FRAC-1:0] circ_9_msg_data_in;
wire [INT+FRAC-1:0] circ_9_msg_data_out;
circ_9_msg circ_9_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_9_msg_data_in),
.clkb(clk),
.addrb(circ_9_msg_addr_r),
.doutb(circ_9_msg_data_out)
);

wire [log2circ-1:0] circ_10_msg_addr_r;
assign circ_10_msg_addr_r = (chk_r)? circ+circ_10_data: circ_10_data;
wire [INT+FRAC-1:0] circ_10_msg_data_in;
wire [INT+FRAC-1:0] circ_10_msg_data_out;
circ_10_msg circ_10_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_10_msg_data_in),
.clkb(clk),
.addrb(circ_10_msg_addr_r),
.doutb(circ_10_msg_data_out)
);

wire [log2circ-1:0] circ_11_msg_addr_r;
assign circ_11_msg_addr_r = (chk_r)? circ+circ_11_data: circ_11_data;
wire [INT+FRAC-1:0] circ_11_msg_data_in;
wire [INT+FRAC-1:0] circ_11_msg_data_out;
circ_11_msg circ_11_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_11_msg_data_in),
.clkb(clk),
.addrb(circ_11_msg_addr_r),
.doutb(circ_11_msg_data_out)
);

wire [log2circ-1:0] circ_12_msg_addr_r;
assign circ_12_msg_addr_r = (chk_r)? circ+circ_12_data: circ_12_data;
wire [INT+FRAC-1:0] circ_12_msg_data_in;
wire [INT+FRAC-1:0] circ_12_msg_data_out;
circ_12_msg circ_12_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_12_msg_data_in),
.clkb(clk),
.addrb(circ_12_msg_addr_r),
.doutb(circ_12_msg_data_out)
);

wire [log2circ-1:0] circ_13_msg_addr_r;
assign circ_13_msg_addr_r = (chk_r)? circ+circ_13_data: circ_13_data;
wire [INT+FRAC-1:0] circ_13_msg_data_in;
wire [INT+FRAC-1:0] circ_13_msg_data_out;
circ_13_msg circ_13_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_13_msg_data_in),
.clkb(clk),
.addrb(circ_13_msg_addr_r),
.doutb(circ_13_msg_data_out)
);

wire [log2circ-1:0] circ_14_msg_addr_r;
assign circ_14_msg_addr_r = (chk_r)? circ+circ_14_data: circ_14_data;
wire [INT+FRAC-1:0] circ_14_msg_data_in;
wire [INT+FRAC-1:0] circ_14_msg_data_out;
circ_14_msg circ_14_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_14_msg_data_in),
.clkb(clk),
.addrb(circ_14_msg_addr_r),
.doutb(circ_14_msg_data_out)
);

wire [log2circ-1:0] circ_15_msg_addr_r;
assign circ_15_msg_addr_r = (chk_r)? circ+circ_15_data: circ_15_data;
wire [INT+FRAC-1:0] circ_15_msg_data_in;
wire [INT+FRAC-1:0] circ_15_msg_data_out;
circ_15_msg circ_15_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_15_msg_data_in),
.clkb(clk),
.addrb(circ_15_msg_addr_r),
.doutb(circ_15_msg_data_out)
);

wire [log2circ-1:0] circ_16_msg_addr_r;
assign circ_16_msg_addr_r = (chk_r)? circ+circ_16_data: circ_16_data;
wire [INT+FRAC-1:0] circ_16_msg_data_in;
wire [INT+FRAC-1:0] circ_16_msg_data_out;
circ_16_msg circ_16_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_16_msg_data_in),
.clkb(clk),
.addrb(circ_16_msg_addr_r),
.doutb(circ_16_msg_data_out)
);

wire [log2circ-1:0] circ_17_msg_addr_r;
assign circ_17_msg_addr_r = (chk_r)? circ+circ_17_data: circ_17_data;
wire [INT+FRAC-1:0] circ_17_msg_data_in;
wire [INT+FRAC-1:0] circ_17_msg_data_out;
circ_17_msg circ_17_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_17_msg_data_in),
.clkb(clk),
.addrb(circ_17_msg_addr_r),
.doutb(circ_17_msg_data_out)
);

wire [log2circ-1:0] circ_18_msg_addr_r;
assign circ_18_msg_addr_r = (chk_r)? circ+circ_18_data: circ_18_data;
wire [INT+FRAC-1:0] circ_18_msg_data_in;
wire [INT+FRAC-1:0] circ_18_msg_data_out;
circ_18_msg circ_18_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_18_msg_data_in),
.clkb(clk),
.addrb(circ_18_msg_addr_r),
.doutb(circ_18_msg_data_out)
);

wire [log2circ-1:0] circ_19_msg_addr_r;
assign circ_19_msg_addr_r = (chk_r)? circ+circ_19_data: circ_19_data;
wire [INT+FRAC-1:0] circ_19_msg_data_in;
wire [INT+FRAC-1:0] circ_19_msg_data_out;
circ_19_msg circ_19_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_19_msg_data_in),
.clkb(clk),
.addrb(circ_19_msg_addr_r),
.doutb(circ_19_msg_data_out)
);

wire [log2circ-1:0] circ_20_msg_addr_r;
assign circ_20_msg_addr_r = (chk_r)? circ+circ_20_data: circ_20_data;
wire [INT+FRAC-1:0] circ_20_msg_data_in;
wire [INT+FRAC-1:0] circ_20_msg_data_out;
circ_20_msg circ_20_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_20_msg_data_in),
.clkb(clk),
.addrb(circ_20_msg_addr_r),
.doutb(circ_20_msg_data_out)
);

wire [log2circ-1:0] circ_21_msg_addr_r;
assign circ_21_msg_addr_r = (chk_r)? circ+circ_21_data: circ_21_data;
wire [INT+FRAC-1:0] circ_21_msg_data_in;
wire [INT+FRAC-1:0] circ_21_msg_data_out;
circ_21_msg circ_21_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_21_msg_data_in),
.clkb(clk),
.addrb(circ_21_msg_addr_r),
.doutb(circ_21_msg_data_out)
);

wire [log2circ-1:0] circ_22_msg_addr_r;
assign circ_22_msg_addr_r = (chk_r)? circ+circ_22_data: circ_22_data;
wire [INT+FRAC-1:0] circ_22_msg_data_in;
wire [INT+FRAC-1:0] circ_22_msg_data_out;
circ_22_msg circ_22_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_22_msg_data_in),
.clkb(clk),
.addrb(circ_22_msg_addr_r),
.doutb(circ_22_msg_data_out)
);

wire [log2circ-1:0] circ_23_msg_addr_r;
assign circ_23_msg_addr_r = (chk_r)? circ+circ_23_data: circ_23_data;
wire [INT+FRAC-1:0] circ_23_msg_data_in;
wire [INT+FRAC-1:0] circ_23_msg_data_out;
circ_23_msg circ_23_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_23_msg_data_in),
.clkb(clk),
.addrb(circ_23_msg_addr_r),
.doutb(circ_23_msg_data_out)
);

wire [log2circ-1:0] circ_24_msg_addr_r;
assign circ_24_msg_addr_r = (chk_r)? circ+circ_24_data: circ_24_data;
wire [INT+FRAC-1:0] circ_24_msg_data_in;
wire [INT+FRAC-1:0] circ_24_msg_data_out;
circ_24_msg circ_24_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_24_msg_data_in),
.clkb(clk),
.addrb(circ_24_msg_addr_r),
.doutb(circ_24_msg_data_out)
);

wire [log2circ-1:0] circ_25_msg_addr_r;
assign circ_25_msg_addr_r = (chk_r)? circ+circ_25_data: circ_25_data;
wire [INT+FRAC-1:0] circ_25_msg_data_in;
wire [INT+FRAC-1:0] circ_25_msg_data_out;
circ_25_msg circ_25_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_25_msg_data_in),
.clkb(clk),
.addrb(circ_25_msg_addr_r),
.doutb(circ_25_msg_data_out)
);

wire [log2circ-1:0] circ_26_msg_addr_r;
assign circ_26_msg_addr_r = (chk_r)? circ+circ_26_data: circ_26_data;
wire [INT+FRAC-1:0] circ_26_msg_data_in;
wire [INT+FRAC-1:0] circ_26_msg_data_out;
circ_26_msg circ_26_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_26_msg_data_in),
.clkb(clk),
.addrb(circ_26_msg_addr_r),
.doutb(circ_26_msg_data_out)
);

wire [log2circ-1:0] circ_27_msg_addr_r;
assign circ_27_msg_addr_r = (chk_r)? circ+circ_27_data: circ_27_data;
wire [INT+FRAC-1:0] circ_27_msg_data_in;
wire [INT+FRAC-1:0] circ_27_msg_data_out;
circ_27_msg circ_27_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_27_msg_data_in),
.clkb(clk),
.addrb(circ_27_msg_addr_r),
.doutb(circ_27_msg_data_out)
);

wire [log2circ-1:0] circ_28_msg_addr_r;
assign circ_28_msg_addr_r = (chk_r)? circ+circ_28_data: circ_28_data;
wire [INT+FRAC-1:0] circ_28_msg_data_in;
wire [INT+FRAC-1:0] circ_28_msg_data_out;
circ_28_msg circ_28_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_28_msg_data_in),
.clkb(clk),
.addrb(circ_28_msg_addr_r),
.doutb(circ_28_msg_data_out)
);

wire [log2circ-1:0] circ_29_msg_addr_r;
assign circ_29_msg_addr_r = (chk_r)? circ+circ_29_data: circ_29_data;
wire [INT+FRAC-1:0] circ_29_msg_data_in;
wire [INT+FRAC-1:0] circ_29_msg_data_out;
circ_29_msg circ_29_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_29_msg_data_in),
.clkb(clk),
.addrb(circ_29_msg_addr_r),
.doutb(circ_29_msg_data_out)
);

wire [log2circ-1:0] circ_30_msg_addr_r;
assign circ_30_msg_addr_r = (chk_r)? circ+circ_30_data: circ_30_data;
wire [INT+FRAC-1:0] circ_30_msg_data_in;
wire [INT+FRAC-1:0] circ_30_msg_data_out;
circ_30_msg circ_30_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_30_msg_data_in),
.clkb(clk),
.addrb(circ_30_msg_addr_r),
.doutb(circ_30_msg_data_out)
);

wire [log2circ-1:0] circ_31_msg_addr_r;
assign circ_31_msg_addr_r = (chk_r)? circ+circ_31_data: circ_31_data;
wire [INT+FRAC-1:0] circ_31_msg_data_in;
wire [INT+FRAC-1:0] circ_31_msg_data_out;
circ_31_msg circ_31_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_31_msg_data_in),
.clkb(clk),
.addrb(circ_31_msg_addr_r),
.doutb(circ_31_msg_data_out)
);

wire [log2circ-1:0] circ_32_msg_addr_r;
assign circ_32_msg_addr_r = (chk_r)? circ+circ_32_data: circ_32_data;
wire [INT+FRAC-1:0] circ_32_msg_data_in;
wire [INT+FRAC-1:0] circ_32_msg_data_out;
circ_32_msg circ_32_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_32_msg_data_in),
.clkb(clk),
.addrb(circ_32_msg_addr_r),
.doutb(circ_32_msg_data_out)
);

wire [log2circ-1:0] circ_33_msg_addr_r;
assign circ_33_msg_addr_r = (chk_r)? circ+circ_33_data: circ_33_data;
wire [INT+FRAC-1:0] circ_33_msg_data_in;
wire [INT+FRAC-1:0] circ_33_msg_data_out;
circ_33_msg circ_33_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_33_msg_data_in),
.clkb(clk),
.addrb(circ_33_msg_addr_r),
.doutb(circ_33_msg_data_out)
);

wire [log2circ-1:0] circ_34_msg_addr_r;
assign circ_34_msg_addr_r = (chk_r)? circ+circ_34_data: circ_34_data;
wire [INT+FRAC-1:0] circ_34_msg_data_in;
wire [INT+FRAC-1:0] circ_34_msg_data_out;
circ_34_msg circ_34_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_34_msg_data_in),
.clkb(clk),
.addrb(circ_34_msg_addr_r),
.doutb(circ_34_msg_data_out)
);

wire [log2circ-1:0] circ_35_msg_addr_r;
assign circ_35_msg_addr_r = (chk_r)? circ+circ_35_data: circ_35_data;
wire [INT+FRAC-1:0] circ_35_msg_data_in;
wire [INT+FRAC-1:0] circ_35_msg_data_out;
circ_35_msg circ_35_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_35_msg_data_in),
.clkb(clk),
.addrb(circ_35_msg_addr_r),
.doutb(circ_35_msg_data_out)
);

wire [log2circ-1:0] circ_36_msg_addr_r;
assign circ_36_msg_addr_r = (chk_r)? circ+circ_36_data: circ_36_data;
wire [INT+FRAC-1:0] circ_36_msg_data_in;
wire [INT+FRAC-1:0] circ_36_msg_data_out;
circ_36_msg circ_36_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_36_msg_data_in),
.clkb(clk),
.addrb(circ_36_msg_addr_r),
.doutb(circ_36_msg_data_out)
);

wire [log2circ-1:0] circ_37_msg_addr_r;
assign circ_37_msg_addr_r = (chk_r)? circ+circ_37_data: circ_37_data;
wire [INT+FRAC-1:0] circ_37_msg_data_in;
wire [INT+FRAC-1:0] circ_37_msg_data_out;
circ_37_msg circ_37_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_37_msg_data_in),
.clkb(clk),
.addrb(circ_37_msg_addr_r),
.doutb(circ_37_msg_data_out)
);

wire [log2circ-1:0] circ_38_msg_addr_r;
assign circ_38_msg_addr_r = (chk_r)? circ+circ_38_data: circ_38_data;
wire [INT+FRAC-1:0] circ_38_msg_data_in;
wire [INT+FRAC-1:0] circ_38_msg_data_out;
circ_38_msg circ_38_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_38_msg_data_in),
.clkb(clk),
.addrb(circ_38_msg_addr_r),
.doutb(circ_38_msg_data_out)
);

wire [log2circ-1:0] circ_39_msg_addr_r;
assign circ_39_msg_addr_r = (chk_r)? circ+circ_39_data: circ_39_data;
wire [INT+FRAC-1:0] circ_39_msg_data_in;
wire [INT+FRAC-1:0] circ_39_msg_data_out;
circ_39_msg circ_39_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_39_msg_data_in),
.clkb(clk),
.addrb(circ_39_msg_addr_r),
.doutb(circ_39_msg_data_out)
);

wire [log2circ-1:0] circ_40_msg_addr_r;
assign circ_40_msg_addr_r = (chk_r)? circ+circ_40_data: circ_40_data;
wire [INT+FRAC-1:0] circ_40_msg_data_in;
wire [INT+FRAC-1:0] circ_40_msg_data_out;
circ_40_msg circ_40_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_40_msg_data_in),
.clkb(clk),
.addrb(circ_40_msg_addr_r),
.doutb(circ_40_msg_data_out)
);

wire [log2circ-1:0] circ_41_msg_addr_r;
assign circ_41_msg_addr_r = (chk_r)? circ+circ_41_data: circ_41_data;
wire [INT+FRAC-1:0] circ_41_msg_data_in;
wire [INT+FRAC-1:0] circ_41_msg_data_out;
circ_41_msg circ_41_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_41_msg_data_in),
.clkb(clk),
.addrb(circ_41_msg_addr_r),
.doutb(circ_41_msg_data_out)
);

wire [log2circ-1:0] circ_42_msg_addr_r;
assign circ_42_msg_addr_r = (chk_r)? circ+circ_42_data: circ_42_data;
wire [INT+FRAC-1:0] circ_42_msg_data_in;
wire [INT+FRAC-1:0] circ_42_msg_data_out;
circ_42_msg circ_42_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_42_msg_data_in),
.clkb(clk),
.addrb(circ_42_msg_addr_r),
.doutb(circ_42_msg_data_out)
);

wire [log2circ-1:0] circ_43_msg_addr_r;
assign circ_43_msg_addr_r = (chk_r)? circ+circ_43_data: circ_43_data;
wire [INT+FRAC-1:0] circ_43_msg_data_in;
wire [INT+FRAC-1:0] circ_43_msg_data_out;
circ_43_msg circ_43_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_43_msg_data_in),
.clkb(clk),
.addrb(circ_43_msg_addr_r),
.doutb(circ_43_msg_data_out)
);

wire [log2circ-1:0] circ_44_msg_addr_r;
assign circ_44_msg_addr_r = (chk_r)? circ+circ_44_data: circ_44_data;
wire [INT+FRAC-1:0] circ_44_msg_data_in;
wire [INT+FRAC-1:0] circ_44_msg_data_out;
circ_44_msg circ_44_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_44_msg_data_in),
.clkb(clk),
.addrb(circ_44_msg_addr_r),
.doutb(circ_44_msg_data_out)
);

wire [log2circ-1:0] circ_45_msg_addr_r;
assign circ_45_msg_addr_r = (chk_r)? circ+circ_45_data: circ_45_data;
wire [INT+FRAC-1:0] circ_45_msg_data_in;
wire [INT+FRAC-1:0] circ_45_msg_data_out;
circ_45_msg circ_45_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_45_msg_data_in),
.clkb(clk),
.addrb(circ_45_msg_addr_r),
.doutb(circ_45_msg_data_out)
);

wire [log2circ-1:0] circ_46_msg_addr_r;
assign circ_46_msg_addr_r = (chk_r)? circ+circ_46_data: circ_46_data;
wire [INT+FRAC-1:0] circ_46_msg_data_in;
wire [INT+FRAC-1:0] circ_46_msg_data_out;
circ_46_msg circ_46_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_46_msg_data_in),
.clkb(clk),
.addrb(circ_46_msg_addr_r),
.doutb(circ_46_msg_data_out)
);

wire [log2circ-1:0] circ_47_msg_addr_r;
assign circ_47_msg_addr_r = (chk_r)? circ+circ_47_data: circ_47_data;
wire [INT+FRAC-1:0] circ_47_msg_data_in;
wire [INT+FRAC-1:0] circ_47_msg_data_out;
circ_47_msg circ_47_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_47_msg_data_in),
.clkb(clk),
.addrb(circ_47_msg_addr_r),
.doutb(circ_47_msg_data_out)
);

wire [log2circ-1:0] circ_48_msg_addr_r;
assign circ_48_msg_addr_r = (chk_r)? circ+circ_48_data: circ_48_data;
wire [INT+FRAC-1:0] circ_48_msg_data_in;
wire [INT+FRAC-1:0] circ_48_msg_data_out;
circ_48_msg circ_48_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_48_msg_data_in),
.clkb(clk),
.addrb(circ_48_msg_addr_r),
.doutb(circ_48_msg_data_out)
);

wire [log2circ-1:0] circ_49_msg_addr_r;
assign circ_49_msg_addr_r = (chk_r)? circ+circ_49_data: circ_49_data;
wire [INT+FRAC-1:0] circ_49_msg_data_in;
wire [INT+FRAC-1:0] circ_49_msg_data_out;
circ_49_msg circ_49_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_49_msg_data_in),
.clkb(clk),
.addrb(circ_49_msg_addr_r),
.doutb(circ_49_msg_data_out)
);

wire [log2circ-1:0] circ_50_msg_addr_r;
assign circ_50_msg_addr_r = (chk_r)? circ+circ_50_data: circ_50_data;
wire [INT+FRAC-1:0] circ_50_msg_data_in;
wire [INT+FRAC-1:0] circ_50_msg_data_out;
circ_50_msg circ_50_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_50_msg_data_in),
.clkb(clk),
.addrb(circ_50_msg_addr_r),
.doutb(circ_50_msg_data_out)
);

wire [log2circ-1:0] circ_51_msg_addr_r;
assign circ_51_msg_addr_r = (chk_r)? circ+circ_51_data: circ_51_data;
wire [INT+FRAC-1:0] circ_51_msg_data_in;
wire [INT+FRAC-1:0] circ_51_msg_data_out;
circ_51_msg circ_51_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_51_msg_data_in),
.clkb(clk),
.addrb(circ_51_msg_addr_r),
.doutb(circ_51_msg_data_out)
);

wire [log2circ-1:0] circ_52_msg_addr_r;
assign circ_52_msg_addr_r = (chk_r)? circ+circ_52_data: circ_52_data;
wire [INT+FRAC-1:0] circ_52_msg_data_in;
wire [INT+FRAC-1:0] circ_52_msg_data_out;
circ_52_msg circ_52_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_52_msg_data_in),
.clkb(clk),
.addrb(circ_52_msg_addr_r),
.doutb(circ_52_msg_data_out)
);

wire [log2circ-1:0] circ_53_msg_addr_r;
assign circ_53_msg_addr_r = (chk_r)? circ+circ_53_data: circ_53_data;
wire [INT+FRAC-1:0] circ_53_msg_data_in;
wire [INT+FRAC-1:0] circ_53_msg_data_out;
circ_53_msg circ_53_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_53_msg_data_in),
.clkb(clk),
.addrb(circ_53_msg_addr_r),
.doutb(circ_53_msg_data_out)
);

wire [log2circ-1:0] circ_54_msg_addr_r;
assign circ_54_msg_addr_r = (chk_r)? circ+circ_54_data: circ_54_data;
wire [INT+FRAC-1:0] circ_54_msg_data_in;
wire [INT+FRAC-1:0] circ_54_msg_data_out;
circ_54_msg circ_54_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_54_msg_data_in),
.clkb(clk),
.addrb(circ_54_msg_addr_r),
.doutb(circ_54_msg_data_out)
);

wire [log2circ-1:0] circ_55_msg_addr_r;
assign circ_55_msg_addr_r = (chk_r)? circ+circ_55_data: circ_55_data;
wire [INT+FRAC-1:0] circ_55_msg_data_in;
wire [INT+FRAC-1:0] circ_55_msg_data_out;
circ_55_msg circ_55_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_55_msg_data_in),
.clkb(clk),
.addrb(circ_55_msg_addr_r),
.doutb(circ_55_msg_data_out)
);

wire [log2circ-1:0] circ_56_msg_addr_r;
assign circ_56_msg_addr_r = (chk_r)? circ+circ_56_data: circ_56_data;
wire [INT+FRAC-1:0] circ_56_msg_data_in;
wire [INT+FRAC-1:0] circ_56_msg_data_out;
circ_56_msg circ_56_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_56_msg_data_in),
.clkb(clk),
.addrb(circ_56_msg_addr_r),
.doutb(circ_56_msg_data_out)
);

wire [log2circ-1:0] circ_57_msg_addr_r;
assign circ_57_msg_addr_r = (chk_r)? circ+circ_57_data: circ_57_data;
wire [INT+FRAC-1:0] circ_57_msg_data_in;
wire [INT+FRAC-1:0] circ_57_msg_data_out;
circ_57_msg circ_57_msg_inst(
.clka(clk),
.wea(1'b1),
.addra(circ_msg_addr_w),
.dina(circ_57_msg_data_in),
.clkb(clk),
.addrb(circ_57_msg_addr_r),
.doutb(circ_57_msg_data_out)
);


wire circ_chk_1_bit_1 = dec_cw[0*circ+circ_1_data];
wire circ_chk_1_bit_2 = dec_cw[1*circ+circ_2_data];
wire circ_chk_1_bit_3 = dec_cw[2*circ+circ_3_data];
wire circ_chk_1_bit_4 = dec_cw[3*circ+circ_4_data];
wire circ_chk_1_bit_5 = dec_cw[4*circ+circ_5_data];
wire circ_chk_1_bit_6 = dec_cw[5*circ+circ_6_data];
wire circ_chk_1_bit_7 = dec_cw[6*circ+circ_7_data];
wire circ_chk_1_bit_8 = dec_cw[7*circ+circ_8_data];
wire circ_chk_1_bit_9 = dec_cw[8*circ+circ_9_data];
wire circ_chk_1_bit_10 = dec_cw[9*circ+circ_10_data];

wire circ_chk_2_bit_1 = dec_cw[0*circ+circ_11_data];
wire circ_chk_2_bit_2 = dec_cw[1*circ+circ_12_data];
wire circ_chk_2_bit_3 = dec_cw[2*circ+circ_13_data];
wire circ_chk_2_bit_4 = dec_cw[3*circ+circ_14_data];
wire circ_chk_2_bit_5 = dec_cw[4*circ+circ_15_data];
wire circ_chk_2_bit_6 = dec_cw[6*circ+circ_16_data];
wire circ_chk_2_bit_7 = dec_cw[7*circ+circ_17_data];
wire circ_chk_2_bit_8 = dec_cw[9*circ+circ_18_data];
wire circ_chk_2_bit_9 = dec_cw[10*circ+circ_19_data];

wire circ_chk_3_bit_1 = dec_cw[0*circ+circ_20_data];
wire circ_chk_3_bit_2 = dec_cw[1*circ+circ_21_data];
wire circ_chk_3_bit_3 = dec_cw[2*circ+circ_22_data];
wire circ_chk_3_bit_4 = dec_cw[3*circ+circ_23_data];
wire circ_chk_3_bit_5 = dec_cw[4*circ+circ_24_data];
wire circ_chk_3_bit_6 = dec_cw[5*circ+circ_25_data];
wire circ_chk_3_bit_7 = dec_cw[6*circ+circ_26_data];
wire circ_chk_3_bit_8 = dec_cw[7*circ+circ_27_data];
wire circ_chk_3_bit_9 = dec_cw[10*circ+circ_28_data];
wire circ_chk_3_bit_10 = dec_cw[11*circ+circ_29_data];

wire circ_chk_4_bit_1 = dec_cw[0*circ+circ_30_data];
wire circ_chk_4_bit_2 = dec_cw[1*circ+circ_31_data];
wire circ_chk_4_bit_3 = dec_cw[2*circ+circ_32_data];
wire circ_chk_4_bit_4 = dec_cw[3*circ+circ_33_data];
wire circ_chk_4_bit_5 = dec_cw[4*circ+circ_34_data];
wire circ_chk_4_bit_6 = dec_cw[5*circ+circ_35_data];
wire circ_chk_4_bit_7 = dec_cw[6*circ+circ_36_data];
wire circ_chk_4_bit_8 = dec_cw[7*circ+circ_37_data];
wire circ_chk_4_bit_9 = dec_cw[11*circ+circ_38_data];

wire circ_chk_5_bit_1 = dec_cw[0*circ+circ_39_data];
wire circ_chk_5_bit_2 = dec_cw[1*circ+circ_40_data];
wire circ_chk_5_bit_3 = dec_cw[2*circ+circ_41_data];
wire circ_chk_5_bit_4 = dec_cw[8*circ+circ_42_data];
wire circ_chk_5_bit_5 = dec_cw[12*circ+circ_43_data];

wire circ_chk_6_bit_1 = dec_cw[3*circ+circ_44_data];
wire circ_chk_6_bit_2 = dec_cw[4*circ+circ_45_data];
wire circ_chk_6_bit_3 = dec_cw[6*circ+circ_46_data];
wire circ_chk_6_bit_4 = dec_cw[8*circ+circ_47_data];
wire circ_chk_6_bit_5 = dec_cw[13*circ+circ_48_data];

wire circ_chk_7_bit_1 = dec_cw[0*circ+circ_49_data];
wire circ_chk_7_bit_2 = dec_cw[3*circ+circ_50_data];
wire circ_chk_7_bit_3 = dec_cw[7*circ+circ_51_data];
wire circ_chk_7_bit_4 = dec_cw[9*circ+circ_52_data];
wire circ_chk_7_bit_5 = dec_cw[14*circ+circ_53_data];

wire circ_chk_8_bit_1 = dec_cw[1*circ+circ_54_data];
wire circ_chk_8_bit_2 = dec_cw[3*circ+circ_55_data];
wire circ_chk_8_bit_3 = dec_cw[10*circ+circ_56_data];
wire circ_chk_8_bit_4 = dec_cw[15*circ+circ_57_data];


wire syn_res_circ_1;

syn syn_1_inst (
.bit_1(circ_chk_1_bit_1),
.bit_2(circ_chk_1_bit_2),
.bit_3(circ_chk_1_bit_3),
.bit_4(circ_chk_1_bit_4),
.bit_5(circ_chk_1_bit_5),
.bit_6(circ_chk_1_bit_6),
.bit_7(circ_chk_1_bit_7),
.bit_8(circ_chk_1_bit_8),
.bit_9(circ_chk_1_bit_9),
.bit_10(circ_chk_1_bit_10),
.result(syn_res_circ_1)
);

wire syn_res_circ_2;

syn syn_2_inst (
.bit_1(circ_chk_2_bit_1),
.bit_2(circ_chk_2_bit_2),
.bit_3(circ_chk_2_bit_3),
.bit_4(circ_chk_2_bit_4),
.bit_5(circ_chk_2_bit_5),
.bit_6(circ_chk_2_bit_6),
.bit_7(circ_chk_2_bit_7),
.bit_8(circ_chk_2_bit_8),
.bit_9(circ_chk_2_bit_9),
.bit_10(0),
.result(syn_res_circ_2)
);

wire syn_res_circ_3;

syn syn_3_inst (
.bit_1(circ_chk_3_bit_1),
.bit_2(circ_chk_3_bit_2),
.bit_3(circ_chk_3_bit_3),
.bit_4(circ_chk_3_bit_4),
.bit_5(circ_chk_3_bit_5),
.bit_6(circ_chk_3_bit_6),
.bit_7(circ_chk_3_bit_7),
.bit_8(circ_chk_3_bit_8),
.bit_9(circ_chk_3_bit_9),
.bit_10(circ_chk_3_bit_10),
.result(syn_res_circ_3)
);

wire syn_res_circ_4;

syn syn_4_inst (
.bit_1(circ_chk_4_bit_1),
.bit_2(circ_chk_4_bit_2),
.bit_3(circ_chk_4_bit_3),
.bit_4(circ_chk_4_bit_4),
.bit_5(circ_chk_4_bit_5),
.bit_6(circ_chk_4_bit_6),
.bit_7(circ_chk_4_bit_7),
.bit_8(circ_chk_4_bit_8),
.bit_9(circ_chk_4_bit_9),
.bit_10(0),
.result(syn_res_circ_4)
);

wire syn_res_circ_5;

syn syn_5_inst (
.bit_1(circ_chk_5_bit_1),
.bit_2(circ_chk_5_bit_2),
.bit_3(circ_chk_5_bit_3),
.bit_4(circ_chk_5_bit_4),
.bit_5(circ_chk_5_bit_5),
.bit_6(0),
.bit_7(0),
.bit_8(0),
.bit_9(0),
.bit_10(0),
.result(syn_res_circ_5)
);

wire syn_res_circ_6;

syn syn_6_inst (
.bit_1(circ_chk_6_bit_1),
.bit_2(circ_chk_6_bit_2),
.bit_3(circ_chk_6_bit_3),
.bit_4(circ_chk_6_bit_4),
.bit_5(circ_chk_6_bit_5),
.bit_6(0),
.bit_7(0),
.bit_8(0),
.bit_9(0),
.bit_10(0),
.result(syn_res_circ_6)
);

wire syn_res_circ_7;

syn syn_7_inst (
.bit_1(circ_chk_7_bit_1),
.bit_2(circ_chk_7_bit_2),
.bit_3(circ_chk_7_bit_3),
.bit_4(circ_chk_7_bit_4),
.bit_5(circ_chk_7_bit_5),
.bit_6(0),
.bit_7(0),
.bit_8(0),
.bit_9(0),
.bit_10(0),
.result(syn_res_circ_7)
);

wire syn_res_circ_8;

syn syn_8_inst (
.bit_1(circ_chk_8_bit_1),
.bit_2(circ_chk_8_bit_2),
.bit_3(circ_chk_8_bit_3),
.bit_4(circ_chk_8_bit_4),
.bit_5(0),
.bit_6(0),
.bit_7(0),
.bit_8(0),
.bit_9(0),
.bit_10(0),
.result(syn_res_circ_8)
);

wire syn_res;
assign syn_res = syn_res_circ_1|syn_res_circ_2|syn_res_circ_3|syn_res_circ_4|syn_res_circ_5|syn_res_circ_6|syn_res_circ_7|syn_res_circ_8;

wire [INT+FRAC-1:0] circ_1_msg_data_vr;
wire [INT+FRAC-1:0] circ_2_msg_data_vr;
wire [INT+FRAC-1:0] circ_3_msg_data_vr;
wire [INT+FRAC-1:0] circ_4_msg_data_vr;
wire [INT+FRAC-1:0] circ_5_msg_data_vr;
wire [INT+FRAC-1:0] circ_6_msg_data_vr;
wire [INT+FRAC-1:0] circ_7_msg_data_vr;
wire [INT+FRAC-1:0] circ_8_msg_data_vr;
wire [INT+FRAC-1:0] circ_9_msg_data_vr;
wire [INT+FRAC-1:0] circ_10_msg_data_vr;
wire [INT+FRAC-1:0] circ_11_msg_data_vr;
wire [INT+FRAC-1:0] circ_12_msg_data_vr;
wire [INT+FRAC-1:0] circ_13_msg_data_vr;
wire [INT+FRAC-1:0] circ_14_msg_data_vr;
wire [INT+FRAC-1:0] circ_15_msg_data_vr;
wire [INT+FRAC-1:0] circ_16_msg_data_vr;
wire [INT+FRAC-1:0] circ_17_msg_data_vr;
wire [INT+FRAC-1:0] circ_18_msg_data_vr;
wire [INT+FRAC-1:0] circ_19_msg_data_vr;
wire [INT+FRAC-1:0] circ_20_msg_data_vr;
wire [INT+FRAC-1:0] circ_21_msg_data_vr;
wire [INT+FRAC-1:0] circ_22_msg_data_vr;
wire [INT+FRAC-1:0] circ_23_msg_data_vr;
wire [INT+FRAC-1:0] circ_24_msg_data_vr;
wire [INT+FRAC-1:0] circ_25_msg_data_vr;
wire [INT+FRAC-1:0] circ_26_msg_data_vr;
wire [INT+FRAC-1:0] circ_27_msg_data_vr;
wire [INT+FRAC-1:0] circ_28_msg_data_vr;
wire [INT+FRAC-1:0] circ_29_msg_data_vr;
wire [INT+FRAC-1:0] circ_30_msg_data_vr;
wire [INT+FRAC-1:0] circ_31_msg_data_vr;
wire [INT+FRAC-1:0] circ_32_msg_data_vr;
wire [INT+FRAC-1:0] circ_33_msg_data_vr;
wire [INT+FRAC-1:0] circ_34_msg_data_vr;
wire [INT+FRAC-1:0] circ_35_msg_data_vr;
wire [INT+FRAC-1:0] circ_36_msg_data_vr;
wire [INT+FRAC-1:0] circ_37_msg_data_vr;
wire [INT+FRAC-1:0] circ_38_msg_data_vr;
wire [INT+FRAC-1:0] circ_39_msg_data_vr;
wire [INT+FRAC-1:0] circ_40_msg_data_vr;
wire [INT+FRAC-1:0] circ_41_msg_data_vr;
wire [INT+FRAC-1:0] circ_42_msg_data_vr;
wire [INT+FRAC-1:0] circ_43_msg_data_vr;
wire [INT+FRAC-1:0] circ_44_msg_data_vr;
wire [INT+FRAC-1:0] circ_45_msg_data_vr;
wire [INT+FRAC-1:0] circ_46_msg_data_vr;
wire [INT+FRAC-1:0] circ_47_msg_data_vr;
wire [INT+FRAC-1:0] circ_48_msg_data_vr;
wire [INT+FRAC-1:0] circ_49_msg_data_vr;
wire [INT+FRAC-1:0] circ_50_msg_data_vr;
wire [INT+FRAC-1:0] circ_51_msg_data_vr;
wire [INT+FRAC-1:0] circ_52_msg_data_vr;
wire [INT+FRAC-1:0] circ_53_msg_data_vr;
wire [INT+FRAC-1:0] circ_54_msg_data_vr;
wire [INT+FRAC-1:0] circ_55_msg_data_vr;
wire [INT+FRAC-1:0] circ_56_msg_data_vr;
wire [INT+FRAC-1:0] circ_57_msg_data_vr;

wire [INT+FRAC-1:0] circ_1_msg_data_cn;
wire [INT+FRAC-1:0] circ_2_msg_data_cn;
wire [INT+FRAC-1:0] circ_3_msg_data_cn;
wire [INT+FRAC-1:0] circ_4_msg_data_cn;
wire [INT+FRAC-1:0] circ_5_msg_data_cn;
wire [INT+FRAC-1:0] circ_6_msg_data_cn;
wire [INT+FRAC-1:0] circ_7_msg_data_cn;
wire [INT+FRAC-1:0] circ_8_msg_data_cn;
wire [INT+FRAC-1:0] circ_9_msg_data_cn;
wire [INT+FRAC-1:0] circ_10_msg_data_cn;
wire [INT+FRAC-1:0] circ_11_msg_data_cn;
wire [INT+FRAC-1:0] circ_12_msg_data_cn;
wire [INT+FRAC-1:0] circ_13_msg_data_cn;
wire [INT+FRAC-1:0] circ_14_msg_data_cn;
wire [INT+FRAC-1:0] circ_15_msg_data_cn;
wire [INT+FRAC-1:0] circ_16_msg_data_cn;
wire [INT+FRAC-1:0] circ_17_msg_data_cn;
wire [INT+FRAC-1:0] circ_18_msg_data_cn;
wire [INT+FRAC-1:0] circ_19_msg_data_cn;
wire [INT+FRAC-1:0] circ_20_msg_data_cn;
wire [INT+FRAC-1:0] circ_21_msg_data_cn;
wire [INT+FRAC-1:0] circ_22_msg_data_cn;
wire [INT+FRAC-1:0] circ_23_msg_data_cn;
wire [INT+FRAC-1:0] circ_24_msg_data_cn;
wire [INT+FRAC-1:0] circ_25_msg_data_cn;
wire [INT+FRAC-1:0] circ_26_msg_data_cn;
wire [INT+FRAC-1:0] circ_27_msg_data_cn;
wire [INT+FRAC-1:0] circ_28_msg_data_cn;
wire [INT+FRAC-1:0] circ_29_msg_data_cn;
wire [INT+FRAC-1:0] circ_30_msg_data_cn;
wire [INT+FRAC-1:0] circ_31_msg_data_cn;
wire [INT+FRAC-1:0] circ_32_msg_data_cn;
wire [INT+FRAC-1:0] circ_33_msg_data_cn;
wire [INT+FRAC-1:0] circ_34_msg_data_cn;
wire [INT+FRAC-1:0] circ_35_msg_data_cn;
wire [INT+FRAC-1:0] circ_36_msg_data_cn;
wire [INT+FRAC-1:0] circ_37_msg_data_cn;
wire [INT+FRAC-1:0] circ_38_msg_data_cn;
wire [INT+FRAC-1:0] circ_39_msg_data_cn;
wire [INT+FRAC-1:0] circ_40_msg_data_cn;
wire [INT+FRAC-1:0] circ_41_msg_data_cn;
wire [INT+FRAC-1:0] circ_42_msg_data_cn;
wire [INT+FRAC-1:0] circ_43_msg_data_cn;
wire [INT+FRAC-1:0] circ_44_msg_data_cn;
wire [INT+FRAC-1:0] circ_45_msg_data_cn;
wire [INT+FRAC-1:0] circ_46_msg_data_cn;
wire [INT+FRAC-1:0] circ_47_msg_data_cn;
wire [INT+FRAC-1:0] circ_48_msg_data_cn;
wire [INT+FRAC-1:0] circ_49_msg_data_cn;
wire [INT+FRAC-1:0] circ_50_msg_data_cn;
wire [INT+FRAC-1:0] circ_51_msg_data_cn;
wire [INT+FRAC-1:0] circ_52_msg_data_cn;
wire [INT+FRAC-1:0] circ_53_msg_data_cn;
wire [INT+FRAC-1:0] circ_54_msg_data_cn;
wire [INT+FRAC-1:0] circ_55_msg_data_cn;
wire [INT+FRAC-1:0] circ_56_msg_data_cn;
wire [INT+FRAC-1:0] circ_57_msg_data_cn;

assign circ_1_msg_data_in = (chk_r) ? circ_1_msg_data_vr : circ_1_msg_data_cn;
assign circ_2_msg_data_in = (chk_r) ? circ_2_msg_data_vr : circ_2_msg_data_cn;
assign circ_3_msg_data_in = (chk_r) ? circ_3_msg_data_vr : circ_3_msg_data_cn;
assign circ_4_msg_data_in = (chk_r) ? circ_4_msg_data_vr : circ_4_msg_data_cn;
assign circ_5_msg_data_in = (chk_r) ? circ_5_msg_data_vr : circ_5_msg_data_cn;
assign circ_6_msg_data_in = (chk_r) ? circ_6_msg_data_vr : circ_6_msg_data_cn;
assign circ_7_msg_data_in = (chk_r) ? circ_7_msg_data_vr : circ_7_msg_data_cn;
assign circ_8_msg_data_in = (chk_r) ? circ_8_msg_data_vr : circ_8_msg_data_cn;
assign circ_9_msg_data_in = (chk_r) ? circ_9_msg_data_vr : circ_9_msg_data_cn;
assign circ_10_msg_data_in = (chk_r) ? circ_10_msg_data_vr : circ_10_msg_data_cn;
assign circ_11_msg_data_in = (chk_r) ? circ_11_msg_data_vr : circ_11_msg_data_cn;
assign circ_12_msg_data_in = (chk_r) ? circ_12_msg_data_vr : circ_12_msg_data_cn;
assign circ_13_msg_data_in = (chk_r) ? circ_13_msg_data_vr : circ_13_msg_data_cn;
assign circ_14_msg_data_in = (chk_r) ? circ_14_msg_data_vr : circ_14_msg_data_cn;
assign circ_15_msg_data_in = (chk_r) ? circ_15_msg_data_vr : circ_15_msg_data_cn;
assign circ_16_msg_data_in = (chk_r) ? circ_16_msg_data_vr : circ_16_msg_data_cn;
assign circ_17_msg_data_in = (chk_r) ? circ_17_msg_data_vr : circ_17_msg_data_cn;
assign circ_18_msg_data_in = (chk_r) ? circ_18_msg_data_vr : circ_18_msg_data_cn;
assign circ_19_msg_data_in = (chk_r) ? circ_19_msg_data_vr : circ_19_msg_data_cn;
assign circ_20_msg_data_in = (chk_r) ? circ_20_msg_data_vr : circ_20_msg_data_cn;
assign circ_21_msg_data_in = (chk_r) ? circ_21_msg_data_vr : circ_21_msg_data_cn;
assign circ_22_msg_data_in = (chk_r) ? circ_22_msg_data_vr : circ_22_msg_data_cn;
assign circ_23_msg_data_in = (chk_r) ? circ_23_msg_data_vr : circ_23_msg_data_cn;
assign circ_24_msg_data_in = (chk_r) ? circ_24_msg_data_vr : circ_24_msg_data_cn;
assign circ_25_msg_data_in = (chk_r) ? circ_25_msg_data_vr : circ_25_msg_data_cn;
assign circ_26_msg_data_in = (chk_r) ? circ_26_msg_data_vr : circ_26_msg_data_cn;
assign circ_27_msg_data_in = (chk_r) ? circ_27_msg_data_vr : circ_27_msg_data_cn;
assign circ_28_msg_data_in = (chk_r) ? circ_28_msg_data_vr : circ_28_msg_data_cn;
assign circ_29_msg_data_in = (chk_r) ? circ_29_msg_data_vr : circ_29_msg_data_cn;
assign circ_30_msg_data_in = (chk_r) ? circ_30_msg_data_vr : circ_30_msg_data_cn;
assign circ_31_msg_data_in = (chk_r) ? circ_31_msg_data_vr : circ_31_msg_data_cn;
assign circ_32_msg_data_in = (chk_r) ? circ_32_msg_data_vr : circ_32_msg_data_cn;
assign circ_33_msg_data_in = (chk_r) ? circ_33_msg_data_vr : circ_33_msg_data_cn;
assign circ_34_msg_data_in = (chk_r) ? circ_34_msg_data_vr : circ_34_msg_data_cn;
assign circ_35_msg_data_in = (chk_r) ? circ_35_msg_data_vr : circ_35_msg_data_cn;
assign circ_36_msg_data_in = (chk_r) ? circ_36_msg_data_vr : circ_36_msg_data_cn;
assign circ_37_msg_data_in = (chk_r) ? circ_37_msg_data_vr : circ_37_msg_data_cn;
assign circ_38_msg_data_in = (chk_r) ? circ_38_msg_data_vr : circ_38_msg_data_cn;
assign circ_39_msg_data_in = (chk_r) ? circ_39_msg_data_vr : circ_39_msg_data_cn;
assign circ_40_msg_data_in = (chk_r) ? circ_40_msg_data_vr : circ_40_msg_data_cn;
assign circ_41_msg_data_in = (chk_r) ? circ_41_msg_data_vr : circ_41_msg_data_cn;
assign circ_42_msg_data_in = (chk_r) ? circ_42_msg_data_vr : circ_42_msg_data_cn;
assign circ_43_msg_data_in = (chk_r) ? circ_43_msg_data_vr : circ_43_msg_data_cn;
assign circ_44_msg_data_in = (chk_r) ? circ_44_msg_data_vr : circ_44_msg_data_cn;
assign circ_45_msg_data_in = (chk_r) ? circ_45_msg_data_vr : circ_45_msg_data_cn;
assign circ_46_msg_data_in = (chk_r) ? circ_46_msg_data_vr : circ_46_msg_data_cn;
assign circ_47_msg_data_in = (chk_r) ? circ_47_msg_data_vr : circ_47_msg_data_cn;
assign circ_48_msg_data_in = (chk_r) ? circ_48_msg_data_vr : circ_48_msg_data_cn;
assign circ_49_msg_data_in = (chk_r) ? circ_49_msg_data_vr : circ_49_msg_data_cn;
assign circ_50_msg_data_in = (chk_r) ? circ_50_msg_data_vr : circ_50_msg_data_cn;
assign circ_51_msg_data_in = (chk_r) ? circ_51_msg_data_vr : circ_51_msg_data_cn;
assign circ_52_msg_data_in = (chk_r) ? circ_52_msg_data_vr : circ_52_msg_data_cn;
assign circ_53_msg_data_in = (chk_r) ? circ_53_msg_data_vr : circ_53_msg_data_cn;
assign circ_54_msg_data_in = (chk_r) ? circ_54_msg_data_vr : circ_54_msg_data_cn;
assign circ_55_msg_data_in = (chk_r) ? circ_55_msg_data_vr : circ_55_msg_data_cn;
assign circ_56_msg_data_in = (chk_r) ? circ_56_msg_data_vr : circ_56_msg_data_cn;
assign circ_57_msg_data_in = (chk_r) ? circ_57_msg_data_vr : circ_57_msg_data_cn;

cn cn_1_inst (
.msg_in_1(circ_1_msg_data_out),
.msg_in_2(circ_2_msg_data_out),
.msg_in_3(circ_3_msg_data_out),
.msg_in_4(circ_4_msg_data_out),
.msg_in_5(circ_5_msg_data_out),
.msg_in_6(circ_6_msg_data_out),
.msg_in_7(circ_7_msg_data_out),
.msg_in_8(circ_8_msg_data_out),
.msg_in_9(circ_9_msg_data_out),
.msg_in_10(circ_10_msg_data_out),
.msg_out_1(circ_1_msg_data_cn),
.msg_out_2(circ_2_msg_data_cn),
.msg_out_3(circ_3_msg_data_cn),
.msg_out_4(circ_4_msg_data_cn),
.msg_out_5(circ_5_msg_data_cn),
.msg_out_6(circ_6_msg_data_cn),
.msg_out_7(circ_7_msg_data_cn),
.msg_out_8(circ_8_msg_data_cn),
.msg_out_9(circ_9_msg_data_cn),
.msg_out_10(circ_10_msg_data_cn)
);

cn cn_2_inst (
.msg_in_1(circ_11_msg_data_out),
.msg_in_2(circ_12_msg_data_out),
.msg_in_3(circ_13_msg_data_out),
.msg_in_4(circ_14_msg_data_out),
.msg_in_5(circ_15_msg_data_out),
.msg_in_6(circ_16_msg_data_out),
.msg_in_7(circ_17_msg_data_out),
.msg_in_8(circ_18_msg_data_out),
.msg_in_9(circ_19_msg_data_out),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_11_msg_data_cn),
.msg_out_2(circ_12_msg_data_cn),
.msg_out_3(circ_13_msg_data_cn),
.msg_out_4(circ_14_msg_data_cn),
.msg_out_5(circ_15_msg_data_cn),
.msg_out_6(circ_16_msg_data_cn),
.msg_out_7(circ_17_msg_data_cn),
.msg_out_8(circ_18_msg_data_cn),
.msg_out_9(circ_19_msg_data_cn),
.msg_out_10()
);

cn cn_3_inst (
.msg_in_1(circ_20_msg_data_out),
.msg_in_2(circ_21_msg_data_out),
.msg_in_3(circ_22_msg_data_out),
.msg_in_4(circ_23_msg_data_out),
.msg_in_5(circ_24_msg_data_out),
.msg_in_6(circ_25_msg_data_out),
.msg_in_7(circ_26_msg_data_out),
.msg_in_8(circ_27_msg_data_out),
.msg_in_9(circ_28_msg_data_out),
.msg_in_10(circ_29_msg_data_out),
.msg_out_1(circ_20_msg_data_cn),
.msg_out_2(circ_21_msg_data_cn),
.msg_out_3(circ_22_msg_data_cn),
.msg_out_4(circ_23_msg_data_cn),
.msg_out_5(circ_24_msg_data_cn),
.msg_out_6(circ_25_msg_data_cn),
.msg_out_7(circ_26_msg_data_cn),
.msg_out_8(circ_27_msg_data_cn),
.msg_out_9(circ_28_msg_data_cn),
.msg_out_10(circ_29_msg_data_cn)
);

cn cn_4_inst (
.msg_in_1(circ_30_msg_data_out),
.msg_in_2(circ_31_msg_data_out),
.msg_in_3(circ_32_msg_data_out),
.msg_in_4(circ_33_msg_data_out),
.msg_in_5(circ_34_msg_data_out),
.msg_in_6(circ_35_msg_data_out),
.msg_in_7(circ_36_msg_data_out),
.msg_in_8(circ_37_msg_data_out),
.msg_in_9(circ_38_msg_data_out),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_30_msg_data_cn),
.msg_out_2(circ_31_msg_data_cn),
.msg_out_3(circ_32_msg_data_cn),
.msg_out_4(circ_33_msg_data_cn),
.msg_out_5(circ_34_msg_data_cn),
.msg_out_6(circ_35_msg_data_cn),
.msg_out_7(circ_36_msg_data_cn),
.msg_out_8(circ_37_msg_data_cn),
.msg_out_9(circ_38_msg_data_cn),
.msg_out_10()
);

cn cn_5_inst (
.msg_in_1(circ_39_msg_data_out),
.msg_in_2(circ_40_msg_data_out),
.msg_in_3(circ_41_msg_data_out),
.msg_in_4(circ_42_msg_data_out),
.msg_in_5(circ_43_msg_data_out),
.msg_in_6(16'b111111111111111),
.msg_in_7(16'b111111111111111),
.msg_in_8(16'b111111111111111),
.msg_in_9(16'b111111111111111),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_39_msg_data_cn),
.msg_out_2(circ_40_msg_data_cn),
.msg_out_3(circ_41_msg_data_cn),
.msg_out_4(circ_42_msg_data_cn),
.msg_out_5(circ_43_msg_data_cn),
.msg_out_6(),
.msg_out_7(),
.msg_out_8(),
.msg_out_9(),
.msg_out_10()
);

cn cn_6_inst (
.msg_in_1(circ_44_msg_data_out),
.msg_in_2(circ_45_msg_data_out),
.msg_in_3(circ_46_msg_data_out),
.msg_in_4(circ_47_msg_data_out),
.msg_in_5(circ_48_msg_data_out),
.msg_in_6(16'b111111111111111),
.msg_in_7(16'b111111111111111),
.msg_in_8(16'b111111111111111),
.msg_in_9(16'b111111111111111),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_44_msg_data_cn),
.msg_out_2(circ_45_msg_data_cn),
.msg_out_3(circ_46_msg_data_cn),
.msg_out_4(circ_47_msg_data_cn),
.msg_out_5(circ_48_msg_data_cn),
.msg_out_6(),
.msg_out_7(),
.msg_out_8(),
.msg_out_9(),
.msg_out_10()
);

cn cn_7_inst (
.msg_in_1(circ_49_msg_data_out),
.msg_in_2(circ_50_msg_data_out),
.msg_in_3(circ_51_msg_data_out),
.msg_in_4(circ_52_msg_data_out),
.msg_in_5(circ_53_msg_data_out),
.msg_in_6(16'b111111111111111),
.msg_in_7(16'b111111111111111),
.msg_in_8(16'b111111111111111),
.msg_in_9(16'b111111111111111),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_49_msg_data_cn),
.msg_out_2(circ_50_msg_data_cn),
.msg_out_3(circ_51_msg_data_cn),
.msg_out_4(circ_52_msg_data_cn),
.msg_out_5(circ_53_msg_data_cn),
.msg_out_6(),
.msg_out_7(),
.msg_out_8(),
.msg_out_9(),
.msg_out_10()
);

cn cn_8_inst (
.msg_in_1(circ_54_msg_data_out),
.msg_in_2(circ_55_msg_data_out),
.msg_in_3(circ_56_msg_data_out),
.msg_in_4(circ_57_msg_data_out),
.msg_in_5(16'b111111111111111),
.msg_in_6(16'b111111111111111),
.msg_in_7(16'b111111111111111),
.msg_in_8(16'b111111111111111),
.msg_in_9(16'b111111111111111),
.msg_in_10(16'b111111111111111),
.msg_out_1(circ_54_msg_data_cn),
.msg_out_2(circ_55_msg_data_cn),
.msg_out_3(circ_56_msg_data_cn),
.msg_out_4(circ_57_msg_data_cn),
.msg_out_5(),
.msg_out_6(),
.msg_out_7(),
.msg_out_8(),
.msg_out_9(),
.msg_out_10()
);


wire [INT+FRAC-1:0] LLR_in_circ_1;
wire [INT+FRAC-1:0] LLR_in_circ_2;
wire [INT+FRAC-1:0] LLR_in_circ_3;
wire [INT+FRAC-1:0] LLR_in_circ_4;
wire [INT+FRAC-1:0] LLR_in_circ_5;
wire [INT+FRAC-1:0] LLR_in_circ_6;
wire [INT+FRAC-1:0] LLR_in_circ_7;
wire [INT+FRAC-1:0] LLR_in_circ_8;
wire [INT+FRAC-1:0] LLR_in_circ_9;
wire [INT+FRAC-1:0] LLR_in_circ_10;
wire [INT+FRAC-1:0] LLR_in_circ_11;
wire [INT+FRAC-1:0] LLR_in_circ_12;
wire [INT+FRAC-1:0] LLR_in_circ_13;
wire [INT+FRAC-1:0] LLR_in_circ_14;
wire [INT+FRAC-1:0] LLR_in_circ_15;
wire [INT+FRAC-1:0] LLR_in_circ_16;

assign LLR_in_circ_1 = (data[0*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_2 = (data[1*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_3 = (data[2*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_4 = (data[3*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_5 = (data[4*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_6 = (data[5*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_7 = (data[6*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_8 = (data[7*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_9 = (data[8*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_10 = (data[9*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_11 = (data[10*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_12 = (data[11*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_13 = (data[12*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_14 = (data[13*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_15 = (data[14*circ+circ_iter_]) ? -LLR : LLR;
assign LLR_in_circ_16 = (data[15*circ+circ_iter_]) ? -LLR : LLR;


wire [INT+FRAC-1:0] belief_out_1;
wire dec_bit_1;
assign dec_bit_1 = belief_out_1[INT+FRAC-1];

vr vn_1_inst (
.LLR(LLR_in_circ_1),
.ch_msg_1(circ_1_msg_data_out),
.ch_msg_2(circ_11_msg_data_out),
.ch_msg_3(circ_20_msg_data_out),
.ch_msg_4(circ_30_msg_data_out),
.ch_msg_5(circ_39_msg_data_out),
.ch_msg_6(circ_49_msg_data_out),
.ch_msg_7(0),
.vr_msg_1(circ_1_msg_data_vr),
.vr_msg_2(circ_11_msg_data_vr),
.vr_msg_3(circ_20_msg_data_vr),
.vr_msg_4(circ_30_msg_data_vr),
.vr_msg_5(circ_39_msg_data_vr),
.vr_msg_6(circ_49_msg_data_vr),
.vr_msg_7(),
.belief(belief_out_1)
);

wire [INT+FRAC-1:0] belief_out_2;
wire dec_bit_2;
assign dec_bit_2 = belief_out_2[INT+FRAC-1];

vr vn_2_inst (
.LLR(LLR_in_circ_2),
.ch_msg_1(circ_2_msg_data_out),
.ch_msg_2(circ_12_msg_data_out),
.ch_msg_3(circ_21_msg_data_out),
.ch_msg_4(circ_31_msg_data_out),
.ch_msg_5(circ_40_msg_data_out),
.ch_msg_6(circ_54_msg_data_out),
.ch_msg_7(0),
.vr_msg_1(circ_2_msg_data_vr),
.vr_msg_2(circ_12_msg_data_vr),
.vr_msg_3(circ_21_msg_data_vr),
.vr_msg_4(circ_31_msg_data_vr),
.vr_msg_5(circ_40_msg_data_vr),
.vr_msg_6(circ_54_msg_data_vr),
.vr_msg_7(),
.belief(belief_out_2)
);

wire [INT+FRAC-1:0] belief_out_3;
wire dec_bit_3;
assign dec_bit_3 = belief_out_3[INT+FRAC-1];

vr vn_3_inst (
.LLR(LLR_in_circ_3),
.ch_msg_1(circ_3_msg_data_out),
.ch_msg_2(circ_13_msg_data_out),
.ch_msg_3(circ_22_msg_data_out),
.ch_msg_4(circ_32_msg_data_out),
.ch_msg_5(circ_41_msg_data_out),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_3_msg_data_vr),
.vr_msg_2(circ_13_msg_data_vr),
.vr_msg_3(circ_22_msg_data_vr),
.vr_msg_4(circ_32_msg_data_vr),
.vr_msg_5(circ_41_msg_data_vr),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_3)
);

wire [INT+FRAC-1:0] belief_out_4;
wire dec_bit_4;
assign dec_bit_4 = belief_out_4[INT+FRAC-1];

vr vn_4_inst (
.LLR(LLR_in_circ_4),
.ch_msg_1(circ_4_msg_data_out),
.ch_msg_2(circ_14_msg_data_out),
.ch_msg_3(circ_23_msg_data_out),
.ch_msg_4(circ_33_msg_data_out),
.ch_msg_5(circ_44_msg_data_out),
.ch_msg_6(circ_50_msg_data_out),
.ch_msg_7(circ_55_msg_data_out),
.vr_msg_1(circ_4_msg_data_vr),
.vr_msg_2(circ_14_msg_data_vr),
.vr_msg_3(circ_23_msg_data_vr),
.vr_msg_4(circ_33_msg_data_vr),
.vr_msg_5(circ_44_msg_data_vr),
.vr_msg_6(circ_50_msg_data_vr),
.vr_msg_7(circ_55_msg_data_vr),
.belief(belief_out_4)
);

wire [INT+FRAC-1:0] belief_out_5;
wire dec_bit_5;
assign dec_bit_5 = belief_out_5[INT+FRAC-1];

vr vn_5_inst (
.LLR(LLR_in_circ_5),
.ch_msg_1(circ_5_msg_data_out),
.ch_msg_2(circ_15_msg_data_out),
.ch_msg_3(circ_24_msg_data_out),
.ch_msg_4(circ_34_msg_data_out),
.ch_msg_5(circ_45_msg_data_out),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_5_msg_data_vr),
.vr_msg_2(circ_15_msg_data_vr),
.vr_msg_3(circ_24_msg_data_vr),
.vr_msg_4(circ_34_msg_data_vr),
.vr_msg_5(circ_45_msg_data_vr),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_5)
);

wire [INT+FRAC-1:0] belief_out_6;
wire dec_bit_6;
assign dec_bit_6 = belief_out_6[INT+FRAC-1];

vr vn_6_inst (
.LLR(LLR_in_circ_6),
.ch_msg_1(circ_6_msg_data_out),
.ch_msg_2(circ_25_msg_data_out),
.ch_msg_3(circ_35_msg_data_out),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_6_msg_data_vr),
.vr_msg_2(circ_25_msg_data_vr),
.vr_msg_3(circ_35_msg_data_vr),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_6)
);

wire [INT+FRAC-1:0] belief_out_7;
wire dec_bit_7;
assign dec_bit_7 = belief_out_7[INT+FRAC-1];

vr vn_7_inst (
.LLR(LLR_in_circ_7),
.ch_msg_1(circ_7_msg_data_out),
.ch_msg_2(circ_16_msg_data_out),
.ch_msg_3(circ_26_msg_data_out),
.ch_msg_4(circ_36_msg_data_out),
.ch_msg_5(circ_46_msg_data_out),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_7_msg_data_vr),
.vr_msg_2(circ_16_msg_data_vr),
.vr_msg_3(circ_26_msg_data_vr),
.vr_msg_4(circ_36_msg_data_vr),
.vr_msg_5(circ_46_msg_data_vr),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_7)
);

wire [INT+FRAC-1:0] belief_out_8;
wire dec_bit_8;
assign dec_bit_8 = belief_out_8[INT+FRAC-1];

vr vn_8_inst (
.LLR(LLR_in_circ_8),
.ch_msg_1(circ_8_msg_data_out),
.ch_msg_2(circ_17_msg_data_out),
.ch_msg_3(circ_27_msg_data_out),
.ch_msg_4(circ_37_msg_data_out),
.ch_msg_5(circ_51_msg_data_out),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_8_msg_data_vr),
.vr_msg_2(circ_17_msg_data_vr),
.vr_msg_3(circ_27_msg_data_vr),
.vr_msg_4(circ_37_msg_data_vr),
.vr_msg_5(circ_51_msg_data_vr),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_8)
);

wire [INT+FRAC-1:0] belief_out_9;
wire dec_bit_9;
assign dec_bit_9 = belief_out_9[INT+FRAC-1];

vr vn_9_inst (
.LLR(LLR_in_circ_9),
.ch_msg_1(circ_9_msg_data_out),
.ch_msg_2(circ_42_msg_data_out),
.ch_msg_3(circ_47_msg_data_out),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_9_msg_data_vr),
.vr_msg_2(circ_42_msg_data_vr),
.vr_msg_3(circ_47_msg_data_vr),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_9)
);

wire [INT+FRAC-1:0] belief_out_10;
wire dec_bit_10;
assign dec_bit_10 = belief_out_10[INT+FRAC-1];

vr vn_10_inst (
.LLR(LLR_in_circ_10),
.ch_msg_1(circ_10_msg_data_out),
.ch_msg_2(circ_18_msg_data_out),
.ch_msg_3(circ_52_msg_data_out),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_10_msg_data_vr),
.vr_msg_2(circ_18_msg_data_vr),
.vr_msg_3(circ_52_msg_data_vr),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_10)
);

wire [INT+FRAC-1:0] belief_out_11;
wire dec_bit_11;
assign dec_bit_11 = belief_out_11[INT+FRAC-1];

vr vn_11_inst (
.LLR(LLR_in_circ_11),
.ch_msg_1(circ_19_msg_data_out),
.ch_msg_2(circ_28_msg_data_out),
.ch_msg_3(circ_56_msg_data_out),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_19_msg_data_vr),
.vr_msg_2(circ_28_msg_data_vr),
.vr_msg_3(circ_56_msg_data_vr),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_11)
);

wire [INT+FRAC-1:0] belief_out_12;
wire dec_bit_12;
assign dec_bit_12 = belief_out_12[INT+FRAC-1];

vr vn_12_inst (
.LLR(LLR_in_circ_12),
.ch_msg_1(circ_29_msg_data_out),
.ch_msg_2(circ_38_msg_data_out),
.ch_msg_3(0),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_29_msg_data_vr),
.vr_msg_2(circ_38_msg_data_vr),
.vr_msg_3(),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_12)
);

wire [INT+FRAC-1:0] belief_out_13;
wire dec_bit_13;
assign dec_bit_13 = belief_out_13[INT+FRAC-1];

vr vn_13_inst (
.LLR(LLR_in_circ_13),
.ch_msg_1(circ_43_msg_data_out),
.ch_msg_2(0),
.ch_msg_3(0),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_43_msg_data_vr),
.vr_msg_2(),
.vr_msg_3(),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_13)
);

wire [INT+FRAC-1:0] belief_out_14;
wire dec_bit_14;
assign dec_bit_14 = belief_out_14[INT+FRAC-1];

vr vn_14_inst (
.LLR(LLR_in_circ_14),
.ch_msg_1(circ_48_msg_data_out),
.ch_msg_2(0),
.ch_msg_3(0),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_48_msg_data_vr),
.vr_msg_2(),
.vr_msg_3(),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_14)
);

wire [INT+FRAC-1:0] belief_out_15;
wire dec_bit_15;
assign dec_bit_15 = belief_out_15[INT+FRAC-1];

vr vn_15_inst (
.LLR(LLR_in_circ_15),
.ch_msg_1(circ_53_msg_data_out),
.ch_msg_2(0),
.ch_msg_3(0),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_53_msg_data_vr),
.vr_msg_2(),
.vr_msg_3(),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_15)
);

wire [INT+FRAC-1:0] belief_out_16;
wire dec_bit_16;
assign dec_bit_16 = belief_out_16[INT+FRAC-1];

vr vn_16_inst (
.LLR(LLR_in_circ_16),
.ch_msg_1(circ_57_msg_data_out),
.ch_msg_2(0),
.ch_msg_3(0),
.ch_msg_4(0),
.ch_msg_5(0),
.ch_msg_6(0),
.ch_msg_7(0),
.vr_msg_1(circ_57_msg_data_vr),
.vr_msg_2(),
.vr_msg_3(),
.vr_msg_4(),
.vr_msg_5(),
.vr_msg_6(),
.vr_msg_7(),
.belief(belief_out_16)
);


always @(posedge clk) begin
	if (rst) begin
		FSM <= 1;
		circ_iter <= 0;
		iter_num <= 0;

		nop <= 1;

		success_dec <= 0;
		dec_cw <= data;
		non_zero_syn <= 0;
		chk_r <= 0;
		chk_w <= 0;		
	end

	else if (FSM == 1) begin
		if(circ_iter == circ) begin
			if(nop == 1) begin
				if(non_zero_syn) begin
					FSM <= 2;

					chk_r <= 1;
				
					non_zero_syn <= 0;
				end
				else begin
					FSM <= 8;
				end
			
				circ_iter <= 0;
				circ_iter_ <= 0;
			end
			else begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 1;
			end
		end
		else begin
			if(nop == 2) begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end
			end

			circ_iter <= circ_iter + 1;

			nop <= 2;
		end
	end

	// Update Variable Node messages
	else if (FSM == 2) begin
		if(circ_iter == circ) begin
			if(nop == 4) begin
				circ_iter_ <= circ_iter_ + 1;

				nop <= 2;
			end
			else if (nop == 2) begin
				nop <= 1;
				FSM <= 4;

				chk_r <= 0;
				chk_w <= 1;

				circ_iter <= 0;
				circ_iter_ <= 0;
			end

			dec_cw[0*circ+circ_iter_] <= dec_bit_1;
			dec_cw[1*circ+circ_iter_] <= dec_bit_2;
			dec_cw[2*circ+circ_iter_] <= dec_bit_3;
			dec_cw[3*circ+circ_iter_] <= dec_bit_4;
			dec_cw[4*circ+circ_iter_] <= dec_bit_5;
			dec_cw[5*circ+circ_iter_] <= dec_bit_6;
			dec_cw[6*circ+circ_iter_] <= dec_bit_7;
			dec_cw[7*circ+circ_iter_] <= dec_bit_8;
			dec_cw[8*circ+circ_iter_] <= dec_bit_9;
			dec_cw[9*circ+circ_iter_] <= dec_bit_10;
			dec_cw[10*circ+circ_iter_] <= dec_bit_11;
			dec_cw[11*circ+circ_iter_] <= dec_bit_12;
			dec_cw[12*circ+circ_iter_] <= dec_bit_13;
			dec_cw[13*circ+circ_iter_] <= dec_bit_14;
			dec_cw[14*circ+circ_iter_] <= dec_bit_15;
			dec_cw[15*circ+circ_iter_] <= dec_bit_16;
		end
		else begin
			if(nop == 4) begin
				circ_iter_ <= circ_iter_ + 1;

				dec_cw[0*circ+circ_iter_] <= dec_bit_1;
				dec_cw[1*circ+circ_iter_] <= dec_bit_2;
				dec_cw[2*circ+circ_iter_] <= dec_bit_3;
				dec_cw[3*circ+circ_iter_] <= dec_bit_4;
				dec_cw[4*circ+circ_iter_] <= dec_bit_5;
				dec_cw[5*circ+circ_iter_] <= dec_bit_6;
				dec_cw[6*circ+circ_iter_] <= dec_bit_7;
				dec_cw[7*circ+circ_iter_] <= dec_bit_8;
				dec_cw[8*circ+circ_iter_] <= dec_bit_9;
				dec_cw[9*circ+circ_iter_] <= dec_bit_10;
				dec_cw[10*circ+circ_iter_] <= dec_bit_11;
				dec_cw[11*circ+circ_iter_] <= dec_bit_12;
				dec_cw[12*circ+circ_iter_] <= dec_bit_13;
				dec_cw[13*circ+circ_iter_] <= dec_bit_14;
				dec_cw[14*circ+circ_iter_] <= dec_bit_15;
				dec_cw[15*circ+circ_iter_] <= dec_bit_16;
			end
			else if (nop == 2) begin
				nop <= 4;
			end
			else begin
				nop <= 2;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	// Update Check Node messages
	else if (FSM == 4) begin
		if(circ_iter == circ) begin
			if(nop == 4) begin
				circ_iter_ <= circ_iter_ + 1;

				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 2;
			end
			else if (nop == 2) begin
				if(non_zero_syn) begin
					if(iter_num < max_iter) begin
						nop <= 1;
						FSM <= 2;

						chk_r <= 1;
						chk_w <= 0;

						non_zero_syn <= 0;

						iter_num <= iter_num + 1;

						circ_iter <= 0;
						circ_iter_ <= 0;
					end
					else begin
						FSM <= 16;
					end
				end
				else begin
					FSM <= 8;
				end
			end
		end
		else begin
			if(nop == 4) begin
				circ_iter_ <= circ_iter_ + 1;

				if(syn_res) begin
					non_zero_syn <= 1;
				end
			end
			else if (nop == 2) begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 4;
			end
			else begin
				nop <= 2;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	else if (FSM == 8) begin
		success_dec <= 1;
	end
	else if (FSM == 16) begin
		success_dec <= 0;
	end
end

endmodule
