module data_iter_counter #(parameter log2n = 4, parameter n = 12, parameter n_minus_one = 11)(
input clk,
input rst,
output [log2n-1:0] data_iter_count,
output [2:0] state
);

reg [log2n-1:0] data_iter;
assign data_iter_count = data_iter;
reg [2:0] output_state;
assign state = output_state;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		output_state <= 1;
		data_iter <= 0;
	end
	else begin
		if(data_iter == n_minus_one) begin
			output_state <= 2;
		end
		
		if(data_iter == n_plus_one) begin
			output_state <= 4;
		end

		data_iter <= data_iter + 1;
	end
end

endmodule
