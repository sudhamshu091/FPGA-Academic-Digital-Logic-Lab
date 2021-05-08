module part3 (SW, LEDR);
  input [8:0] SW;
  output [4:0] LEDR;

  wire c1, c2, c3;

  fulladder A0 (SW[0], SW[4], SW[8], LEDR[0], c1);
  fulladder A1 (SW[1], SW[5], c1, LEDR[1], c2);
  fulladder A2 (SW[2], SW[6], c2, LEDR[2], c3);
  fulladder A3 (SW[3], SW[7], c3, LEDR[3], LEDR[4]);
endmodule

module fulladder (a, b, cin, s, cout);
  input a, b, cin;
  output cout, s;
  wire d;

  assign d = a ^ b;
  assign s = d ^ cin;
  assign cout = (b & ~d) | (d & cin);
endmodule
