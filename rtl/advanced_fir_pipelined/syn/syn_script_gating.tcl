analyze -library WORK -format vhdl {../src/oneBit_reg.vhd}
analyze -library WORK -format vhdl {../src/my_reg.vhd}
analyze -library WORK -format vhdl {../src/my_adder.vhd}
analyze -library WORK -format vhdl {../src/my_mult.vhd}
analyze -library WORK -format vhdl {../src/myadvfir.vhd}

set power_preserve_rtl_hier_names true
elaborate myadvfir -arch struct -lib WORK
uniquify 
link
report_timing > timing_pre.txt 
report_area > area_pre.txt
create_clock -name MY_CLK -period 4.8 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile -gate_clock
report_timing > timing_gated.txt 
report_area > area_gated.txt
ungroup -all -flatten  
change_names -hierarchy -rules verilog
write_sdf ../netlist/myadvfir_gated.sdf
write -f verilog -hierarchy -output ../netlist/myadvfir_gated.v
write_sdc ../netlist/myadvfir_gated.sdc 
