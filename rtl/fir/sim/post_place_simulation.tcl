
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir_post_syn
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdfmax /tb_fir_post_syn/UUT=../innovusmet/myfir.sdf work.tb_fir_post_syn


vcd file ../vcd/myfir_place.vcd
vcd add /tb_fir_post_syn/UUT/*

