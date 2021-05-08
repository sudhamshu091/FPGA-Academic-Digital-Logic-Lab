module part3 (SW, LEDR);
	input [9:0]SW;
	output [1:0]LEDG;
	assign LEDG[2:0] = (~SW[9] & ~SW[8] & SW[1:0]) | (~SW[9] & SW[8] & SW[3:2]) | (SW[9] & ~SW[8] & SW[5:4]) | (SW[9] & SW[8] & SW[7:6]);
endmodule
