module part2 (SW, LEDG);
	input [17:0]SW;
	output [7:0]LEDG;
	assign LEDG[7:0] = (~SW[17] & SW[7:0]) | (SW[17] & SW[15:8]);
endmodule
