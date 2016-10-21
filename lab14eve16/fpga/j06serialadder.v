// This is a 4 bit serial adder, output will be ready after 4 clock cycles
// Assume a,b will change with the clock
// Assume carryin will NOT change with the clock i.e. it will remain constant over the 4 clock cycles
// The outputs y & carryout will keep changing at posedge to indicate the current state of calculation
module jserialadder(y,carryout,isValid,currentsum,currentcarryout,currentbitcount,clk,rst,a,b,carryin);
  output reg [3:0]y;
  output reg carryout;
  output reg isValid; // This is a new functionality to indicate that the 4 bits were considered to produce the output
  output reg currentsum, currentcarryout;
  output reg [1:0]currentbitcount;// three bits enough to count till 4-bits for 4-bit serial adder
  input clk,rst;
  input a,b,carryin;

  wire intermediatecarry;
  
  // intermediatecarry should point to the carryin only for the 1st bit afterward it is previous bit's carryout
  assign intermediatecarry = ( currentbitcount == 3'd0) ? carryin : currentcarryout;
  
  // I have made even the Full adder to work on the posedge of the clock
  // continuous assignment did not seem to work
  always@(posedge clk)
  begin
    currentsum <= a ^ b ^ intermediatecarry;
    currentcarryout <= ( a & b ) | ( a & intermediatecarry ) | ( b & intermediatecarry );
  end

  //assign currentsum = a ^ b ^ intermediatecarry;
  //assign currentcarryout = ( a & b ) | ( a & intermediatecarry ) | ( b & intermediatecarry );
  //assign carryout = ( currentbitcount == 3'd4 ) ? intermediatecarry : 0;

  always@(posedge clk)
  begin
    if(rst)
      begin
        y <= 0;// other ways of assigning {0,0,0,0};//4'd0;
        carryout <= 0;
      end
    else
      begin
        y <= {currentsum, y[3:1]};
        carryout <= currentcarryout;//( currentbitcount == 3'd4 ) ? intermediatecarry : 0;
      end
    end

  // Below block will keep track of the number of bits that have been added
  // This is currently written for a 4 bit serial adder
  always@(posedge clk)
  begin
    if(rst)
        currentbitcount <= 0;
    else
        currentbitcount <= currentbitcount + 1; // already the 4 bit addition is completed
  end

  // isValid will provide the indication as to whether the addition is completed  
  // This is currently written for a 4 bit serial adder
  always@(posedge clk)
  begin
    if(rst)
        isValid <= 0;
    else
        isValid <= (currentbitcount == 3) ? 1 : 0; // at positive edge assume the 4 bit addition is completed without delay
  end
  
endmodule


// Below is a simplistic approach to implement the serial adder
// Code given by the college lab
module jserialaddlab(a, b , clk, reset, sum, carry, cout, count, so);
  input clk, reset, a, b;
  output sum, carry;
  reg cin;
  output reg [3:0] so;
  output reg [2:0] count;
  output reg cout;
  wire cut;
  
  assign sum = a^b^cin;
  assign carry = (count == 3'd4) ? 0 : cut;
  assign cut = (a&b) | (a&cin) | (b&cin);
  
  always@(posedge clk)
  begin
    if(reset)
      cin <= 0;
    else
      cin <= carry;
  end

  always@(posedge clk)
  begin
    if(reset)
      cout <= 0;
    else
      count <= cut;
  end
  
  always@(posedge clk)
  begin
    if(reset)
      so <= 0;
    else
      so <= {sum, so[3:1]};
  end
  
  always@(posedge clk)
  begin
    if(reset)
      count <= 0;
    else
      count <= (count ==4) ? 1 : count+1;
  end
  
endmodule

