`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:55 06/17/2021 
// Design Name: 
// Module Name:    tb_uP_instmem 
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
module tb_uP_instmem();
	
	reg [15:0] inst_mem [0:61];
	initial $readmemb("test.mem", inst_mem);
	
	reg clk;
	initial clk = 0;
	
	reg [15:0]	INSTRUCTIONS;
	wire [15:0] PCnext;
	
	uP DUT (INSTRUCTIONS, clk, PCnext);
	always # 5 clk = ~clk;
	always @(posedge clk)
		INSTRUCTIONS <= inst_mem[PCnext];
	
	initial begin
		$dumpfile("test_up_instmem.vcd");
		$dumpvars();
		#500 $finish;
	end


endmodule
