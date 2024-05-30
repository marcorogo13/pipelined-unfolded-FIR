analyze -library WORK -format vhdl {../src/oneBit_reg.vhd}
analyze -library WORK -format vhdl {../src/my_reg.vhd}
analyze -library WORK -format vhdl {../src/my_adder.vhd}
analyze -library WORK -format vhdl {../src/my_mult.vhd}
analyze -library WORK -format vhdl {../src/myfir.vhd}

set power_preserve_rtl_hier_names true
elaborate myfir -arch struct -lib WORK
uniquify 
link
report_timing
report_area
create_clock -name MY_CLK -period 3.2 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]


compile -gate_clock
report_timing > timing_gate_slow.txt 
report_area > area_gate_slow.txt
ungroup -all -flatten  
change_names -hierarchy -rules verilog
write_sdf ../netlist/myfirmodified.sdf
write -f verilog -hierarchy -output ../netlist/myfirmodified.v
write_sdc ../netlist/myfirmodified.sdc 
quit
