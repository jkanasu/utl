module jsrflipfloptb;
	wire q, qbar;
	reg clk,rst;
	reg [1:0] sr;

	jsrflipflop jsrff(q,qbar,clk,rst,sr);
	always #5 clk = ~clk;

	initial
	begin
                clk = 1'b0;
		rst = 1; # 10; rst = 0; #10; 
		$display("RSLT\ts\tr\tq\tqbar");
                sr = 0; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
		
                sr = 1; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
		
                sr = 2; # 10; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
		
                sr = 3; # 10; // Another value
                if ( q === 1'bx ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",sr[1],sr[0],q,qbar);
		
	end
endmodule
