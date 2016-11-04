module jparityGeneratorTb;
  wire [4:0] DOUT;
  wire parity;
  reg [3:0] DIN;
  
  jparityGenerator jpgrtr(DOUT, parity, DIN);
  
  initial
  begin
    $display("RSLT\tD is parity with DOUT");
    DIN = 4'b0011; #10;
    if ( (parity == 0) && (DOUT === { DIN, 1'b0 }) )
      $display("PASS\t%p is %p with %p", DIN, parity, DOUT);
    else
      $display("FAIL\t%p is %p with %p", DIN, parity, DOUT);
    DIN = 4'b1011; #10;
    if ( (parity == 1) && (DOUT === { DIN, 1'b1 }) )
      $display("PASS\t%p is %p with %p", DIN, parity, DOUT);
    else
      $display("FAIL\t%p is %p with %p", DIN, parity, DOUT);
    DIN = 4'b1111; #10;
    if ( (parity == 0) && (DOUT === { DIN, 1'b0 }) )
      $display("PASS\t%p is %p with %p", DIN, parity, DOUT);
    else
      $display("FAIL\t%p is %p with %p", DIN, parity, DOUT);
  end
endmodule