module check_iter_counter #(parameter log2m = 3, parameter m = 6, parameter m_minus_one = 5)(
input clk,
input rst,
output [log2m-1:0] check_iter_count,
output [1:0] state
);

reg [log2m-1:0] check_iter;
assign check_iter_count = check_iter;
reg [1:0] output_state;
assign state = output_state;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		output_state <= 1;
		check_iter <= 1;
	end
	else begin
		if(check_iter == m_minus_one) begin
			output_state <= 2;
		end

		check_iter <= check_iter + 1;
	end
end

endmodule
