module junsignedArrayMultiplierTb;
  wire [7:0] Y;
  reg [3:0] A, B;
  
  junsignedArrayMultiplier juam(Y, A, B);
  
  initial
  begin
    $display("RSLT\tA x B = Y");
    A = 2; B = 2; #10;
    if ( Y == 4 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
    A = 3; B = 3; #10;
    if ( Y == 4 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
    A = 3; B = 4; #10;
    if ( Y == 12 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
    A = 3; B = 5; #10;
    if ( Y == 15 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
    A = 0; B = 0; #10;
    if ( Y == 0 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
    A = 1; B = 1; #10;
    if ( Y == 1 )
      $display("PASS\t%p x %p = %p",A,B,Y);
    else
      $display("FAIL\t%p x %p = %p",A,B,Y);
  end
  
endmodule
