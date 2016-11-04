module jarbitraryCounterTb;
  wire [2:0] OUTPUT;
  reg clock, reset;
  
  jarbitraryCounter jac(OUTPUT, clock, reset);

  initial
  begin
    clock = 0; reset = 1; #10; reset = 0;
    #200;
    $finish;
  end
  
  always #5 clock = ~clock;
  
endmodule