
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir_post_syn
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir_post_syn/UUT=../netlist/myfir_gated_slow.sdf work.tb_fir_post_syn


vcd file ../vcd/myfir_syn_gated_slow.vcd
vcd add /tb_fir_post_syn/UUT/*
