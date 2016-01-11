`timescale 1ns/1ps


module CRC_GLADIC();



	//OUTPUTS
	wire [31:0] HRDATA;
	wire HREADYOUT;
	wire HRESP;
	//INPUTS
	wire [31:0] HWDATA;
	wire [31:0] HADDR;
	wire [ 2:0] HSIZE;
	wire [ 1:0] HTRANS;
	wire HWRITE;
	wire HSElx;
	wire HREADY;
	wire HRESETn;
	reg HCLK;


  crc_ip DUT (
		.HCLK     (HCLK      ),
		.HRESETn  (HRESETn   ),
		.HREADY   (HREADY    ),
		.HSElx    (HSElx     ),
		.HWRITE   (HWRITE    ),
		.HTRANS   (HTRANS    ),
		.HSIZE    (HSIZE     ),
		.HADDR    (HADDR     ),
		.HWDATA   (HWDATA    ),
		.HRESP    (HRESP     ),
		.HREADYOUT(HREADYOUT ),
		.HADDR    (HADDR     )
	   );

	integer i;

	initial
	 begin
	    $dumpfile("CRC_GLADIC.vcd");
	    $dumpvars(0,CRC_GLADIC);
	    $init;
	    $init_reset;
	 end

	initial HCLK = 1'b0;
	always #(5) HCLK = ~HCLK;


	always@(posedge HCLK)
		$crc_bfm;

	//RESET DUT A FEW TIMES TO GO TO RIGHT STATE
	always@(posedge HCLK)
		$reset_crc;

	//THIS MAKE REGISTER INITIAL ASSIGNMENT
	always@(negedge HRESETn)
		$init;

	//FLAG USED TO FINISH SIMULATION PROGRAM 
	always@(posedge HCLK)
	begin

		wait(i == 1);		
		$finish();
	end




endmodule
