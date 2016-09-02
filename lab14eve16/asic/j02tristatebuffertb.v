module jtristatebuffertb;
	reg a,c;
	wire y;
	jtristatebuffer jbuf(a,c,y);
	initial
	begin
		$display ("RESULT\ta\ty");

		a = 0; c = 0; # 100; // Initial value is set
		if ( y === 1'bz ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

		a = 0; c = 1; # 100; // Initial value is set
		if ( y === 0 ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

		a = 1; c = 0; # 100; // Another value
		if ( y === 1'bz ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

		a = 1; c = 1; # 100; // Another value
		if ( y === 1 ) // Test for inversion
			$display ("PASS\t%d\t%d",a,y);
		else
			$display ("FAIL\t%d\t%d",a,y);

	end
endmodule
		
