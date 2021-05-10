module part3 (CLOCK_50, HEX0);
  input CLOCK_50;
  output [6:0] HEX0;

  wire [3:0] Q;
  wire [0:0]E;

  counter_16bit C0 (CLOCK_50, E);
  counter_4bit C1 (E[0], CLOCK_50, Q);

  b2d_7seg H0 (Q[3:0], HEX0);

endmodule

module t_flipflop (En, Clk, Q);
  input En, Clk;
  output reg Q;

  always @ (posedge Clk)
    if (En)
      Q = ~Q;

endmodule

module counter_4bit (En, Clk, Q);
  input En, Clk;
  output [3:0] Q;

  wire [3:0] T, Qs;

  t_flipflop T0 (En, Clk, Qs[0]);
  assign T[0] = En & Qs[0];

  t_flipflop T1 (T[0] ,Clk, Qs[1]);
  assign T[1] = T[0] & Qs[1];

  t_flipflop T2 (T[1], Clk, Qs[2]);
  assign T[2] = T[1] & Qs[2];

  t_flipflop T3 (T[2], Clk, Qs[3]);
  assign T[3] = T[2] & Qs[3];

  assign Q[3:0] = Qs[3:0];
endmodule

module counter_16bit(Clk, E);
input Clk;
output E;

reg [15:0] Qs;

always @(posedge Clk)
begin
 Qs = Qs + 16'd1;
end
assign E = ~(Qs[15]|Qs[14]|Qs[13]|Qs[12]|Qs[11]|Qs[10]|Qs[9]|Qs[8]|Qs[7]|Qs[6]|Qs[5]|Qs[4]|Qs[3]|Qs[2]|Qs[1]|Qs[0]);
endmodule

module b2d_7seg (X, SSD);
  input [3:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
         assign SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]);
         assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]);
         assign SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]);
         assign SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
         assign SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]);
         assign SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]);

endmodule

