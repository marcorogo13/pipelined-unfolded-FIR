

# Folder structure: 


- C : here the C model for the FIR can be found, the needed samples can be found there too.
- Matlab : Screen shots of the frequency response plus the matlab script for the generation of the samples and the calculation of the THD reading the outputs of the C program from a file.
- rtl_and_physical
  - advanced_fir : intermediate version, only unfolding implemented, used only for simulation and verification.
      - src
  - advanced_fir_pipelined : final advanced version including unfolding and pipelining.
      - innovuscript : results of the place and route, with the commands used to achieve it collected in a script.
      - netlist : results of the synthesis process, verilog and timing files.
      - sim : compilation and simulation scripts for the various versions, input and output files of the simulation.
      - src : vhdl source files for the design.
      - syn : synthesis scripts and reports, the reports for the clock gated version were perfomed with no switching activity.
      - tb : testbench files, two separate testbenches one for the rtl and the other for the post synthesis version.
      - vcd : results of the switching activity simulations, inaccurate for the clock gated version.
  - fir : basic version of the fir.
        - innovuscript : results of the place and route, with the commands used to achieve it collected in a script.
      - netlist : results of the synthesis process, verilog and timing files.
      - sim : compilation and simulation scripts for the various versions, input and output files of the simulation.
      - src : vhdl source files for the design.
      - syn : synthesis scripts and reports.
      - tb : testbench files, two separate testbenches one for the rtl and the other for the post synthesis version.
      - vcd : results of the switching activity simulations.

