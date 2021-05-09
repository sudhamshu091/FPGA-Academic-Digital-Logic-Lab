module part3 (SW, LEDR);
  input [1:0] SW;
  output [0:0] LEDR;

  wire Q;

  ff1 F0 (SW[1], SW[0], LEDR[0]);
endmodule

module ff (Clk, D, Q);
  input Clk, D;
  output Q;

  wire S, R;

  assign S = D;
  assign R = ~D;

  wire R_g, S_g, Qa, Qb;

  assign R_g = R & Clk;
  assign S_g = S & Clk;
  assign Qa = ~(R_g | Qb);
  assign Qb = ~(S_g | Qa);

  assign Q = Qa;
endmodule

module ff1 (Clk, D, Q);
  input Clk, D;
  output Q;

  wire Qm, Qn /* synthesis keep */ ;
  ff D0 (~Clk, D, Qm);
  ff D1 (Clk, Qm, Qn);

  assign Q = Qn;
endmodule
