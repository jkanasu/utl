module jtristatebuffer(a,c,y);
	input a,c;
	output y;
	assign y= c ? a : 1'bz;	
endmodule
