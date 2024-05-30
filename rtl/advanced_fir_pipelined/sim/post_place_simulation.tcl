
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir_unfolded_post_syn
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdfmax /tb_fir_unfolded_post_syn/UUT=../innovus/myadvfir.sdf work.tb_fir_unfolded_post_syn


vcd file ../vcd/myadvfir_place.vcd
vcd add /tb_fir_unfolded_post_syn/*

