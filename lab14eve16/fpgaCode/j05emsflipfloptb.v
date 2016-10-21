module jmsflipfloptb;
	wire q, qbar;
	reg clk,rst;
	reg d;

	wire qn_1,qn_1bar; // to monitor current q and previous q values

	jmsflipflop jmsff(q,qbar,clk,rst,d);
	jdflipflop jdff(qn_1,qn_1bar,clk,1'b0,q);
	always #5 clk = ~clk;

	initial
	begin
		d = 0; // JUST keep it initialized
                clk = 1'b0;
		rst = 1; # 20;
		$display("INITIALIZING");
		$display("RSLT\td\tqn_1\tq");
                $display ("PASS\t%d\t%d\t%d",d,qn_1,q);

		rst = 0; # 20;
                $display ("PASS\t%d\t%d\t%d",d,qn_1,q);

		$display("\nTESTING");
		$display("RSLT\td\tqn_1\tq");
                d = 0; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,qn_1,q);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,qn_1,q);
		
                d = 1; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,qn_1,q);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,qn_1,q);
	
                # 5; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,qn_1,q);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,qn_1,q);
	
                d = 0; # 5; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,qn_1,q);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,qn_1,q);
	
                d = 1; # 5; // JUST wait
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",d,qn_1,q);
                else
                        $display ("FAIL\t%d\t%d\t%d",d,qn_1,q);
	
		$finish;	
	end
endmodule
