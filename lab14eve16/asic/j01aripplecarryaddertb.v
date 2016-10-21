module jripplecarryaddertb;
  wire Y[3:0],carryout;
  reg [3:0]A,B;
  reg carryin;
  jripplecarryadder jrca(Y,carryout,A,B,carryin);
  initial
  begin
    $display("RSLT\tA\tB\tCYIN\t\tCYOUT\tSUM");
    
    //A = 4'b0101; B = 4'b1101; carryin = 0; #50; // Set inputs and add delay
    A = 0; B = 0; carryin = 0; #50; // Set inputs and add delay
    A = 3; B = 2; carryin = 1; #50; // Set inputs and add delay
    A = 7; B = 10; carryin = 0; #50; // Set inputs and add delay
    A = 15; B = 15; carryin = 1; #50; // Set inputs and add delay
    /*
    //if ( (carryout == 1 ) && (Y === 4'b0010) )
    if ( (carryout == 1 ) && (Y === 2) )
      $display("PASS\t%p\t%p\t%d\t=\t%d\p%p",A,B,carryin,carryout,Y);
    else
      $display("FAIL\t%p\t%p\t%d\t=\t%d\t%p",A,B,carryin,carryout,Y);
    */
  end
endmodule