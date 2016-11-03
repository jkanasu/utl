module jLFSRTb;
  wire [3:0] Q;
  reg clock, reset;
  
  jLFSR jlfsr(Q, clock, reset);
  
  initial
  begin
    clock =0;
    reset = 1; #10; reset = 0; #10;
    #200;
    $finish;
    
  end
  always #5 clock = ~clock;
endmodule
