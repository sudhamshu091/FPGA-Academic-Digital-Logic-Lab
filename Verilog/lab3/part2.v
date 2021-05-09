module part2 (SW, LEDR);  // remove this module for quartus prime use
  input [1:0] SW;
  output [0:0] LEDR;

  wire Q;

  ff  ff0(SW[0], SW[1], LEDR[0]);
endmodule

module ff (Clk, D, Q);    
  input Clk, D;
  output Q;

  wire S, R;

  assign S = D;
  assign R = ~D;

  wire R_g, S_g, Qa, Qb /* synthesis keep */;

  assign R_g = R & Clk;
  assign S_g = S & Clk;
  assign Qa = ~(R_g | Qb);
  assign Qb = ~(S_g | Qa);
  assign Q = Qa;
endmodule
