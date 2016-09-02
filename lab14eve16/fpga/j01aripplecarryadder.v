// A 4 bit RCA, can be extended to 8 bit
module jripplecarryadder(Y,carryout,A,B,carryin);
  output Y[3:0],carryout;
  input [3:0]A,B;
  input carryin;
  
  wire c1,c2,c3,c4,c5,c6,c7;
  
  jfulladder jfa0(Y[0],c1,A[0],B[0],carryin);
  jfulladder jfa1(Y[1],c2,A[1],B[1],c1);
  jfulladder jfa2(Y[2],c3,A[2],B[2],c2);
  jfulladder jfa3(Y[3],carryout,A[3],B[3],c3);
  /*
  jfulladder jfa3(Y[3],c4,A[3],B[3],c3);
  jfulladder jfa4(Y[4],c5,A[4],B[4],c4);
  jfulladder jfa5(Y[5],c6,A[5],B[5],c5);
  jfulladder jfa6(Y[6],c7,A[6],B[6],c6);
  jfulladder jfa7(Y[7],carryout,A[7],B[7],c7);
  */
  
endmodule