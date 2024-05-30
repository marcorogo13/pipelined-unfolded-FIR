read_verilog -netlist ../netlist/myadvfir.v
current_design myadvfir
read_saif -input ../vcd/myadvfir_syn.saif -instance tb_fir_unfolded_post_syn/UUT -unit ps -scale 1
create_clock -name MY_CLK  -period 2400 CLK 
report_power > power.txt

