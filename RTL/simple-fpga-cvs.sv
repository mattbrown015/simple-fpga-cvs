`timescale 1ps / 1ps

module simple_fpga_cvs(
    input wire in[4:0],
    output wire out[4:0],
    input wire osc_300_pn[1:0],
    output wire osc_300_out
    );

    // IBUFDS: Differential Input Buffer
    //         Kintex UltraScale+
    // Xilinx HDL Language Template, version 2018.3

    IBUFDS IBUFDS_clk_300 (
        .O(osc_300_out),   // 1-bit output: Buffer output
        .I(osc_300_pn[0]),  // 1-bit input: Diff_p buffer input (connect directly to top-level port)
        .IB(osc_300_pn[1])  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
    );

    assign out = in;
endmodule
