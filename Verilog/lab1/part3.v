module part3 (SW, LEDG);
	input [17:0]SW;
	output [7:0]LEDG;
	assign LEDG[2:0] = (~SW[17] & ~SW[16] & ~SW[15] & SW[2:0]) | (~SW[17] & ~SW[16] & SW[15] & SW[5:3]) | (~SW[17] & SW[16] & ~SW[15] & SW[8:6]) | (~SW[17] & SW[16] & SW[15] & SW[11:9]) | (SW[17] & SW[16] & SW[15] & SW[14:12]);
endmodule
