`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Engineer:        Mohammed Al Ai Baky
// 
// Create Date:    12:46:24 02/25/2017 
// Design Name:     NV Controller
// Module Name:    clk_div_gen 
// Project Name:    NV Controller
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   ISE 14.6
// Description:     Clock Divider
//
// Dependencies: 
//
// Revision: 
// Revision 0.2
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
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
