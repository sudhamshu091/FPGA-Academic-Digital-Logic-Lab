// To run this on desim make change in line 69.
// Keep KEY[0] and KEY[1] in 0, change KEY[0] to 1 and then 0, change KEY[1] to 1, counter will start counting.
module part2(CLOCK_50,KEY,HEX2,HEX1,HEX0);
input [1:0] KEY;
input CLOCK_50;
output [6:0] HEX2,HEX1,HEX0;

wire [0:0]cout;
wire [9:0] Q;
wire [11:0]bcd;


counter_clock C0(CLOCK_50, KEY[0], cout);

counter_modk C1(cout[0], KEY[1], Q);

bin2bcd B0(Q[9:0],bcd);

b2d_7seg H0(bcd[3:0],HEX0);
b2d_7seg H1(bcd[7:4],HEX1);
b2d_7seg H2(bcd[11:8],HEX2);

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


module bin2bcd(binary,bcd);
    parameter n = 10;
    input [n-1:0] binary;
    output reg [(n-1)+(n-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= (n-1)+(n-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[n-1:0] = binary;
    for(i = 0; i <= n-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[n-i+4*j -: 4] > 4)
          bcd[n-i+4*j -: 4] = bcd[n-i+4*j -: 4] + 4'd3;
  end
endmodule


module counter_clock(clock, reset, cout);
    input clock, reset;
    output  cout;

    reg [24:0] count;
    reg  cout;


    always @ (posedge clock)
    begin
       if (~reset) begin
           if(count== 50000000) begin // for desim keep the count 5000
              count = 0;
              cout = cout + 1;
           end else begin
              count = count + 1;
              cout = cout;
           end
       end else begin
          count =0;
          cout = 0;
       end
    end
endmodule

module counter_modk(clock, reset, Q);
  parameter n = 10;
  parameter k = 1000;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock)
  begin
    if (~reset)
      Q = 0;
    else begin
      Q = Q + 1;
      if (Q == k-1)
        Q = 0;
    end
  end
endmodule
