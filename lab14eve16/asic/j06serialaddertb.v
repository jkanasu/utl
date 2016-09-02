module jserialaddertb;
  wire [3:0]y;
  wire carryout,isvalid;
  wire currentsum, currentcarryout;
  wire [2:0]currentbitcount;
  reg clk, rst;
  reg a,b,carryin;
  
  reg [3:0]A,B;// temporary variables to ease the testing

  integer timeLapsed;
  integer i;

  jserialadder jsa(y,carryout,isvalid,currentsum,currentcarryout,currentbitcount,clk,rst,a,b,carryin);
  //always #5 clk = ~clk;// THIS can NOT be done as we have to control the inputs with the clock
  
  initial
  begin
    // The general concept of testing is to put the block of statement within the clock change
		$display("INITIALIZING");
		timeLapsed = 0;
		i = 0;
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // First time initialization
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
		$display("\nTESTING");
    $display("RSLT\tTIME(ns)\tA\tB\tCYIN\t\tCYOUT\tSUM\t\tBITT\tCCRY\tCSUM");

    //$display("NEXT Reset");
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    A = 5; B =5; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    
    if ( (carryout == 0 ) && (y === 10))
      $display("PASS\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    else
      $display("FAIL\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    A = 10; B = 5; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    
    if ( (carryout == 0 ) && (y === 15))
      $display("PASS\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    else
      $display("FAIL\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    A = 6; B = 10; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("Bitt\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount,currentcarryout,currentsum);
    
    if ( (carryout == 1 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    else
      $display("FAIL\t%d\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",timeLapsed,a,b,carryin,carryout,y,currentbitcount);
    
    
  end
  
endmodule

/*
    A = 0; B =0; carryin = 0; // Set the inputs
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    
    if ( (carryout == 0 ) && (y === 0))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    
    A = 1; B =0; carryin = 0; // Set the inputs
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    $display("RST_\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    $display("Bitt\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    $display("Bitt\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    $display("Bitt\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    $display("Bitt\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    
    if ( (carryout == 0 ) && (y === 1))
      $display("PASS\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
    else
      $display("FAIL\t%d\t%d\t%d\t=\t%d\t%d\t\t%d",a,b,carryin,carryout,y,currentbitcount);
  */  
