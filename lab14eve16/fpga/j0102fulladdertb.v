module jfulladdertb;
  wire y, carryout;
  reg a,b,carryin;
  
  jfulladder jfa(y,carryout,a,b,carryin);
  initial
  begin
    $display("RSLT\tA\tB\tCYIN\t\tCYOUT\tSUM");
    
    a = 0; b = 0; carryin = 0; #50; // Set inputs and add delay
    if ( (carryout == 0 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 0; b = 0; carryin = 1; #50; // Set inputs and add delay
    if ( (carryout == 0 ) && (y === 1))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 0; b = 1; carryin = 0; #50; // Set inputs and add delay
    if ( (carryout == 0 ) && (y === 1))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 0; b = 1; carryin = 1; #50; // Set inputs and add delay
    if ( (carryout == 1 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 1; b = 0; carryin = 0; #50; // Set inputs and add delay
    if ( (carryout == 0 ) && (y === 1))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 1; b = 0; carryin = 1; #50; // Set inputs and add delay
    if ( (carryout == 1 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 1; b = 1; carryin = 0; #50; // Set inputs and add delay
    if ( (carryout == 1 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
    a = 1; b = 1; carryin = 1; #50; // Set inputs and add delay
    if ( (carryout == 1 ) && (y === 1))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d",a,b,carryin,carryout,y);
    
  end
endmodule
