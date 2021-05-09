module part1 (SW, KEY, LEDR,HEX1, HEX0);
  input [1:0] SW;
  input [0:0] KEY;
  output [6:0] HEX1, HEX0;
  output [3:0] LEDR;

  wire [7:0] Q;
  wire [3:0] R;

  counter_8bit C0 (SW[1], KEY[0], SW[0], Q);
  counter_4bit C1 (SW[1], KEY[0], SW[0], R);

  assign LEDR = R;

  hex_ssd H0 (Q[3:0], HEX0);
  hex_ssd H1 (Q[7:4], HEX1);

endmodule

module counter_8bit (En, Clk, Clr, Q);
  input En, Clk, Clr;
  output [7:0] Q;

  wire [7:0] T, Qs;

  t_flipflop T0 (En, Clk, Clr, Qs[0]);
  assign T[0] = En & Qs[0];

  t_flipflop T1 (T[0], Clk, Clr, Qs[1]);
  assign T[1] = T[0] & Qs[1];

  t_flipflop T2 (T[1], Clk, Clr, Qs[2]);
  assign T[2] = T[1] & Qs[2];

  t_flipflop T3 (T[2], Clk, Clr, Qs[3]);
  assign T[3] = T[2] & Qs[3];

  t_flipflop T4 (T[3], Clk, Clr, Qs[4]);
  assign T[4] = T[3] & Qs[4];

  t_flipflop T5 (T[4], Clk, Clr, Qs[5]);
  assign T[5] = T[4] & Qs[5];

  t_flipflop T6 (T[5], Clk, Clr, Qs[6]);
  assign T[6] = T[5] & Qs[6];

  t_flipflop T7 (T[6], Clk, Clr, Qs[7]);
  assign T[7] = T[6] & Qs[7];

  assign Q[7:0] = Qs[7:0];
endmodule

module t_flipflop (En, Clk, Clr, Q);
  input En, Clk, Clr;
  output reg Q;

  always @ (posedge Clk)
    if (Clr)
      Q = 0;
    else if (En)
      Q = ~Q;

endmodule

module hex_ssd (X, SSD);
  input [3:0] X;
  output [6:0] SSD;

  assign SSD[0] = (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
  assign SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[4] = (X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & X[2] & X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & ~X[1] & X[0]);
  assign SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]);
  assign SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & X[0]);
endmodule


module counter_4bit (En, Clk, Clr, Q);
  input En, Clk, Clr;
  output [3:0] Q;

  wire [3:0] T, Qs;

  t_flipflop T0 (En, Clk, Clr, Qs[0]);
  assign T[0] = En & Qs[0];

  t_flipflop T1 (T[0], Clk, Clr, Qs[1]);
  assign T[1] = T[0] & Qs[1];

  t_flipflop T2 (T[1], Clk, Clr, Qs[2]);
  assign T[2] = T[1] & Qs[2];

  t_flipflop T3 (T[2], Clk, Clr, Qs[3]);
  assign T[3] = T[2] & Qs[3];

  assign Q[3:0] = Qs[3:0];
endmodule

