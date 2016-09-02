// Two modules are built as part of solution
// First define a 4 bit block and then reuse
module jcsablock(Y,carryout,A,B,carryin);
  output [3:0]Y;
  output carryout;
  input [3:0]A,B;
  input carryin;

  wire [3:0]g,p;// generate and propogate  
  wire [4:0]c;// intermediate carry of adders, one extra for coding simplicity
  wire z;// for the mux
  
  assign c[0] = carryin; // this line is not needed can be directly written
  
  genvar i;
  for (i=0; i<=3; i=i+1)
  begin
    assign p[i] = A[i] ^ B[i];
    assign c[i+1] = ( A[i] & B[i] ) | ( A[i] & c[i] ) | ( B[i] & c[i] );
    assign Y[i] = A[i] ^ B[i] ^ c[i];
  end
  // now assign the mux value correctly
  
  assign z = p[0] & p [1] & p[2] & p[3];
  assign carryout = z ? carryin : c[4];

endmodule

// Second reuse the above block modules to build the final adder
// The adder is a 8 bit adder which will make use of two blocks of 4 bit each
module jcarryskipadder(Y,carryout,A,B,carryin);
  output [7:0]Y;
  output carryout;
  input [7:0]A,B;
  input carryin;

  wire c4; // intermediate carry obtained from first block
  
  jcsablock b1 (Y[3:0],c4,A[3:0],B[3:0],carryin);
  jcsablock b2 (Y[7:4],carryout,A[7:4],B[7:4],c4); // pass the intermediate carry here
  
endmodule