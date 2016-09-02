module jcarrylookaheadadder(Y,carryout,A,B,carryin);
  output [3:0]Y;
  output carryout;
  input [3:0]A,B;
  input carryin;

  wire [3:0]g,p;// generate and propogate  
  wire [4:0]c;// intermediate carry of adders, one extra for coding simplicity
  
  assign c[0] = carryin; // this line is not needed can be directly written
  
  assign Y[0] = A[0] ^ B[0] ^ c[0];
  // The below single line is what reduces the delay
  assign c[1] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & c[0] ) );
  
  assign Y[1] = A[1] ^ B[1] ^ c[1];
  // The below single line is what reduces the delay
  //assign c[2] = ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & c[1] ) );
  // Next substitue c[1] with the expanded logic
  assign c[2] = ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & c[0] ) ) ) ); // This line removed the delay in calculating carry logic
  
  assign Y[2] = A[2] ^ B[2] ^ c[2];
  // The below single line is what reduces the delay
  //assign c[3] = ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & c[2] ) );// // This line removed the delay in calculating propogate logic
  // Next substitue c[2] with the expanded logic
  //assign c[3] = ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & c[1] ) ) ) );
  // Next substitue c[1] with the expanded logic
  assign c[3] = ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & c[0] ) ) ) ) ) );
  
  assign Y[3] = A[3] ^ B[3] ^ c[3];
  // The below single line is what reduces the delay
  //assign c[4] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & c[3] ) );
  // Next substitue c[3] with the expanded logic
  //assign c[4] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & c[2] ) ) ) );  
  // Next substitue c[2] with the expanded logic
  //assign c[4] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & c[1] ) ) ) ) ) );  
  // Next substitue c[1] with the expanded logic
  assign c[4] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & c[0] ) ) ) ) ) ) ) );  
  

  // finally assign the carryout
  assign carryout = c[4];

  
endmodule

/*

  // This will cause more delay into ckt
  assign g[0] = A[0] & B[0];
  assign p[0] = A[0] ^ B[0];
  assign c[1] = g[0] | ( p[0] & c[0]);

  assign Y[0] = A[0] ^ B[0] ^ c[0];

  // This will cause more delay into ckt
  assign g[1] = A[1] & B[1];
  assign p[1] = A[1] ^ B[1];
  assign c[2] = g[1] | ( p[1] & c[1]);

  assign Y[1] = A[1] ^ B[1] ^ c[1];
  
  // This will cause more delay into ckt
  assign g[2] = A[2] & B[2];
  assign p[2] = A[2] ^ B[2];
  assign c[3] = g[2] | ( p[2] & c[2]);

  assign Y[2] = A[2] ^ B[2] ^ c[2];
  
  // This will cause more delay into ckt
  assign g[3] = A[3] & B[3];
  assign p[3] = A[3] ^ B[3];
  assign carryout = g[3] | ( p[3] & c[3]);

  assign Y[2] = A[2] ^ B[2] ^ c[3];
  
*/