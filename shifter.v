module Shifter16Bit(
    input wire[15:0] in,
    input wire[4:0] count,
    output reg[15:0] out
    );
	 

always @(*) begin
	 case(count[4])
	 1'b0:
	 begin
		out <= in << count;
	 end
	 1'b1:
	 begin
		out <= in >> (~count + 5'b1);
	 end
	 endcase
end 


endmodule