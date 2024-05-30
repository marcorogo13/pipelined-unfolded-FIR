vsim work.tb_fir -t 1ps -voptargs=+acc
add wave -position insertpoint sim:/tb_fir/UUT/*
run 40000 ns
