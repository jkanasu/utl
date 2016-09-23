/* 
First construct a D-Flipflop and then reuse this in the asynchronous counter
In fact this is a reuse of the dflipflop code already done in an earlier exercise
Just the name of the module is changed so that there is no conflict
*/
module jAsyncCntrDFlipFlop(q,qbar,clk,rst,d);
	output reg q;
	output qbar;
	input clk, rst;
	input d;

	assign qbar = ~q;

  // NOTE it is important to mention the edge for each of the parameter
  // if it is not mentioned default is all edges i.e. positive and negative edges
	always @(posedge clk, posedge rst)
	begin
		if (rst)
			q <= 0;
		else
			q <= d;
	end
endmodule

module jAsynchronousCounter(count,countbar,clk,rst);
  input clk, rst;
  output [3:0] count, countbar;
  
  jAsyncCntrDFlipFlop m1(count[0],countbar[0],clk     ,rst,countbar[0]);
  jAsyncCntrDFlipFlop m2(count[1],countbar[1],count[0],rst,countbar[1]);
  jAsyncCntrDFlipFlop m3(count[2],countbar[2],count[1],rst,countbar[2]);
  jAsyncCntrDFlipFlop m4(count[3],countbar[3],count[2],rst,countbar[3]);
  
endmodule