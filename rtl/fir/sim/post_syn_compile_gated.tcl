vlib work

vcom ../tb/data_sink.vhd
vcom ../tb/data_maker_new.vhd
vcom ../tb/clk_gen.vhd
vlog ../netlist/myfir_gated_slow.v
vlog ../tb/tb_fir_post_syn.v


