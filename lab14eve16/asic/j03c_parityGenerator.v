module jparityGenerator(DOUT, parity, DIN);
  output [4:0] DOUT;
  output parity;
  input [3:0] DIN;
  
  assign parity = DIN[0] ^ DIN[1] ^ DIN[2] ^ DIN[3];
  assign DOUT = { DIN, parity };
  
endmodule