module decoder#(parameter n = 204, parameter m = 102, parameter log2n = 8, parameter log2m = 7, parameter max_iter = 30, parameter log2max_iter = 5,
				parameter INT = 8, parameter FRAC = 8, parameter deg_v = 3, parameter dev_c = 6)(
	input clk,
	input rst,
	output success
	);

reg [n*deg_v*log2m-1:0] v_neighbor;
reg [m*deg_c*log2n-1:0] c_neighbor;
reg [n*(INT+FRAC)-1:0] v_msg;
reg [m*(INT+FRAC)-1:0] c_msg;
reg [INT+FRAC-1:0] LLR;
reg [n*(INT+FRAC)-1:0] LLRs;

reg [n-1:0] data;
reg [1:0] FSM;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
reg [log2n-1:0] data_iter;
reg [log2m-1:0] check_iter;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		success_dec <= 0;
		data_iter <= 0;
		check_iter <= 0;
		iter_num <= 0;
	end
	else if (FSM == 0) begin
		LLRs[data_iter*(INT+FRAC)-1:(data_iter-1)*(INT+FRAC)] <= data[data_iter]*LLR;
		v_msg[data_iter*(INT+FRAC)-1:(data_iter-1)*(INT+FRAC)] <= data[data_iter]*LLR;
		data_iter <= data_iter + 1;
		if(data_iter == 203)begin
			data_iter <= 0;
			FSM <= 1;
		end
	end
	else if (FSM == 1) begin
		
		check_iter <= check_iter + 1;
		if (iter_num < max_iter) begin
			if(check_iter == 101)begin
			check_iter <= 0;
			FSM <= 2;
			end
		end
	end
end

endmodule
