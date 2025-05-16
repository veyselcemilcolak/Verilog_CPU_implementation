`timescale 1ns / 1ps

module PROGRAM_COUNTER(
    input RESET,
    input i_branch,
    input i_jumpCond,
    input i_jal,
    input [15:0] I_COUNT,
	 input [7:0] disp,
    input clk,
    output reg [15:0] O_COUNT =16'b0,
	 output reg [15:0] rfPC_in 
    );


wire [15:0] ext_disp;
assign ext_disp = {{8{disp[7]}}, disp};

wire [3:0] flags;
assign flags = {RESET, i_branch, i_jumpCond, i_jal };

reg[15:0] alu_in1;
reg[15:0] alu_in2;
wire[15:0] alu_out;



	always @(*) begin
		case (flags)
		4'b1000: begin
			rfPC_in=0;
			alu_in1 = 0;
			alu_in2 = 0;
		end
		4'b0100: begin
			rfPC_in=0;
			alu_in1 = O_COUNT;
			alu_in2 = ext_disp;
		end
		4'b0010: begin
			rfPC_in=0;
			alu_in1 = I_COUNT;
			alu_in2 = 0;
		end
		4'b0001: begin
			rfPC_in=O_COUNT+1;
			alu_in1 = I_COUNT;
			alu_in2 = 0;
		end
		default: begin
			rfPC_in=0;
			alu_in1 = O_COUNT;
			alu_in2 = 16'b1;
		end
	endcase
			
	end


	BLOCK_ALU16 ALU0 (.I_a(alu_in1), .I_b(alu_in2), .I_sel(4'd4), .clk(clk), .O_s(alu_out));



always @(posedge(clk)) begin

		O_COUNT<=alu_out;


end


endmodule
