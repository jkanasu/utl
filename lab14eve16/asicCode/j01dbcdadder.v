// Below is the code as per manual
// It fails for 9 + 9 test
module jbcdadder(Y,carryout,carryin,A,B);
  output [3:0]Y;
  output carryout;
  input carryin;
  input [3:0]A,B;
  
  wire z, cout;
  wire [3:0] s;
  
  assign {cout, s} = A + B;
  //assign z = cout | ( s[3] & s[2] ) | ( s[3] & s[1] );
  //assign {carryout, Y} = s + {1'b0, z, z, 1'b0};
  assign z = cout | s > 9;
  assign Y = s + {1'b0, z, z, 1'b0};
  assign carryout = cout | z;
  
endmodule

// Below is an example code from internet
module jbcdadderInternet(Y,carryout,carryin,A,B);
  output reg [3:0]Y;
  output reg carryout;
  input carryin;
  input [3:0]A,B;
  reg [3:0] s; // intermediate result sum
  
  always @(carryin, A, B)begin
    {carryout, s} = A + B + carryin;
    if (carryout | s > 9 ) begin
      Y = s + 6;
      carryout = 1'b1;
    end
    else Y = s;
  end
endmodule

