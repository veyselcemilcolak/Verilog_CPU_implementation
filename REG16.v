
`timescale 1ns / 1ps
//16 bit register using 1-bit cells
module REG16(
	output wire [15:0] dout,
	input wire [15:0] din,
	input wire en,clk	
    );

	generate
	genvar i;
	for(i=0; i<16; i=i+1) begin: rgstr
		DFF df (dout[i], din[i], en, clk);
	end
	endgenerate

endmodule
