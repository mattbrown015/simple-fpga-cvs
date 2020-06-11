`timescale 1ps / 1ps

module simple_fpga_cvs(
    input wire in[4:0],
    output wire out[4:0],
    input wire osc_300_pn[1:0],
    output wire clk_out
    );

    wire osc_300;
    wire clkfb;

    // IBUFDS: Differential Input Buffer
    //         Kintex UltraScale+
    // Xilinx HDL Language Template, version 2018.3

    IBUFDS IBUFDS_clk_300 (
        .O(osc_300),        // 1-bit output: Buffer output
        .I(osc_300_pn[0]),  // 1-bit input: Diff_p buffer input (connect directly to top-level port)
        .IB(osc_300_pn[1])  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
    );

   // MMCME3_BASE: Base Mixed Mode Clock Manager (MMCM)
   //              Kintex UltraScale
   // Xilinx HDL Language Template, version 2018.3

   MMCME3_BASE #(
      .BANDWIDTH("OPTIMIZED"),    // Jitter programming (HIGH, LOW, OPTIMIZED)
      .CLKFBOUT_MULT_F(2.0),      // Multiply value for all CLKOUT (2.000-64.000)
      .CLKFBOUT_PHASE(0.0),       // Phase offset in degrees of CLKFB (-360.000-360.000)
      .CLKIN1_PERIOD(3.333),      // Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
      .CLKOUT0_DIVIDE_F(2.0),     // Divide amount for CLKOUT0 (1.000-128.000)
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      // CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(1),
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT4_CASCADE("FALSE"),  // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),          // Master division value (1-106)
      // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
      .IS_CLKFBIN_INVERTED(1'b0), // Optional inversion for CLKFBIN
      .IS_CLKIN1_INVERTED(1'b0),  // Optional inversion for CLKIN1
      .IS_PWRDWN_INVERTED(1'b0),  // Optional inversion for PWRDWN
      .IS_RST_INVERTED(1'b0),     // Optional inversion for RST
      .REF_JITTER1(0.0),          // Reference input jitter in UI (0.000-0.999)
      .STARTUP_WAIT("FALSE")      // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME3_BASE_inst (
      // Clock Outputs outputs: User configurable clock outputs
      .CLKOUT0(clk_out),     // 1-bit output: CLKOUT0
      .CLKOUT0B(CLKOUT0B),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(CLKOUT1),     // 1-bit output: CLKOUT1
      .CLKOUT1B(CLKOUT1B),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(CLKOUT2),     // 1-bit output: CLKOUT2
      .CLKOUT2B(CLKOUT2B),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(CLKOUT3),     // 1-bit output: CLKOUT3
      .CLKOUT3B(CLKOUT3B),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(CLKOUT4),     // 1-bit output: CLKOUT4
      .CLKOUT5(CLKOUT5),     // 1-bit output: CLKOUT5
      .CLKOUT6(CLKOUT6),     // 1-bit output: CLKOUT6
      // Feedback outputs: Clock feedback ports
      .CLKFBOUT(clkfb),      // 1-bit output: Feedback clock
      .CLKFBOUTB(CLKFBOUTB), // 1-bit output: Inverted CLKFBOUT
      // Status Ports outputs: MMCM status ports
      .LOCKED(LOCKED),       // 1-bit output: LOCK
      // Clock Inputs inputs: Clock input
      .CLKIN1(osc_300),      // 1-bit input: Clock
      // Control Ports inputs: MMCM control ports
      .PWRDWN(PWRDWN),       // 1-bit input: Power-down
      .RST(RST),             // 1-bit input: Reset
      // Feedback inputs: Clock feedback ports
      .CLKFBIN(clkfb)        // 1-bit input: Feedback clock
   );

   // End of MMCME3_BASE_inst instantiation

    assign out = in;
endmodule
