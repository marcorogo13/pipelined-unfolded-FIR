//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire RST_n_i;
   wire [7:0] DIN_i;
   wire [7:0] RD_i;
   wire VIN_i;
   wire [7:0] B0_i;
   wire [7:0] B1_i;
   wire [7:0] B2_i;
   wire [7:0] B3_i;
   wire [7:0] B4_i;
   wire [7:0] B5_i;
   wire [7:0] B6_i;
   wire [7:0] B7_i;
   wire [7:0] B8_i;
   wire [7:0] B9_i;
   wire [7:0] B10_i;
   wire [7:0] DOUT_i;
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(
			.END_SIM(END_SIM_i),
  	      	.CLK(CLK_i),
	      	.RST_n(RST_n_i));

   data_maker SM(	
			.CLK(CLK_i),  	
			.RST_n(RST_n_i),
		 	.VOUT(VIN_i),
		 	.DOUT(DIN_i),
		 	.B0(B0_i),
		 	.B1(B1_i),
		 	.B2(B2_i),
		 	.B3(B3_i),
			.B4(B4_i),
			.B5(B5_i),
			.B6(B6_i),
			.B7(B7_i),
			.B8(B8_i),
			.B9(B9_i),
			.B10(B10_i),
		 	.END_SIM(END_SIM_i));

   myfir UUT(
			.CLK(CLK_i),
	     	.RST_n(RST_n_i),
	     	.DIN(DIN_i),
    	 	.VIN(VIN_i),
	     	.B0(B0_i),
			.B1(B1_i),
			.B2(B2_i),
			.B3(B3_i),
			.B4(B4_i),
			.B5(B5_i),
			.B6(B6_i),
			.B7(B7_i),
			.B8(B8_i),
			.B9(B9_i),
			.B10(B10_i),
			.DOUT(DOUT_i),
			.VOUT(VOUT_i));

   data_sink DS(
			.CLK(CLK_i),
			.RST_n(RST_n_i),
			.VIN(VOUT_i),
			.DIN(DOUT_i));   


endmodule

		   