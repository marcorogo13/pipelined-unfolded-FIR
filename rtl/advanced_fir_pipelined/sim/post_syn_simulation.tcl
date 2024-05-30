
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir_unfolded_post_syn
vsim -t 1ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir_unfolded_post_syn/UUT=../netlist/myadvfir.sdf work.tb_fir_unfolded_post_syn

vcd file ../vcd/myadvfir_syn.vcd
vcd add /tb_fir_unfolded_post_syn/UUT/*


