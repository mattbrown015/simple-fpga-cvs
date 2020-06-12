`timescale 1ps / 1ps

module simple_fpga_cvs(
    input wire in[4:0],
    output wire out[4:0],
    input wire osc_300_pn[1:0],
    output wire clk_out
    );

    wire osc_300;
    wire clk_fb;

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
        .CLKFBOUT_MULT_F(2.0),      // Multiply value for all CLKOUT (2.000-64.000)
        .CLKIN1_PERIOD(3.333),      // Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
        .CLKOUT0_DIVIDE_F(2.0)      // Divide amount for CLKOUT0 (1.000-128.000)
    )
    MMCME3_BASE_inst (
        // Clock Outputs outputs: User configurable clock outputs
        .CLKOUT0(clk_out),     // 1-bit output: CLKOUT0
        .CLKFBOUT(clk_fb),     // 1-bit output: Feedback clock
        .CLKIN1(osc_300),      // 1-bit input: Clock
        // Feedback inputs: Clock feedback ports
        .CLKFBIN(clk_fb)       // 1-bit input: Feedback clock
    );

    // End of MMCME3_BASE_inst instantiation

    assign out = in;
endmodule
