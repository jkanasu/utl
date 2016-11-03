// the polynomial is x^4 + x + 1
// shift the bits to left
// calculate the last bit by xor function
module jLFSR(Q, clock, reset);
  output reg [3:0] Q;
  input clock, reset;
  
  always @(posedge clock)
  begin
    if(reset)
      Q <= 4'b1111;
    else
      Q <= { Q[2:0], (Q[3] ^ Q[0]) };
  end
    
endmodule
