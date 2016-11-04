module juniversalShiftRegisterTb;
  wire [3:0] DATAOUT;
  reg clock, reset;
  reg [1:0] MODE;
  reg [3:0] DATAIN;
  
  juniversalShiftRegister jusr(DATAOUT, clock, reset, MODE, DATAIN);
  
  initial
  begin
    clock =0; MODE = 2'b00; DATAIN = 4'b0000;
    reset = 1; #10; reset = 0; #10;
    
    $display("RSLT\tD == DOUT");
    // Start testing Right Shift mode
    MODE = 2'b00; reset = 1; #10; reset = 0; #10;
    MODE = 2'b01; DATAIN = 4'b0011; #10;
    if ( DATAOUT === 4'b1000 ) // look at previous value of DATAOUT as well
      $display("PASS\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    else
      $display("FAIL\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    MODE = 2'b01; DATAIN = 4'b0011; #10;
    if ( DATAOUT === 4'b1100 ) // look at previous value of DATAOUT as well
      $display("PASS\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    else
      $display("FAIL\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    
    
    // Start testing Left Shift mode
    MODE = 2'b00; reset = 1; #10; reset = 0; #10;
    MODE = 2'b10; DATAIN = 4'b0111; #10;
    if ( DATAOUT === 4'b0001 ) // 
      $display("PASS\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    else
      $display("FAIL\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    MODE = 2'b10; DATAIN = 4'b0111; #10;
    if ( DATAOUT === 4'b0011 ) // 
      $display("PASS\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    else
      $display("FAIL\t%p is %p with %p", DATAIN, MODE, DATAOUT);


    // Start testing parallel load mode
    MODE = 2'b00; reset = 1; #10; reset = 0; #10;
    MODE = 2'b11; DATAIN = 4'b1010; #10;
    if ( DATAOUT === 4'b1010 )
      $display("PASS\t%p is %p with %p", DATAIN, MODE, DATAOUT);
    else
      $display("FAIL\t%p is %p with %p", DATAIN, MODE, DATAOUT);

    #20;
    $finish;
  end
  
  always #5 clock = ~clock;
  
endmodule