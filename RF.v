`timescale 1ns / 1ps
//register file
module RF(
	output wire [15:0] data_a, data_b,
	input wire [3:0]ra, [3:0]rb, [3:0]rw, 
	input wire wr_en, [15:0] data_in,
	input wire clk
    );
	wire [15:0] data_int [0:15];
	reg [15:0] en_int;
	
	//registers 16x16
	generate
	genvar i;
		for(i=0; i<16; i=i+1) begin: rg
			REG16 rg16 (data_int[i], data_in, en_int[i], clk);
		end
	endgenerate
	
	//write enable logic
	always @(rw, wr_en) begin
		en_int = 0;
		en_int[rw] = wr_en;
	end
	
	//output logic
	assign data_a = data_int[ra];
	assign data_b = data_int[rb];
		

endmodule
