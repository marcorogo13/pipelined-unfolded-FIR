read_verilog -netlist ../netlist/myfir_gated_slow.v
current_design myfir 
read_saif -input ../vcd/myfir_syn_gated_slow.saif -instance tb_fir_post_syn/UUT -unit ps -scale 1
create_clock -name MY_CLK -period 3200 CLK 
report_power > power_gated_slow.txt
quit

