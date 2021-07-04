module part6(SW,HEX0,HEX1);
input [5:0] SW;
output [6:0] HEX0,HEX1;
 
wire [6:0] bcd;
wire [7:0] bcd1;
assign bcd1[7:0] = {0,bcd};

bin2bcd B0(SW[5:0],bcd);
b2d_7seg H0(bcd[3:0],HEX0);
b2d_7seg H1(bcd1[7:4],HEX1);
 
endmodule

module bin2bcd(binary,bcd);
    parameter n = 6;
    input [n-1:0] binary;
    output reg [n+(n-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= n+(n-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[n-1:0] = binary;
    for(i = 0; i <= n-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[n-i+4*j -: 4] > 4)
          bcd[n-i+4*j -: 4] = bcd[n-i+4*j -: 4] + 4'd3;
  end
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
