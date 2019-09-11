`timescale 1ns / 1ps

module top(
	input clk,
	input rst,
	input[7:0] binaryinput, 
	output reg [3:0] led_anode, //Active high
	output reg [6:0] led_cathode //Active low
    );

//Converts input into digit on 7-segment led display
function[6:0] display_digit(input[3:0] num);
	case(num)
		4'd1: display_digit = 7'b1111001;
		4'd2: display_digit = 7'b0100100;
		4'd3: display_digit = 7'b0110000;
		4'd4: display_digit = 7'b0011001;
		4'd5: display_digit = 7'b0010010;
		4'd6: display_digit = 7'b0000010;
		4'd7: display_digit = 7'b1111000;
		4'd8: display_digit = 7'b0000000;
		4'd9: display_digit = 7'b0010000;
		default: display_digit = 7'b1000000;
	endcase
endfunction

wire clock_60Hz;
wire[3:0] dgt1, dgt2, dgt3;
wire[3:0] dgt4 = 4'b0000;

//Generate 60Hz Clock
slowclock clk1(
	.clk(clk),
	.rst(rst),
	.clk_out(clock_60Hz)
    );
	
//Generate BinarytoBCD
binary_to_BCD bintoBCD(
	.clock(clk),
	.bitvalue(binaryinput),
	.ones(dgt1),
	.tens(dgt2),
	.hundreds(dgt3)
	);

//Multiplexing
reg[1:0] i = 0;
always @(posedge clk) begin
   if (rst) begin
		i[1:0] <= 0;
		end
	else if (clock_60Hz) begin
		i <= i+1;
		case(i)
			//Light the ones digit
			0: begin
				led_anode[3:0] <= 4'b1110;
				led_cathode[6:0] <= display_digit(dgt1);
			end
			//Light the tens digit
			1: begin
				led_anode[3:0] <= 4'b1101;
				led_cathode[6:0] <= display_digit(dgt2);
			end
			//Light the hundreds digit
			2: begin
				led_anode[3:0] <= 4'b1011;
				led_cathode[6:0] <= display_digit(dgt3);
			end
			//Light the thousands digit
			3: begin
				led_anode[3:0] <= 4'b0111;
				led_cathode[6:0] <= display_digit(dgt4);
			end
		endcase
	end
end
	
endmodule
