module synchronouscountertb;
	reg clk, reset;
	wire [3:0] count;
	synchronouscounter synccntr(clk,reset,count);

	initial
	begin
		clk = 0;
		reset = 1;
		#125;// IMPORTANT this value should make sure reset is SET when the first clk edge goes positive, else the count remain 'x' i.e. unknown value
		reset = 0;
		#4500;
		$finish;
	end

	always #50 clk=~clk;

	always@(posedge clk)
	begin
		$display ("value is %d", count);
	end

endmodule
