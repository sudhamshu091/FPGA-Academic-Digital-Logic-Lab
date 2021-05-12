module part1 (KEY, LEDR);
  input [1:0] KEY;
  output [5:0] LEDR;

wire [5:0] LEDR;

  counter_modk C1 (KEY[1], KEY[0], LEDR[4:0]);
  defparam C1.n = 5;
  defparam C1.k = 20;

rollover R1 (KEY[1], (LEDR[4]&~LEDR[3]&~LEDR[2]&LEDR[1]&LEDR[0]), LEDR[5]);


endmodule

module counter_modk(clock, reset, Q);
  parameter n;
  parameter k;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock or negedge reset)
  begin
    if (~reset)
      Q <= 1'd0;
    else begin
      Q <= Q + 1'b1;
      if (Q == k-1)
        Q <= 1'd0;
    end
  end
endmodule

module rollover(clock, reset, Q);
  parameter n = 1;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock)
  begin
    if (~reset)
      Q <= 1'd0;
    else
      Q <= Q + 1'b1;
  end
endmodule
 
