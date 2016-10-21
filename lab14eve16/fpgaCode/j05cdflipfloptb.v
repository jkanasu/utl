module jdflipfloptb;
	wire q, qbar;
	reg clk,rst;
	reg d;

	jdflipflop jdff(q,qbar,clk,rst,d);
	always #5 clk = ~clk;

	initial
	begin
                clk = 1'b0;
		rst = 1; # 10; rst = 0; #10; 
		$display("RSLT\td\tq\tqbar");
                d = 0; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,q,qbar);
		
                d = 1; # 10; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,q,qbar);

		#10;
		$finish;		
	end
endmodule
