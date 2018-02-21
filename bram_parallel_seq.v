module decoder#(parameter n = 12, parameter m = 6, parameter log2n = 4, parameter log2m = 3, parameter max_iter = 30, parameter log2max_iter = 5,
				parameter INT = 8, parameter FRAC = 8, parameter deg_v = 3, parameter deg_c = 6, parameter log2deg_v = 2, parameter log2deg_c = 3, 
				parameter circ = 2, parameter log2circ = 2, parameter circ_addr_offset = 2)(
	input clk,
	input rst,
	output success,
	output [log2max_iter-1:0] iterations
	);

reg [log2circ-1:0] circ_iter;
reg [log2circ-1:0] circ_iter_;
reg chk_r = 0;
reg chk_w = 0;

wire [INT+FRAC-1:0] LLR = 16'b1010101011001011;

wire [n-1:0] data = 12'b100101010101;
reg [n-1:0] dec_cw;
reg [1:0] FSM;
reg non_zero_syn;
reg [1:0] nop;
reg [1:0] nop_;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;


wire [log2circ-1:0] circ_addr;
assign circ_addr = (chk_r)? 2+circ_iter: circ_iter;

wire [log2circ-1:0] circ_1_data;
circ_1 circ_1_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_1_data)
	);

wire [log2circ-1:0] circ_2_data;
circ_2 circ_2_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_2_data)
	);

wire [log2circ-1:0] circ_3_data;
circ_3 circ_3_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_3_data)
	);

wire [log2circ-1:0] circ_4_data;
circ_4 circ_4_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_4_data)
	);

wire [log2circ-1:0] circ_5_data;
circ_5 circ_5_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_5_data)
	);

wire [log2circ-1:0] circ_6_data;
circ_6 circ_6_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_6_data)
	);

wire [log2circ-1:0] circ_7_data;
circ_7 circ_7_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_7_data)
	);

wire [log2circ-1:0] circ_8_data;
circ_8 circ_8_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_8_data)
	);

wire [log2circ-1:0] circ_9_data;
circ_9 circ_9_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_9_data)
	);

wire [log2circ-1:0] circ_10_data;
circ_10 circ_10_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_10_data)
	);

wire [log2circ-1:0] circ_11_data;
circ_11 circ_11_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_11_data)
	);

wire [log2circ-1:0] circ_12_data;
circ_12 circ_12_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_12_data)
	);

wire [log2circ-1:0] circ_13_data;
circ_13 circ_13_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_13_data)
	);

wire [log2circ-1:0] circ_14_data;
circ_14 circ_14_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_14_data)
	);

wire [log2circ-1:0] circ_15_data;
circ_15 circ_15_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_15_data)
	);

wire [log2circ-1:0] circ_16_data;
circ_16 circ_16_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_16_data)
	);

wire [log2circ-1:0] circ_17_data;
circ_17 circ_17_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_17_data)
	);

wire [log2circ-1:0] circ_18_data;
circ_18 circ_18_inst(
	.clka(clk),
	.addra(circ_addr),
    .douta(circ_18_data)
	);


wire [log2circ-1:0] circ_msg_addr_w;
assign circ_1_msg_addr_w = (chk_w)? 2+circ_iter: circ_iter;
wire [log2circ-1:0] circ_msg_addr_r;
assign circ_1_msg_addr_r = (chk_r)? 2+circ_iter: circ_iter;

wire [INT+FRAC-1:0] circ_1_msg_data_in;
wire [INT+FRAC-1:0] circ_1_msg_data_out;
circ_1_msg circ_1_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_1_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_1_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_2_msg_data_in;
wire [INT+FRAC-1:0] circ_2_msg_data_out;
circ_2_msg circ_2_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_2_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_2_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_3_msg_data_in;
wire [INT+FRAC-1:0] circ_3_msg_data_out;
circ_3_msg circ_3_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_3_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_3_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_4_msg_data_in;
wire [INT+FRAC-1:0] circ_4_msg_data_out;
circ_4_msg circ_4_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_4_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_4_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_5_msg_data_in;
wire [INT+FRAC-1:0] circ_5_msg_data_out;
circ_5_msg circ_5_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_5_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_5_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_6_msg_data_in;
wire [INT+FRAC-1:0] circ_6_msg_data_out;
circ_6_msg circ_6_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_6_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_6_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_7_msg_data_in;
wire [INT+FRAC-1:0] circ_7_msg_data_out;
circ_7_msg circ_7_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_7_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_7_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_8_msg_data_in;
wire [INT+FRAC-1:0] circ_8_msg_data_out;
circ_8_msg circ_8_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_8_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_8_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_9_msg_data_in;
wire [INT+FRAC-1:0] circ_9_msg_data_out;
circ_9_msg circ_9_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_9_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_9_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_10_msg_data_in;
wire [INT+FRAC-1:0] circ_10_msg_data_out;
circ_10_msg circ_10_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_10_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_10_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_11_msg_data_in;
wire [INT+FRAC-1:0] circ_11_msg_data_out;
circ_11_msg circ_11_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_11_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_11_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_12_msg_data_in;
wire [INT+FRAC-1:0] circ_12_msg_data_out;
circ_12_msg circ_12_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_12_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_12_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_13_msg_data_in;
wire [INT+FRAC-1:0] circ_13_msg_data_out;
circ_13_msg circ_13_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_13_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_13_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_14_msg_data_in;
wire [INT+FRAC-1:0] circ_14_msg_data_out;
circ_14_msg circ_14_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_14_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_14_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_15_msg_data_in;
wire [INT+FRAC-1:0] circ_15_msg_data_out;
circ_15_msg circ_15_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_15_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_15_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_16_msg_data_in;
wire [INT+FRAC-1:0] circ_16_msg_data_out;
circ_16_msg circ_16_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_16_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_16_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_17_msg_data_in;
wire [INT+FRAC-1:0] circ_17_msg_data_out;
circ_17_msg circ_17_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_17_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_17_msg_data_out)
	);

wire [INT+FRAC-1:0] circ_18_msg_data_in;
wire [INT+FRAC-1:0] circ_18_msg_data_out;
circ_18_msg circ_18_msg_inst(
	.clka(clk),
    .wea(1),
    .addra(circ_msg_addr_w),
    .dina(circ_18_msg_data_in),
    .clkb(clk),
    .addrb(circ_msg_addr_r),
    .doutb(circ_18_msg_data_out)
	);


wire circ_chk_1_bit_1 = dec_cw[circ_1_data];
wire circ_chk_1_bit_2 = dec_cw[circ+circ_2_data];
wire circ_chk_1_bit_3 = dec_cw[2*circ+circ_3_data];
wire circ_chk_1_bit_4 = dec_cw[3*circ+circ_4_data];
wire circ_chk_1_bit_5 = dec_cw[4*circ+circ_5_data];
wire circ_chk_1_bit_6 = dec_cw[5*circ+circ_6_data];

wire circ_chk_2_bit_1 = dec_cw[circ_7_data];
wire circ_chk_2_bit_2 = dec_cw[circ+circ_8_data];
wire circ_chk_2_bit_3 = dec_cw[2*circ+circ_9_data];
wire circ_chk_2_bit_4 = dec_cw[3*circ+circ_10_data];
wire circ_chk_2_bit_5 = dec_cw[4*circ+circ_11_data];
wire circ_chk_2_bit_6 = dec_cw[5*circ+circ_12_data];

wire circ_chk_3_bit_1 = dec_cw[circ_13_data];
wire circ_chk_3_bit_2 = dec_cw[circ+circ_14_data];
wire circ_chk_3_bit_3 = dec_cw[2*circ+circ_15_data];
wire circ_chk_3_bit_4 = dec_cw[3*circ+circ_16_data];
wire circ_chk_3_bit_5 = dec_cw[4*circ+circ_17_data];
wire circ_chk_3_bit_6 = dec_cw[5*circ+circ_18_data];


wire syn_res_circ_1;

syn	syn_1_inst (
	.bit_0(circ_chk_1_bit_1),
	.bit_1(circ_chk_1_bit_2),
	.bit_2(circ_chk_1_bit_3),
	.bit_3(circ_chk_1_bit_4),
	.bit_4(circ_chk_1_bit_5),
	.bit_5(circ_chk_1_bit_6),
	.result(syn_res_circ_1)
	);

wire syn_res_circ_2;

syn	syn_2_inst (
	.bit_0(circ_chk_2_bit_1),
	.bit_1(circ_chk_2_bit_2),
	.bit_2(circ_chk_2_bit_3),
	.bit_3(circ_chk_2_bit_4),
	.bit_4(circ_chk_2_bit_5),
	.bit_5(circ_chk_2_bit_6),
	.result(syn_res_circ_2)
	);

wire syn_res_circ_3;

syn	syn_3_inst (
	.bit_0(circ_chk_3_bit_1),
	.bit_1(circ_chk_3_bit_2),
	.bit_2(circ_chk_3_bit_3),
	.bit_3(circ_chk_3_bit_4),
	.bit_4(circ_chk_3_bit_5),
	.bit_5(circ_chk_3_bit_6),
	.result(syn_res_circ_3)
	);

wire syn_res;
assign syn_res = syn_res_circ_1|syn_res_circ_2|syn_res_circ_3;


wire [INT+FRAC-1:0] LLR_in_circ_1;
wire [INT+FRAC-1:0] LLR_in_circ_2;
wire [INT+FRAC-1:0] LLR_in_circ_3;
wire [INT+FRAC-1:0] LLR_in_circ_4;
wire [INT+FRAC-1:0] LLR_in_circ_5;
wire [INT+FRAC-1:0] LLR_in_circ_6;

assign LLR_in_circ_1 = data[circ_iter]*LLR;
assign LLR_in_circ_2 = data[circ+circ_iter]*LLR;
assign LLR_in_circ_3 = data[2*circ+circ_iter]*LLR;
assign LLR_in_circ_4 = data[3*circ+circ_iter]*LLR;
assign LLR_in_circ_5 = data[4*circ+circ_iter]*LLR;
assign LLR_in_circ_6 = data[5*circ+circ_iter]*LLR;


cn cn_1_inst (
	.msg_in_1(circ_1_msg_data_out),
	.msg_in_2(circ_2_msg_data_out),
	.msg_in_3(circ_3_msg_data_out),
	.msg_in_4(circ_4_msg_data_out),
	.msg_in_5(circ_5_msg_data_out),
	.msg_in_6(circ_6_msg_data_out),
	.msg_out_1(circ_1_msg_data_in),
	.msg_out_2(circ_2_msg_data_in),
	.msg_out_3(circ_3_msg_data_in),
	.msg_out_4(circ_4_msg_data_in),
	.msg_out_5(circ_5_msg_data_in),
	.msg_out_6(circ_6_msg_data_in)
	);

cn cn_2_inst (
	.msg_in_1(circ_7_msg_data_out),
	.msg_in_2(circ_8_msg_data_out),
	.msg_in_3(circ_9_msg_data_out),
	.msg_in_4(circ_10_msg_data_out),
	.msg_in_5(circ_11_msg_data_out),
	.msg_in_6(circ_12_msg_data_out),
	.msg_out_1(circ_7_msg_data_in),
	.msg_out_2(circ_8_msg_data_in),
	.msg_out_3(circ_9_msg_data_in),
	.msg_out_4(circ_10_msg_data_in),
	.msg_out_5(circ_11_msg_data_in),
	.msg_out_6(circ_12_msg_data_in)
	);

cn cn_3_inst (
	.msg_in_1(circ_13_msg_data_out),
	.msg_in_2(circ_14_msg_data_out),
	.msg_in_3(circ_15_msg_data_out),
	.msg_in_4(circ_16_msg_data_out),
	.msg_in_5(circ_17_msg_data_out),
	.msg_in_6(circ_18_msg_data_out),
	.msg_out_1(circ_13_msg_data_in),
	.msg_out_2(circ_14_msg_data_in),
	.msg_out_3(circ_15_msg_data_in),
	.msg_out_4(circ_16_msg_data_in),
	.msg_out_5(circ_17_msg_data_in),
	.msg_out_6(circ_18_msg_data_in)
	);



wire [INT+FRAC-1:0] belief_out_1;
wire dec_bit_1;
assign dec_bit_1 = belief_out_1[INT+FRAC-1];

vr vn_1_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_1_msg_data_out),
	.ch_msg_1(circ_7_msg_data_out),
	.ch_msg_2(circ_13_msg_data_out),
	.vr_msg_0(circ_1_msg_data_in),
	.vr_msg_1(circ_7_msg_data_in),
	.vr_msg_2(circ_13_msg_data_in),
	.belief(belief_out_1)
	);

wire [INT+FRAC-1:0] belief_out_2;
wire dec_bit_2;
assign dec_bit_2 = belief_out_2[INT+FRAC-1];

vr vn_2_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_2_msg_data_out),
	.ch_msg_1(circ_8_msg_data_out),
	.ch_msg_2(circ_14_msg_data_out),
	.vr_msg_0(circ_2_msg_data_in),
	.vr_msg_1(circ_8_msg_data_in),
	.vr_msg_2(circ_14_msg_data_in),
	.belief(belief_out_2)
	);

wire [INT+FRAC-1:0] belief_out_3;
wire dec_bit_3;
assign dec_bit_3 = belief_out_3[INT+FRAC-1];

vr vn_3_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_3_msg_data_out),
	.ch_msg_1(circ_9_msg_data_out),
	.ch_msg_2(circ_15_msg_data_out),
	.vr_msg_0(circ_3_msg_data_in),
	.vr_msg_1(circ_9_msg_data_in),
	.vr_msg_2(circ_15_msg_data_in),
	.belief(belief_out_3)
	);

wire [INT+FRAC-1:0] belief_out_4;
wire dec_bit_4;
assign dec_bit_4 = belief_out_4[INT+FRAC-1];

vr vn_4_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_4_msg_data_out),
	.ch_msg_1(circ_10_msg_data_out),
	.ch_msg_2(circ_16_msg_data_out),
	.vr_msg_0(circ_4_msg_data_in),
	.vr_msg_1(circ_10_msg_data_in),
	.vr_msg_2(circ_16_msg_data_in),
	.belief(belief_out_4)
	);

wire [INT+FRAC-1:0] belief_out_5;
wire dec_bit_5;
assign dec_bit_5 = belief_out_5[INT+FRAC-1];

vr vn_5_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_5_msg_data_out),
	.ch_msg_1(circ_11_msg_data_out),
	.ch_msg_2(circ_17_msg_data_out),
	.vr_msg_0(circ_5_msg_data_in),
	.vr_msg_1(circ_11_msg_data_in),
	.vr_msg_2(circ_17_msg_data_in),
	.belief(belief_out_5)
	);

wire [INT+FRAC-1:0] belief_out_6;
wire dec_bit_6;
assign dec_bit_6 = belief_out_6[INT+FRAC-1];

vr vn_6_inst (
	.LLR(LLR_in_circ_1),
	.ch_msg_0(circ_6_msg_data_out),
	.ch_msg_1(circ_12_msg_data_out),
	.ch_msg_2(circ_18_msg_data_out),
	.vr_msg_0(circ_6_msg_data_in),
	.vr_msg_1(circ_12_msg_data_in),
	.vr_msg_2(circ_18_msg_data_in),
	.belief(belief_out_6)
	);


always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		circ_iter <= 0;
		iter_num <= 0;

		nop <= 0;
		nop_ <= 0;

		success_dec <= 0;
		dec_cw <= data;
		non_zero_syn <= 0;
		chk_r <= 0;
		chk_w <= 0;		
	end

	else if (FSM == 0) begin
		if(circ_iter == circ) begin
			if(non_zero_syn) begin
				FSM <= 1;

				chk_r <= 1;
				
				non_zero_syn <= 0;
			end
			else begin
				FSM <= 3;
			end
			
			circ_iter <= 0;
			circ_iter_ <= 0;
		end
		else begin
			if(syn_res) begin
				non_zero_syn <= 1;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	// Update Variable Node messages
	else if (FSM == 1) begin
		if(circ_iter == 2) begin
			if(nop == 2) begin
				nop <= 0;
				FSM <= 2;

				chk_r <= 0;
				chk_w <= 1;

				circ_iter <= 0;
				circ_iter_ <= 0;
			end
			else begin
				nop <= nop + 1;

				circ_iter_ <= circ_iter_ + 1;

				dec_cw[circ_iter_] <= dec_bit_1;
				dec_cw[circ+circ_iter_] <= dec_bit_2;
				dec_cw[2*circ+circ_iter_] <= dec_bit_3;
				dec_cw[3*circ+circ_iter_] <= dec_bit_4;
				dec_cw[4*circ+circ_iter_] <= dec_bit_5;
				dec_cw[5*circ+circ_iter_] <= dec_bit_6;
			end
		end
		else begin
			if(nop_ == 2) begin
				circ_iter_ <= circ_iter_ + 1;
			end
			else begin
				nop_ <= nop_ + 1;
			end

			circ_iter <= circ_iter + 1;

			dec_cw[circ_iter_] <= dec_bit_1;
			dec_cw[circ+circ_iter_] <= dec_bit_2;
			dec_cw[2*circ+circ_iter_] <= dec_bit_3;
			dec_cw[3*circ+circ_iter_] <= dec_bit_4;
			dec_cw[4*circ+circ_iter_] <= dec_bit_5;
			dec_cw[5*circ+circ_iter_] <= dec_bit_6;
		end
	end

	// Update Check Node messages
	else if (FSM == 2) begin
		if(circ_iter == 2) begin
			if(non_zero_syn) begin
				if(iter_num < max_iter) begin
					if(nop == 2) begin
						nop <= 0;
						FSM <= 1;

						chk_r <= 1;
						chk_w <= 0;

						non_zero_syn <= 0;

						iter_num <= iter_num + 1;

						circ_iter <= 0;
					end
					else begin
						nop <= nop + 1;
					end
				end
			end
			else begin
				FSM <= 3;
			end
		end
		else begin
			if(syn_res) begin
				non_zero_syn <= 1;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	else if (FSM == 3) begin
		success_dec <= 1;
	end
end

endmodule
