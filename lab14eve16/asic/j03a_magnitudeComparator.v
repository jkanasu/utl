// This takes two 4 bit numbers and compares them
// The outputs are single bit
//    AEQB i.e. A equals B
//    AGTB i.e. A greater than B
//    ALTB i.e. A less than B
//
//
module jmagnitudeComparator(AEQB, AGTB, ALTB, A, B);
  output reg AEQB, AGTB, ALTB;
  input [3:0] A, B;

  always @(A,B)
  begin
    if( A === B )
      begin
        AEQB = 1;
        AGTB = 0;
        ALTB = 0;
      end
    else if ( A > B )
      begin
        AEQB = 0;
        AGTB = 1;
        ALTB = 0;
      end
    else
      begin
        AEQB = 0;
        AGTB = 0;
        ALTB = 1;
      end
  end
endmodule
