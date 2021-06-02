module part3 (SW, LEDR);
	input [9:0]SW;
	output [1:0]LEDR;
	assign LEDR[1:0] = SW[9]? (SW[8]? SW[7:6] : SW[5:4]) : (SW[8] ? SW[3:2] : SW[1:0]);
endmodule
