// NOTE inputs should be BCD numbers and NOT binary numbers
// i.e. inputs should be in the range 0 to 9 only.
// Output will be a BCD number
// Next step we have to have a carryin as well
module jbcdaddertb;
  wire [3:0]Y;
  wire carryout;
  reg [3:0]A,B;
  reg carryin;
  
  jbcdadderManual jbcda(Y,carryout,carryin,A,B);
  initial
  begin
    $display("RSLT\tA + B = C Y");
    carryin = 1'b0;
    A = 0; B = 0; #50;
    if ( (carryout == 0) && (Y == 0) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 1; B = 1; #50;
    if ( (carryout == 0) && (Y == 2) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 3; B = 5; #50;
    if ( (carryout == 0) && (Y == 8) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 6; B = 1; #50;
    if ( (carryout == 0) && (Y == 7) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 5; B = 5; #50;
    if ( (carryout == 1) && (Y == 0) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 7; B = 5; #50;
    if ( (carryout == 1) && (Y == 2) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 6; B = 8; #50;
    if ( (carryout == 1) && (Y == 4) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    A = 9; B = 9; #50;
    if ( (carryout == 1) && (Y == 8) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);

    // Below is a dummy test with a non BCD number    
    A = 18; B = 0; #50;
    if ( (carryout == 1) && (Y == 8) )
      $display("PASS\t%p + %p = %d %p",A,B,carryout,Y);
    else
      $display("FAIL\t%p + %p = %d %p",A,B,carryout,Y);
    
  end
endmodule