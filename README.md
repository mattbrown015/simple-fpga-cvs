# simple-fpga-cvs
Simple FPGA Project with CVS

I'm an experienced programmer but new to FPGA development.

I thought I'd use this project to record things I discover about developing for Xilinx FPGAs.

## Steps Completed

This is a summary of the history of this repo.

1. Create Vivado project
1. Write simple unsynthesizable testbench

   ```verilog
   `timescale 1ps / 1ps

   module simple_fpga_cvs_tb();
       reg clock;

       always begin
           #1 clock = !clock;
       end

       initial begin
           clock = 0;
       end
   endmodule
   ```

1. Run simulation in Vivado and examine waveform
1. Write simple design, instantiate in testbench and simulate

   ```verilog
   `timescale 1ps / 1ps

   module simple_fpga_cvs(
       input clock
       );
   endmodule
   ```
1. Synthesis design
1. Specify I/O ports for KCU105 in Vivado, create constraints file using Vivado
1. Connect design to to KCU105 user buttons, LEDs and user SMA connectors
1. Connect design to KCU105 oscillator and instance MMCM to create a clock for the design
   * [UltraScale Architecture Clocking Resources UG572](https://www.xilinx.com/support/documentation/user_guides/ug572-ultrascale-clocking.pdf)
   * [What is a Clock in an FPGA?](https://www.youtube.com/watch?v=htwlb-DuEK8)
