//`timescale 1ns

module tb_fir_unfolded_post_syn ();

   parameter NBIT = 8;   

   wire CLK_i;
   wire RST_n_i;
   wire [7:0] DIN3k_i;
   wire [7:0] DIN3k1_i;
   wire [7:0] DIN3k2_i;   
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
   wire [7:0] DOUT3k_i;
   wire [7:0] DOUT3k1_i;
   wire [7:0] DOUT3k2_i;   
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker #(.NBIT(8)) SM(.CLK(CLK_i),
				.RST_n(RST_n_i),
				.VOUT(VIN_i),
				.DOUT3k(DIN3k_i),
				.DOUT3k1(DIN3k1_i),
				.DOUT3k2(DIN3k2_i),				
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

   myadvfir UUT(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.DIN3k(DIN3k_i),
		.DIN3k1(DIN3k1_i),
		.DIN3k2(DIN3k2_i),		
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
		.DOUT3k(DOUT3k_i),
		.DOUT3k1(DOUT3k1_i),
		.DOUT3k2(DOUT3k2_i),		
		.VOUT(VOUT_i)); 

   data_sink #(.NBIT(8)) DS(.CLK(CLK_i),
			       .RST_n(RST_n_i),
			       .VIN(VOUT_i),
			       .DIN3k(DOUT3k_i),
			       .DIN3k1(DOUT3k1_i),
			       .DIN3k2(DOUT3k2_i));

endmodule

		   
