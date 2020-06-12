`timescale 1ps / 1ps

module simple_fpga_cvs(
    input logic in[4:0],
    output logic in0_out,
    output logic in0_and_in1_out,
    output logic in0_or_in1_out,
    output logic not_in2_out,
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

    assign in0_out = in[0];
    assign in0_and_in1_out = in[0] && in[1];
    assign in0_or_in1_out = in[0] || in[1];
    assign not_in2_out = !in[2];
endmodule
