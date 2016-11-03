module jmagnitudeComparatorTb;
  wire AEQB, AGTB, ALTB;
  reg [3:0] A, B;
  
  jmagnitudeComparator jmc(AEQB, AGTB, ALTB, A, B);
  
  initial
  begin
    $display("RSLT\tA <> B is EQ GT LT");
    A = 2; B = 2; #10;
    if ( AEQB == 1 )
      $display("PASS\t%p <> %p is _%p __ __",A,B,AEQB);
    else
      $display("FAIL\t%p <> %p is %p",A,B,AEQB, AGTB, ALTB);
    A = 3; B = 4; #10;
    if ( ALTB == 1 )
      $display("PASS\t%p <> %p is __ __ _%p",A,B,ALTB);
    else
      $display("FAIL\t%p <> %p is %p",A,B,AEQB, AGTB, ALTB);
    A = 5; B = 3; #10;
    if ( AGTB == 1 )
      $display("PASS\t%p <> %p is __ _%p __",A,B,AGTB);
    else
      $display("FAIL\t%p <> %p is %p",A,B,AEQB, AGTB, ALTB);
  end
  
endmodule
