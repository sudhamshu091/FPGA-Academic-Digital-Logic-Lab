module part3 (CLOCK_50, HEX0);
  input CLOCK_50;
  output [6:0] HEX0;

  wire [25:0] X;
  wire [3:0] Q2;
  reg Clr, Clr2;

  counter_26bit C0 (CLOCK_50, Clr, X);
  counter_4bit DISPLAY (Clr, Clr2, Q2);

  always @ (posedge CLOCK_50) begin
  Clr = (X[25]&X[24]&X[23]&X[22]&X[21]&X[20]&X[19]&X[18]&X[17]&X[16]&X[15]&X[14]&X[13]&X[12]&X[11]&X[10]&X[9]&X[8]&X[7]&X[6]&X[5]&X[4]&X[3]&X[2]&X[1]&X[0]);
  end

  always @ (posedge Clr) begin
    Clr2 = (X[3]&~X[2]&~X[1]&X[0]);
  end

  b2d_ssd H0 (Q2[3:0], HEX0);
endmodule

module counter_26bit(clk, en, Q);
input clk,en;
output [25:0] Q;
reg [25:0] Qs;

always @(posedge clk)
begin
if(en)
 Qs = 0;
else if(~en)
 Qs = Qs + 1;
else
 Qs = 1;
end
assign Q = Qs;
endmodule

module counter_4bit(clk, en, Q);
input clk,en;
output [3:0] Q;
reg [3:0] Qs;

always @(posedge clk)
begin
if(en)
 Qs = 0;
else if (~en)
 Qs = Qs + 1;
else
 Qs = 1;
end
assign Q = Qs;
endmodule

module b2d_ssd (X, SSD);
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
