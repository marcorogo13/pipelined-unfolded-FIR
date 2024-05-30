read_verilog -netlist ../netlist/myadvfir_gated.v
current_design myadvfir
read_saif -input ../vcd/myadvfir_syn_gated.saif -instance tb_fir_unfolded_post_syn/UUT -unit ps -scale 1
create_clock -name MY_CLK -period 2.4 CLK 
report_power > power_gated.txt

