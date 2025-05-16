`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:36:53 06/17/2021 
// Design Name: 
// Module Name:    uP 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uP(
	input[15:0]	INSTRUCTIONS,
	input clk,
	output[15:0] PCnext
    );

wire we;
wire [15:0] data_mem_out;
wire [15:0] data_mem_in;
wire [4:0] addr;

spblockram DATA_MEM (.clk(clk), .we(we), .a(addr), .di(data_mem_in), .dout(data_mem_out));

CPU_RTL CPU0(.INSTRUCTIONS(INSTRUCTIONS),.clk(clk),.data_mem_out(data_mem_out),.PCnext(PCnext),.r_w(we),.addr(addr),.data_mem_in(data_mem_in));

endmodule
