`timescale 1ns / 1ps

module slowclock(
	input clk,
	input rst,
	output reg clk_out
    );

reg[15:0] counter;
always @(posedge clk) begin
	if(rst) begin
		clk_out <= 0;
		counter[15:0] <= 0;
	end
	else begin
		counter <= counter + 1;
		if(&counter == 1)
			clk_out <= 1;
		else
			clk_out <= 0;
	end
end

endmodule
