vsim work.tb_filter_unfolded -t 10ps -voptargs=+acc
add wave -position insertpoint sim:/tb_filter_unfolded/UUT/*
run 15000 ns
