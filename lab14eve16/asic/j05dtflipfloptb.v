module jtflipfloptb;
	wire q, qbar;
	reg clk,rst;
	reg t;

	jtflipflop jtff(q,qbar,clk,rst,t);
	always #5 clk = ~clk;

	initial
	begin
                clk = 1'b0;
		rst = 1; # 10; rst = 0; #10; 
		$display("RSLT\tt\tq\tqbar");
                t = 0; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
		
                # 10; // JUST delay
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
		
                # 10; // JUST delay
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
		
                t = 1; # 10; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
	
                # 10; // JUST delay
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
		
                # 10; // JUST delay
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d",t,q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d",t,q,qbar);
		
		$finish;	
	end
endmodule
