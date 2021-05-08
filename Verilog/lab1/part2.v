module part2 (SW, LEDG);
	input [9:0]SW;
	output [3:0]LEDG;
	assign LEDG[3:0] = (~SW[9] & SW[3:0]) | (SW[9] & SW[7:4]);
endmodule
