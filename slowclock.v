`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:46:54 08/19/2019 
// Design Name: 
// Module Name:    slowclock 
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
