module jhalfaddertb;
	reg a,b;
	wire sum,carry;
	jhalfadder jha(sum,carry,a,b);
	initial
	begin
		$display ("RSLT\tA\tB\t=\tCARRY\tSUM");
		a =0; b=0; # 100; // Set the inputs and give a 100 ns delay
		$display ("PASS\t%d\t%d\t=\t%d\t%d", a, b, carry, sum);
		a =0; b=1; # 100; // Set the inputs and give a 100 ns delay
		$display ("PASS\t%d\t%d\t=\t%d\t%d", a, b, carry, sum);
		a =1; b=0; # 100; // Set the inputs and give a 100 ns delay
		$display ("PASS\t%d\t%d\t=\t%d\t%d", a, b, carry, sum);
		a =1; b=1; # 100; // Set the inputs and give a 100 ns delay
		$display ("PASS\t%d\t%d\t=\t%d\t%d", a, b, carry, sum);
	end
endmodule
