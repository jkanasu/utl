module jbasicgatestb;
  wire yOR,yAND,yXOR,yNOR,yNAND,yXNOR;
  reg a,b;
  
  jbasicgates jbgs(yOR,yAND,yXOR,yNOR,yNAND,yXNOR,a,b);
  initial
  begin
    $display("RSLT\ta\tb\tOR\tAND\tXOR\tNOR\tNAND\tXNOR");
  
    a = 0; b = 0; #50; // Assign values and some delay
    if ( (yOR == 0) && (yAND == 0) && (yXOR == 0) && (yNOR == 1) && (yNAND == 1) && (yXNOR == 1) ) // Test for inversion
      $display("PASS\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);
   	else
      $display("FAIL\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);

    a = 0; b = 1; #50; // Assign values and some delay
    if ( (yOR == 1) && (yAND == 0) && (yXOR == 1) && (yNOR == 0) && (yNAND == 1) && (yXNOR == 0) ) // Test for inversion
      $display("PASS\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);
   	else
      $display("FAIL\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);

    a = 1; b = 0; #50; // Assign values and some delay
    if ( (yOR == 1) && (yAND == 0) && (yXOR == 1) && (yNOR == 0) && (yNAND == 1) && (yXNOR == 0) ) // Test for inversion
      $display("PASS\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);
   	else
      $display("FAIL\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);

    a = 1; b = 1; #50; // Assign values and some delay
    if ( (yOR == 1) && (yAND == 1) && (yXOR == 0) && (yNOR == 0) && (yNAND == 0) && (yXNOR == 1) ) // Test for inversion
      $display("PASS\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);
   	else
      $display("FAIL\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",a,b,yOR,yAND,yXOR,yNOR,yNAND,yXNOR);

  end
endmodule
