// Some small bug, maybe w.r.t case statments, not working 
module part1 (SW, KEY, LEDR, HEX1, HEX0);
  input [9:0] SW;
  input [3:0] KEY;
  output [9:0] LEDR;
  output [6:0] HEX1, HEX0;
 
  wire [8:0] DIN, BusWires;
  wire Resetn, Clock, Run, Done;

  assign DIN = SW[8:0];
  assign Resetn = KEY[0];
  assign Clock = KEY[1];
  assign Run = SW[17];
  assign LEDR[8:0] = BusWires;
  assign LEDR[9] = Done;

  proc P0 (DIN, Resetn, Clock, Run, Done, BusWires);

  hex_ssd H0 (BusWires[3:0], HEX0);
  hex_ssd H1 (BusWires[7:4], HEX1);
endmodule

module proc (DIN, Resetn, Clock, Run, Done, BusWires);
  input [8:0] DIN;
  input Resetn, Clock, Run;
  output reg Done;
  output reg [8:0] BusWires;

  reg IRin, DINout, Ain, Gout, Gin, AddSub;
  reg [7:0] Rout, Rin;
  wire [7:0] Xreg, Yreg;
  wire [1:9] IR;
  wire [1:3] I;
  reg [9:0] MUXsel;
  wire [8:0] R0, R1, R2, R3, R4, R5, R6, R7, result;
  wire [8:0] A, G;
  wire [1:0] Tstep_Q;

  wire Clear = Done || ~Resetn;
  upcount Tstep (Clear, Clock, Tstep_Q);
  assign I = IR[1:3];
  dec3to8 decX (IR[4:6], 1'b1, Xreg);
  dec3to8 decY (IR[7:9], 1'b1, Yreg);
  always @(Tstep_Q or I or Xreg or Yreg)
  begin
    IRin = 1'b0;
    Rout[7:0] = 8'b00000000;
    Rin[7:0] = 8'b00000000;
    DINout = 1'b0;
    Ain = 1'b0;
    Gout = 1'b0;
    Gin = 1'b0;
    AddSub = 1'b0;

    Done = 1'b0;

    case (Tstep_Q)
      2'b00: // store DIN in IR in time step 0
      begin
        IRin = 1'b1; // should this be ANDed with Run?
      end
      2'b01: //define signals in time step 1
        case (I)
          3'b000:
          begin
            Rout = Yreg;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b001:
          begin
            DINout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b010:
          begin
            Rout = Xreg;
            Ain = 1'b1;
          end
          3'b011:
          begin
            Rout = Xreg;
            Ain = 1'b1;
          end
        endcase
      2'b10: //define signals in time step 2
        case (I)
          3'b010:
          begin
            Rout = Yreg;
            Gin = 1'b1;
          end
          3'b011:
          begin
            Rout = Yreg;
            Gin = 1'b1;
            AddSub = 1'b1;
          end
        endcase
      2'b11: //define signals in time step 3
        case (I)
          3'b010:
          begin
            Gout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b011:
          begin
            Gout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
        endcase
    endcase
  end

  regn reg_0 (BusWires, Rin[0], Clock, R0);
  regn reg_1 (BusWires, Rin[1], Clock, R1);
  regn reg_2 (BusWires, Rin[2], Clock, R2);
  regn reg_3 (BusWires, Rin[3], Clock, R3);
  regn reg_4 (BusWires, Rin[4], Clock, R4);
  regn reg_5 (BusWires, Rin[5], Clock, R5);
  regn reg_6 (BusWires, Rin[6], Clock, R6);
  regn reg_7 (BusWires, Rin[7], Clock, R7);

  regn reg_IR (DIN, IRin, Clock, IR);
  defparam reg_IR.n = 9;
  regn reg_A (BusWires, Ain, Clock, A);
  regn reg_G (result, Gin, Clock, G);

  addsub AS (~AddSub, A, BusWires, result);

  //define the bus
  always @ (MUXsel or Rout or Gout or DINout)
  begin
    MUXsel[9:2] = Rout;
    MUXsel[1] = Gout;
    MUXsel[0] = DINout;

    case (MUXsel)
      10'b0000000001: BusWires = DIN;
      10'b0000000010: BusWires = R0;
      10'b0000000100: BusWires = R1;
      10'b0000001000: BusWires = R2;
      10'b0000010000: BusWires = R3;
      10'b0000100000: BusWires = R4;
      10'b0001000000: BusWires = R5;
      10'b0010000000: BusWires = R6;
      10'b0100000000: BusWires = R7;
      10'b1000000000: BusWires = G;
    endcase
  end

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

module addsub (sub,a,b,o);

parameter WIDTH = 9;
parameter METHOD = 1;

input sub;
input [WIDTH-1:0] a,b;
output [WIDTH-1:0] o;

generate
  if (METHOD == 0) begin
    // generic style
    assign o = sub ? (a - b) : (a + b);
  end
  else if (METHOD == 1) begin
    // Hardware implementation with XORs in front of a
	// carry chain.
	wire [WIDTH+1:0] tmp;
	assign tmp = {1'b0,a,sub} + {sub,{WIDTH{sub}} ^ b,sub};
	assign o = tmp[WIDTH:1];
  end
endgenerate

endmodule

module regn(R, Rin, Clock, Q);
  parameter n = 9;
  input [n-1:0] R;
  input Rin, Clock;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge Clock)
    if (Rin)
      Q <= R;
endmodule


module upcount(Clear, Clock, Q);
  input Clear, Clock;
  output [1:0] Q;
  reg [1:0] Q;

  always @(posedge Clock)
    if (Clear)
      Q <= 2'b0;
    else
      Q <= Q + 1'b1;
endmodule


module dec3to8(W, En, Y);
  input [2:0] W;
  input En;
  output [0:7] Y;
  reg [0:7] Y;

  always @(W or En)
  begin
    if (En == 1)
      case (W)
        3'b000: Y = 8'b10000000;
        3'b001: Y = 8'b01000000;
        3'b010: Y = 8'b00100000;
        3'b011: Y = 8'b00010000;
        3'b100: Y = 8'b00001000;
        3'b101: Y = 8'b00000100;
        3'b110: Y = 8'b00000010;
        3'b111: Y = 8'b00000001;
      endcase
    else
      Y = 8'b00000000;
  end
endmodule
