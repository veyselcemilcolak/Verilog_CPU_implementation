`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:11:03 06/17/2021 
// Design Name: 
// Module Name:    CPU_RTL 
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
module CPU_RTL(
	input[15:0]	INSTRUCTIONS,
	input clk,
	input [15:0]data_mem_out,
	output[15:0] PCnext,
	output r_w,
	output [4:0] addr,
	output [15:0]data_mem_in
    );
	 
	

    wire [15:0] PSR;
    wire [3:0] Rdest;
    wire [7:0] R2_im;
    wire ImFlag;
    wire [3:0] ALUcode;
    wire shiftFlag;
    wire mem_r;
    wire mem_w;
    wire reg_w;
	 wire comp_flag;
	 wire branch;
	 wire jal;
	 wire jcond;
	 wire s_ext;
	 wire [15:0] val1;
	 wire [15:0] val2;
	 reg [15:0] reg_write_data;
	 reg [15:0] operand2;
	 wire [15:0] alu_out;
	 wire [15:0] shift_out;
	 reg [15:0] extended_r2_im;
	 wire [15:0] rfPC_in;
	 
	 CONTROL_UNIT CU1(.INSTRUCTIONS(INSTRUCTIONS),.PSR(PSR),.clk(clk),.Rdest(Rdest),.R2_im(R2_im),
	 .ImFlag(ImFlag),.ALUcode(ALUcode),.shiftFlag(shiftFlag),.mem_r(mem_r),.mem_w(mem_w),.reg_w(reg_w), 
	 .comp_flag(comp_flag),.branch(branch),.s_ext(s_ext),.jal(jal), .jcond(jcond));
	 
	 assign r_w = mem_w;
	 assign data_mem_in =val1;
	 assign addr = val2[4:0];
	 
	 RF RF0( .data_a(val1), .data_b(val2),.ra(Rdest), .rb(R2_im[3:0]), .rw(Rdest), .wr_en(reg_w), .data_in(reg_write_data) ,.clk(clk));
	
	BLOCK_ALU16 #(.FUNCTION_BITS(4), .DATA_LENGTH (16)) 
	 ALU0(.I_a(val1),.I_b(operand2),.I_sel(ALUcode),.I_cmp(comp_flag),.clk(clk),.o_c(),.O_s(alu_out),.O_psr(PSR));		
	 
	 Shifter16Bit S0 (.in(val1),.count(operand2[4:0]),.out(shift_out));
	 
	PROGRAM_COUNTER PC1( .RESET(1'b0),.i_branch(branch),.i_jumpCond(jcond),.i_jal(jal),.I_COUNT(val2),.disp(R2_im),.clk(clk),.O_COUNT(PCnext),.rfPC_in(rfPC_in) );
	 
	 always @(*) begin
		if(s_ext) begin
			extended_r2_im = {{8{R2_im[7]}},R2_im};
		end else begin
			extended_r2_im = {8'b0,R2_im};
		end 
	 end
	 
	 
	 always @(*) begin
		if(ImFlag) begin
			operand2 = extended_r2_im;
		end else begin
			operand2 =val2;
		end 
	 end
	 
	 always @(*) begin
	 
		if(mem_r) begin
			reg_write_data = data_mem_out;
		end else if(shiftFlag) begin
			reg_write_data = shift_out;
		end else if(jal) begin	
			reg_write_data = rfPC_in;
		end else begin
			reg_write_data =alu_out;
		end
		
	end
	 
	 

endmodule
