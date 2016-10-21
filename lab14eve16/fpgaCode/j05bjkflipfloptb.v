module jjkflipfloptb;
	wire q, qbar;
	reg clk,rst;
	reg [1:0] jk;

	jjkflipflop jjkff(q,qbar,clk,rst,jk);
	always #5 clk = ~clk;

	initial
	begin
                clk = 1'b0;
		rst = 1; # 10; rst = 0; #10; 
		$display("RSLT\tj\tk\tq\tqbar");
                jk = 0; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
		
                jk = 1; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
		
                jk = 2; # 10; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
		
                jk = 3; # 10; // Another value
                if ( q === 1'b0 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
		
                jk = 3; # 11; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
		
                jk = 3; # 16; // Another value
                if ( q === 1'b1 ) // Test for inversion
                        $display ("PASS\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);
                else
                        $display ("FAIL\t%d\t%d\t%d\t%d",jk[1],jk[0],q,qbar);

		#100;
		$finish;
	end
	
endmodule
