`timescale 1ns / 1ps

module binary_to_BCD(
	input clock,
	input[7:0] bitvalue,
	output reg [3:0] ones,
	output reg [3:0] tens,
	output reg [3:0] hundreds
    );

reg [3:0] i = 0;
reg [19:0] shift_register = 0;

//temp registers
reg [3:0] temp_ones = 0;
reg [3:0] temp_tens = 0;
reg [3:0] temp_hundreds = 0;
reg [7:0] old_bit_value = 0;

always @(posedge clock) begin
	if (i == 0 && old_bit_value != bitvalue) begin
		temp_hundreds = 0;
		temp_tens = 0;
		temp_ones = 0;
		old_bit_value = bitvalue;
		shift_register = {temp_hundreds, temp_tens, temp_ones, bitvalue};
		i = i+1;
	end
	if(i > 0 && i <= 8) begin
		if(temp_ones >= 5)
			temp_ones = temp_ones + 3;
		if (temp_tens >= 5)
			temp_tens = temp_tens + 3;
		if (temp_hundreds >= 5)
			temp_hundreds = temp_hundreds + 3;
		shift_register[19:8] = {temp_hundreds, temp_tens, temp_ones};
		shift_register = shift_register << 1;
		temp_hundreds = shift_register[19:16];
		temp_tens = shift_register[15:12];
		temp_ones = shift_register[11:8];
		i = i + 1;
	end
	if(i > 8) begin
		i = 0;
		ones = temp_ones;
		tens = temp_tens;
		hundreds = temp_hundreds;
	end
end
		
endmodule
