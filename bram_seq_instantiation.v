module decoder#(parameter n = 204, parameter m = 102, parameter log2n = 8, parameter log2m = 7, parameter max_iter = 30, parameter log2max_iter = 5,
				parameter INT = 8, parameter FRAC = 8, parameter deg_v = 3, parameter deg_c = 6, parameter log2deg_v = 2, parameter log2deg_c = 3)(
	input clk,
	input rst,
	output success,
	output [log2max_iter-1:0] iterations
	);

// Zero-indexed
reg [log2n-1:0] v_neighbor_bram_addr;
wire [deg_v*log2m-1:0] v_neighbor_bram_data;
v_neighbor_bram v_neighbor_bram_inst(
    .clka(clk),
    .addra(v_neighbor_bram_addr),
    .douta(v_neighbor_bram_data)
    );
reg [log2m-1:0] c_neighbor_bram_addr;
wire [deg_c*log2n-1:0] c_neighbor_bram_data;
c_neighbor_bram c_neighbor_bram_inst(
    .clka(clk),
    .addra(c_neighbor_bram_addr),
    .douta(c_neighbor_bram_data)
    );
// One-indexed
reg [log2m-1:0] neighbor_index_to_var_bram_addr;
wire [deg_c*log2deg_v-1:0] neighbor_index_to_var_bram_data;
neighbor_index_to_var_bram neighbor_index_to_var_bram_inst(
    .clka(clk),
    .addra(neighbor_index_to_var_bram_addr),
    .douta(neighbor_index_to_var_bram_data)
    );
reg [log2n-1:0] neighbor_index_to_ch_bram_addr;
wire [deg_v*log2deg_c-1:0] neighbor_index_to_ch_bram_data;
neighbor_index_to_ch_bram neighbor_index_to_ch_bram_inst(
    .clka(clk),
    .addra(neighbor_index_to_ch_bram_addr),
    .douta(neighbor_index_to_ch_bram_data)
    );

reg v_msg_wr = 0;
reg [log2n-1:0] v_msg_addr;
reg [deg_v*(INT+FRAC)-1:0] v_msg_data_in;
wire [deg_v*(INT+FRAC)-1:0] v_msg_data_out;
v_msg v_msg_inst(
	.clka(clk),
    .wea(v_msg_wr),
    .addra(v_msg_addr),
    .dina(v_msg_data_in),
    .douta(v_msg_data_out)
	);
reg c_msg_wr = 0;
reg [log2m-1:0] c_msg_addr;
reg [deg_c*(INT+FRAC)-1:0] c_msg_data_in;
wire [deg_c*(INT+FRAC)-1:0] c_msg_data_out;
c_msg c_msg_inst(
	.clka(clk),
    .wea(c_msg_wr),
    .addra(c_msg_addr),
    .dina(c_msg_data_in),
    .douta(c_msg_data_out)
	);


wire [INT+FRAC-1:0] LLR = 16'b1010101011001011;

wire [n-1:0] data = 12'b100101010101;
reg [n-1:0] dec_cw;
reg [2:0] FSM;
reg non_zero_syn;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;

reg nop;

wire [INT+FRAC-1:0] LLR_in;
assign LLR_in = data[v_msg_addr]*LLR;


reg bit_0_in;
reg bit_1_in;
reg bit_2_in;
reg bit_3_in;
reg bit_4_in;
reg bit_5_in;
wire syn_res;

syn	syn_0_inst (
	.bit_0(bit_0_in),
	.bit_1(bit_1_in),
	.bit_2(bit_2_in),
	.bit_3(bit_3_in),
	.bit_4(bit_4_in),
	.bit_5(bit_5_in),
	.result(syn_res)
	);


wire [log2n-1:0] chk_neighbor_0;
wire [log2n-1:0] chk_neighbor_1;
wire [log2n-1:0] chk_neighbor_2;
wire [log2n-1:0] chk_neighbor_3;
wire [log2n-1:0] chk_neighbor_4;
wire [log2n-1:0] chk_neighbor_5;
assign chk_neighbor_5 = c_neighbor_bram_data[deg_c*log2n-1 -: log2n];
assign chk_neighbor_4 = c_neighbor_bram_data[(deg_c-1)*log2n-1 -: log2n];
assign chk_neighbor_3 = c_neighbor_bram_data[(deg_c-2)*log2n-1 -: log2n];
assign chk_neighbor_2 = c_neighbor_bram_data[(deg_c-3)*log2n-1 -: log2n];
assign chk_neighbor_1 = c_neighbor_bram_data[(deg_c-4)*log2n-1 -: log2n];
assign chk_neighbor_0 = c_neighbor_bram_data[(deg_c-5)*log2n-1 -: log2n];

wire [log2deg_v-1:0] chk_order_0;
wire [log2deg_v-1:0] chk_order_1;
wire [log2deg_v-1:0] chk_order_2;
wire [log2deg_v-1:0] chk_order_3;
wire [log2deg_v-1:0] chk_order_4;
wire [log2deg_v-1:0] chk_order_5;
assign chk_order_5 = neighbor_index_to_var_bram_data[deg_c*log2deg_v-1 -: log2deg_v];
assign chk_order_4 = neighbor_index_to_var_bram_data[(deg_c-1)*log2deg_v-1 -: log2deg_v];
assign chk_order_3 = neighbor_index_to_var_bram_data[(deg_c-2)*log2deg_v-1 -: log2deg_v];
assign chk_order_2 = neighbor_index_to_var_bram_data[(deg_c-3)*log2deg_v-1 -: log2deg_v];
assign chk_order_1 = neighbor_index_to_var_bram_data[(deg_c-4)*log2deg_v-1 -: log2deg_v];
assign chk_order_0 = neighbor_index_to_var_bram_data[(deg_c-5)*log2deg_v-1 -: log2deg_v];

reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_0;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_1;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_2;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_3;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_4;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_5;

wire [INT+FRAC-1:0] vn_cn_msgs_0_5;
wire [INT+FRAC-1:0] vn_cn_msgs_0_4;
wire [INT+FRAC-1:0] vn_cn_msgs_0_3;
wire [INT+FRAC-1:0] vn_cn_msgs_0_2;
wire [INT+FRAC-1:0] vn_cn_msgs_0_1;
wire [INT+FRAC-1:0] vn_cn_msgs_0_0;
assign vn_cn_msgs_0_5 = vn_msgs_to_chk_neighbors_5[chk_order_5*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_4 = vn_msgs_to_chk_neighbors_4[chk_order_4*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_3 = vn_msgs_to_chk_neighbors_3[chk_order_3*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_2 = vn_msgs_to_chk_neighbors_2[chk_order_2*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_1 = vn_msgs_to_chk_neighbors_1[chk_order_1*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_0 = vn_msgs_to_chk_neighbors_0[chk_order_0*(INT+FRAC)-1 -: (INT+FRAC)];

wire [INT+FRAC-1:0] cn_vn_msgs_0_0;
wire [INT+FRAC-1:0] cn_vn_msgs_0_1;
wire [INT+FRAC-1:0] cn_vn_msgs_0_2;
wire [INT+FRAC-1:0] cn_vn_msgs_0_3;
wire [INT+FRAC-1:0] cn_vn_msgs_0_4;
wire [INT+FRAC-1:0] cn_vn_msgs_0_5;

cn cn_0_inst (
	.msg_in_1(vn_cn_msgs_0_0),
	.msg_in_2(vn_cn_msgs_0_1),
	.msg_in_3(vn_cn_msgs_0_2),
	.msg_in_4(vn_cn_msgs_0_3),
	.msg_in_5(vn_cn_msgs_0_4),
	.msg_in_6(vn_cn_msgs_0_5),
	.msg_out_1(cn_vn_msgs_0_0),
	.msg_out_2(cn_vn_msgs_0_1),
	.msg_out_3(cn_vn_msgs_0_2),
	.msg_out_4(cn_vn_msgs_0_3),
	.msg_out_5(cn_vn_msgs_0_4),
	.msg_out_6(cn_vn_msgs_0_5)
	);


wire [log2m-1:0] vn_neighbor_0;
wire [log2m-1:0] vn_neighbor_1;
wire [log2m-1:0] vn_neighbor_2;
assign vn_neighbor_2 = v_neighbor_bram_data[deg_v*log2m-1 -: log2m];
assign vn_neighbor_1 = v_neighbor_bram_data[(deg_v-1)*log2m-1 -: log2m];
assign vn_neighbor_0 = v_neighbor_bram_data[(deg_v-2)*log2m-1 -: log2m];

wire [log2deg_c-1:0] vn_order_0;
wire [log2deg_c-1:0] vn_order_1;
wire [log2deg_c-1:0] vn_order_2;
assign vn_order_2 = neighbor_index_to_ch_bram_data[deg_v*log2deg_c-1 -: log2deg_c];
assign vn_order_1 = neighbor_index_to_ch_bram_data[(deg_v-1)*log2deg_c-1 -: log2deg_c];
assign vn_order_0 = neighbor_index_to_ch_bram_data[(deg_v-2)*log2deg_c-1 -: log2deg_c];

reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_0;
reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_1;
reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_2;

wire [INT+FRAC-1:0] cn_vn_msgs_2;
wire [INT+FRAC-1:0] cn_vn_msgs_1;
wire [INT+FRAC-1:0] cn_vn_msgs_0;
assign cn_vn_msgs_2 = cn_msgs_to_vn_neighbors_2[vn_order_2*(INT+FRAC)-1 -: (INT+FRAC)];
assign cn_vn_msgs_1 = cn_msgs_to_vn_neighbors_1[vn_order_1*(INT+FRAC)-1 -: (INT+FRAC)];
assign cn_vn_msgs_0 = cn_msgs_to_vn_neighbors_0[vn_order_0*(INT+FRAC)-1 -: (INT+FRAC)];

wire [INT+FRAC-1:0] vn_out_1;
wire [INT+FRAC-1:0] vn_out_2;
wire [INT+FRAC-1:0] vn_out_3;
wire [INT+FRAC-1:0] belief_out;

vr vn_0_inst (
	.LLR(LLR_in),
	.ch_msg_0(cn_vn_msgs_0),
	.ch_msg_1(cn_vn_msgs_1),
	.ch_msg_2(cn_vn_msgs_2),
	.vr_msg_0(vn_out_1),
	.vr_msg_1(vn_out_2),
	.vr_msg_2(vn_out_3),
	.belief(belief_out)
	);


always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		c_neighbor_bram_addr <= 0;
		iter_num <= 0;

		success_dec <= 0;
		dec_cw <= data;
		non_zero_syn <= 0;
		
		// Make syn_res = 0 the clock cycle after rst is deasserted
		bit_5_in <= 0;
		bit_4_in <= 0;
		bit_3_in <= 0;
		bit_2_in <= 0;
		bit_1_in <= 0;
		bit_0_in <= 0;

		nop <= 1;
	end

	else if (FSM == 0) begin
		if(c_neighbor_bram_addr >= m) begin
			if(syn_res) begin
				FSM <= 1;
				v_msg_wr <= 1;
				v_msg_addr <= 0;
			end else begin
				FSM <= 4;
			end
		end

		else begin
			bit_5_in <= dec_cw[chk_neighbor_5];
			bit_4_in <= dec_cw[chk_neighbor_4];
			bit_3_in <= dec_cw[chk_neighbor_3];
			bit_2_in <= dec_cw[chk_neighbor_2];
			bit_1_in <= dec_cw[chk_neighbor_1];
			bit_0_in <= dec_cw[chk_neighbor_0];

			if(syn_res) begin
				FSM <= 1;
			end
		end

		c_neighbor_bram_addr <= c_neighbor_bram_addr + 1;
	end

	else if (FSM == 1) begin
		if(v_msg_addr >= n) begin
			bit_5_in <= 0;
			bit_4_in <= 0;
			bit_3_in <= 0;
			bit_2_in <= 0;
			bit_1_in <= 0;
			bit_0_in <= 0;

			c_msg_addr <= 0;
			c_neighbor_bram_addr <= 0;
			neighbor_index_to_var_bram_addr <= 0;
			c_msg_wr <= 1;
			v_msg_wr <= 0;

			vn_msgs_to_chk_neighbors_0 <= v_msg[chk_neighbor_0];
			vn_msgs_to_chk_neighbors_1 <= v_msg[chk_neighbor_1];
			vn_msgs_to_chk_neighbors_2 <= v_msg[chk_neighbor_2];
			vn_msgs_to_chk_neighbors_3 <= v_msg[chk_neighbor_3];
			vn_msgs_to_chk_neighbors_4 <= v_msg[chk_neighbor_4];
			vn_msgs_to_chk_neighbors_5 <= v_msg[chk_neighbor_5];
			if(nop) begin
				nop <= 0;

				single_chk_neighbors_indices <= c_neighbor[1];
				single_chk_order_indices <= neighbor_index_to_var[1];
			end else begin
				FSM <= 2;
				check_iter <= 1;
				nop <= 1;

				c_msg_data_in <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				single_chk_neighbors_indices <= c_neighbor[2];
				single_chk_order_indices <= neighbor_index_to_var[2];
			end

			vn_msgs_to_chk_neighbors_0 <= v_msg[chk_neighbor_0];
			vn_msgs_to_chk_neighbors_1 <= v_msg[chk_neighbor_1];
			vn_msgs_to_chk_neighbors_2 <= v_msg[chk_neighbor_2];
			vn_msgs_to_chk_neighbors_3 <= v_msg[chk_neighbor_3];
			vn_msgs_to_chk_neighbors_4 <= v_msg[chk_neighbor_4];
			vn_msgs_to_chk_neighbors_5 <= v_msg[chk_neighbor_5];

			bit_5_in <= dec_cw[chk_neighbor_5];
			bit_4_in <= dec_cw[chk_neighbor_4];
			bit_3_in <= dec_cw[chk_neighbor_3];
			bit_2_in <= dec_cw[chk_neighbor_2];
			bit_1_in <= dec_cw[chk_neighbor_1];
			bit_0_in <= dec_cw[chk_neighbor_0];
		end else begin
			v_msg_data_in <= {deg_v{LLR_in}};
		end

		v_msg_addr <= v_msg_addr + 1;
	end

	else if (FSM == 2) begin
		if(check_iter >= m) begin
			if(nop) begin
				nop <= 0;

				if(~non_zero_syn) begin
					FSM <= 4;
				end

				single_vn_neighbors_indices <= v_neighbor[1];
				single_vn_order_indices <= neighbor_index_to_ch[1];
			end else begin
				if(iter_num < max_iter) begin
					FSM <= 3;
					data_iter <= 1;
					nop <= 1;

					iter_num <= iter_num + 1;
				end
				v_msg[0] <= {vn_out_3,vn_out_2,vn_out_1};
				dec_cw[0] <= ~belief_out[INT+FRAC-1];

				single_vn_neighbors_indices <= v_neighbor[2];
				single_vn_order_indices <= neighbor_index_to_ch[2];
			end

			cn_msgs_to_vn_neighbors_0 <= c_msg[vn_neighbor_0];
			cn_msgs_to_vn_neighbors_1 <= c_msg[vn_neighbor_1];
			cn_msgs_to_vn_neighbors_2 <= c_msg[vn_neighbor_2];
		end else begin
			c_msg[check_iter] <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};

			if(syn_res) begin
				non_zero_syn <= 1;
			end

			single_vn_neighbors_indices <= v_neighbor[0];
			single_vn_order_indices <= neighbor_index_to_ch[0];
		end

		single_chk_neighbors_indices <= c_neighbor[check_iter+2];
		single_chk_order_indices <= neighbor_index_to_var[check_iter+2];

		vn_msgs_to_chk_neighbors_0 <= v_msg[chk_neighbor_0];
		vn_msgs_to_chk_neighbors_1 <= v_msg[chk_neighbor_1];
		vn_msgs_to_chk_neighbors_2 <= v_msg[chk_neighbor_2];
		vn_msgs_to_chk_neighbors_3 <= v_msg[chk_neighbor_3];
		vn_msgs_to_chk_neighbors_4 <= v_msg[chk_neighbor_4];
		vn_msgs_to_chk_neighbors_5 <= v_msg[chk_neighbor_5];

		bit_5_in <= dec_cw[chk_neighbor_5];
		bit_4_in <= dec_cw[chk_neighbor_4];
		bit_3_in <= dec_cw[chk_neighbor_3];
		bit_2_in <= dec_cw[chk_neighbor_2];
		bit_1_in <= dec_cw[chk_neighbor_1];
		bit_0_in <= dec_cw[chk_neighbor_0];

		check_iter <= check_iter + 1;
	end

	else if (FSM == 3) begin
		if(data_iter >= n) begin
			if(nop) begin
				nop <= 0;

				single_chk_neighbors_indices <= c_neighbor[1];
				single_chk_order_indices <= neighbor_index_to_var[1];
			end else begin
				FSM <= 2;
				check_iter <= 1;
				nop <= 1;

				c_msg[0] <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				single_chk_neighbors_indices <= c_neighbor[2];
				single_chk_order_indices <= neighbor_index_to_var[2];
			end

			vn_msgs_to_chk_neighbors_0 <= v_msg[chk_neighbor_0];
			vn_msgs_to_chk_neighbors_1 <= v_msg[chk_neighbor_1];
			vn_msgs_to_chk_neighbors_2 <= v_msg[chk_neighbor_2];
			vn_msgs_to_chk_neighbors_3 <= v_msg[chk_neighbor_3];
			vn_msgs_to_chk_neighbors_4 <= v_msg[chk_neighbor_4];
			vn_msgs_to_chk_neighbors_5 <= v_msg[chk_neighbor_5];

			bit_5_in <= dec_cw[chk_neighbor_5];
			bit_4_in <= dec_cw[chk_neighbor_4];
			bit_3_in <= dec_cw[chk_neighbor_3];
			bit_2_in <= dec_cw[chk_neighbor_2];
			bit_1_in <= dec_cw[chk_neighbor_1];
			bit_0_in <= dec_cw[chk_neighbor_0];
		end else begin
			v_msg[data_iter] <= {vn_out_3,vn_out_2,vn_out_1};
			dec_cw[data_iter] <= ~belief_out[INT+FRAC-1];

			single_chk_neighbors_indices <= c_neighbor[0];
			single_chk_order_indices <= neighbor_index_to_var[0];
		end

		single_vn_neighbors_indices <= v_neighbor[data_iter+2];
		single_vn_order_indices <= neighbor_index_to_ch[data_iter+2];

		cn_msgs_to_vn_neighbors_0 <= c_msg[vn_neighbor_0];
		cn_msgs_to_vn_neighbors_1 <= c_msg[vn_neighbor_1];
		cn_msgs_to_vn_neighbors_2 <= c_msg[vn_neighbor_2];

		data_iter <= data_iter + 1;
	end

	else if (FSM == 4) begin
		success_dec <= 1;
	end
end

endmodule
