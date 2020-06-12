`timescale 1ps / 1ps

module simple_fpga_cvs(
    input logic in[4:0],
    output logic out[4:0],
    input logic osc_300_pn[1:0],
    output logic clk_out
    );

    logic osc_300;
    logic clk_fb;

    IBUFDS IBUFDS_inst (
        .O(osc_300),
        .I(osc_300_pn[0]),
        .IB(osc_300_pn[1])
    );

    MMCME3_BASE #(
        .CLKFBOUT_MULT_F(2.0),
        .CLKIN1_PERIOD(3.333),
        .CLKOUT0_DIVIDE_F(60.0)
    )
    MMCME3_BASE_inst (
        .CLKOUT0(clk_out),
        .CLKFBOUT(clk_fb),
        .CLKIN1(osc_300),
        .CLKFBIN(clk_fb)
    );

    assign out = in;
endmodule
