module jserialaddertb;
  wire [3:0]y;
  wire carryout,isValid;
  wire currentsum, currentcarryout;
  wire [1:0]currentbitcount;
  reg clk, rst;
  reg a,b,carryin;
  
  reg [3:0]A,B;// temporary variables to ease the testing

  integer timeLapsed;
  integer i;

  jserialadder jsa(y,carryout,isValid,currentsum,currentcarryout,currentbitcount,clk,rst,a,b,carryin);
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
    $display("RSLT\tTIME(ns)\ta A\tb B\tCYIN\t\tCYOUT\tSUM\tISVALID\t\tBITT\tCCRY\tCSUM");

    //$display("NEXT Reset");
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    A = 5; B =5; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);

    clk = 0; #10; clk = 1; #10; // Extra clock since it is a serial adder
    timeLapsed = timeLapsed + 20;
    if ( (carryout == 0 ) && (y === 10))
      $display("PASS==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    else
      $display("FAIL==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    A = 10; B = 5; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    
    clk = 0; #10; clk = 1; #10; // Extra clock since it is a serial adder
    timeLapsed = timeLapsed + 20;
    if ( (carryout == 0 ) && (y === 15))
      $display("PASS==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    else
      $display("FAIL==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    A = 6; B = 10; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    
    clk = 0; #10; clk = 1; #10; // Extra clock since it is a serial adder
    timeLapsed = timeLapsed + 20;
    if ( (carryout == 1 ) && (y === 0))
      $display("PASS==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    else
      $display("FAIL==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    
    a = 0; b = 0; carryin = 0; A = 0; B = 0; // donot have "x" values, it is most confusing :-)
    // Always reset the adder before starting addition
    #10; clk = 0; rst = 1; #10; clk =1 ; #10; clk = 0 ; rst =0; #10; // Reset the adder
    timeLapsed = timeLapsed + 40;
    $display("Reset\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    A = 15; B = 15; carryin = 0; // Set the inputs
    i = 0;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 1;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 2;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    i = 3;
    clk = 0; #10; a = A[i]; b = B[i]; #10; clk = 1; #10; // Set inputs enable clock
    timeLapsed = timeLapsed + 30;
    $display("BitN\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d\t%d\t%d",timeLapsed,a,b,carryin,carryout,y,isValid,currentbitcount,currentcarryout,currentsum);
    
    clk = 0; #10; clk = 1; #10; // Extra clock since it is a serial adder
    timeLapsed = timeLapsed + 20;
    if ( (carryout == 1 ) && (y === 14))
      $display("PASS==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    else
      $display("FAIL==>\t%d\t%d\t%d\t%d\t=\t%d\t%d\t%d\t\t%d==>",timeLapsed,A,B,carryin,carryout,y,isValid,currentbitcount);
    
  end
  
endmodule

// Below is the test module for the lab provided code
module jserialaddlabtb;
  reg clk, reset, a, b;
  wire sum, carry, cout;
  wire [2:0] count;
  wire [3:0] so;
  
  jserialaddlab jslab(a,b,clk,reset,sum,carry,cout,count,so);
  
  initial
  begin
    clk=1;reset=1;
    a=0; b=0;
    #10;
    reset=0;
    // Now send a = 0101 and b = 1010
    a=1;b=0;
    #10;
    a=0;b=1;
    #10;
    a=1;b=0;
    #10;
    a=0;b=1;
    #10;
    // After four cycles the reset should be out
    // check for 5 + 10 = 15 i.e. y = 1111 and carry = 0
    
    // Now send a = 0100 and b = 0110
    a=0;b=0;
    #10
    a=0;b=1;
    #10;
    a=1;b=1;
    #10
    a=0;b=0;
    #10;
    // After four cycles the reset should be out
    // check for 4 + 6 = 10 i.e. y = 1010 and carry = 0
    #100;
    #10;
    // why would the above line not break
    #10;
  end
  
  always #5 clk=~clk;
  always @(posedge clk)
  begin
    if(count == 3'b100)
      $display("The carry and sum are = %d %d", carry, so);
  end
  
endmodule