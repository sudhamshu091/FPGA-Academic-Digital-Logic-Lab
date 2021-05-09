module part4 (SW, LEDR);
  input [1:0] SW;
  output [2:0] LEDR;

  wire Q;

  latchD L0 (SW[1], SW[0], LEDR[0]);
  ff F0 (SW[1], SW[0], LEDR[1]);
  ff F1 (~SW[1], SW[0], LEDR[2]);
endmodule

module latchD (Clk, D, Q);
  input D, Clk;
  output reg Q;
  always @ (D, Clk)
    if (Clk)
      Q = D;
endmodule

module ff (Clk, D, Q);
  input Clk, D;
  output Q;

  wire Qm;
  latchD D0 (~Clk, D, Qm);
  latchD D1 (Clk, Qm, Q);
endmodule
