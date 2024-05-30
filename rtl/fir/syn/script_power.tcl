read_verilog -netlist ../netlist/myfir.v 
read_saif -input ../vcd/myfir_syn.saif -instance tb_fir_post_syn/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 6.4 CLK 
report_power > power.txt
quit
