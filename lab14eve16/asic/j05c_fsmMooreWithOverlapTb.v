// the clock is manually controlled to set the inputs correctly
module jfsmMooreWithOverlapTb;
  wire dataout;
  reg clock, reset, datain;
  jfsmMooreWithOverlap jfsmMoore(dataout, clock, reset, datain);
  initial
  begin
    reset = 1; datain = 0; 
    clock = 1; #5; clock = 0; #5;
    reset = 0;
    clock = 1; #5; clock = 0; #5;
    
    $display("Starting input sequence");

    // we now make the 5 transistions and check the dataout to see if it is detected
    datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 0; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    if ( dataout === 1 )
      $display("PASS %b", dataout);
    else
      $display("FAIL %b", dataout);
    
    // we now make the ONLY 4 transistions and check the dataout to see if it is detected
    //datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    datain = 0; clock = 1; #5; clock = 0; #5;
    datain = 1; clock = 1; #5; clock = 0; #5;
    if ( dataout === 1 )
      $display("PASS %b", dataout);
    else
      $display("FAIL %b", dataout);
    
    // we now make a wrongsequence the 5 transistions and check the dataout to see if it is detected
    datain = 0; clock = 1; #5; clock = 0; #5;
    datain = 0; clock = 1; #5; clock = 0; #5;
    if ( dataout === 0 )
      $display("PASS %b", dataout);
    else
      $display("FAIL %b", dataout);
    
  end

endmodule
