###################################################################

# Created by write_sdc on Thu Nov 16 16:57:27 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_load -pin_load 3.40189 [get_ports {DOUT[7]}]
set_load -pin_load 3.40189 [get_ports {DOUT[6]}]
set_load -pin_load 3.40189 [get_ports {DOUT[5]}]
set_load -pin_load 3.40189 [get_ports {DOUT[4]}]
set_load -pin_load 3.40189 [get_ports {DOUT[3]}]
set_load -pin_load 3.40189 [get_ports {DOUT[2]}]
set_load -pin_load 3.40189 [get_ports {DOUT[1]}]
set_load -pin_load 3.40189 [get_ports {DOUT[0]}]
set_load -pin_load 3.40189 [get_ports VOUT]
create_clock [get_ports CLK]  -name MY_CLK  -period 6.4  -waveform {0 1.6}
set_clock_uncertainty 0.07  [get_clocks MY_CLK]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports RST_n]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {DIN[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports VIN]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B0[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B1[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B2[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B3[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B4[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B5[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B6[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B7[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B8[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B9[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {B10[0]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[7]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[6]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[5]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[4]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[3]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[2]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[1]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {DOUT[0]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports VOUT]