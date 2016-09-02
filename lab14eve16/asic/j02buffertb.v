module jbuffertb;
	reg a;
	wire y;
	jbuffer jbuf(a,y);
	initial
	begin
		$display ("RESULT\ta\ty");

		a = 0; # 100; // Initial value is set
		if ( y == 0 ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

		a = 1; # 100; // Another value
		if ( y == 1 ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

		a = 2; # 100; // Dummy value
	end
endmodule
		
