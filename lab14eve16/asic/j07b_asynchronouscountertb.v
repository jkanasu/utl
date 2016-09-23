module jAsynchronousCountertb;
  reg clk,rst;
  wire [3:0] count, countbar;
  jAsynchronousCounter jasc (count, countbar, clk,rst);
  initial
  begin
    clk = 0;
    rst = 1; 
    #23;// Just give enough time to reset the design
    rst = 0;
    #200;
    $finish;
  end
  always #5 clk = ~clk;
endmodule
