vlib work

vlog ../netlist/myadvfir_gated.v

vcom ../tb/data_sink_unfolded.vhd
vcom ../tb/data_maker_new_unfolded.vhd
vcom ../tb/clk_gen.vhd
vlog ../tb/tb_fir_unfolded_post_syn.v

