`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:32 06/17/2021 
// Design Name: 
// Module Name:    spblockram 
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
module spblockram (clk, we, a, di, dout);
  input clk;
  input we;
  input [4:0] a;
  input [15:0] di;
  output [15:0] dout;
  reg [15:0] RAM[0:31];
  reg [4:0] read_addr;
  
  always @(posedge clk) begin
		if (we == 1'b1) begin
			RAM[a] <= di;
		end
		read_addr <= a;
  end
  
  assign dout = RAM[read_addr];
endmodule

