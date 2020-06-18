`timescale 1ps / 1ps

module simple_fpga_cvs(
    input logic in[4:0],
    output logic in0_out,
    output logic in0_and_in1_out,
    output logic in0_or_in1_out,
    output logic not_in2_out,
    input logic osc_300_pn[1:0],
    output logic clk_1point5hz
    );

    logic osc_300;
    logic clk_100mhz;
    logic clk_fb;

    IBUFDS IBUFDS_inst (
        .O(osc_300),
        .I(osc_300_pn[0]),
        .IB(osc_300_pn[1])
    );

    PLLE3_BASE #(
        .CLKFBOUT_MULT(2),
        .CLKIN_PERIOD(3.333),
        .CLKOUT0_DIVIDE(6.0)
    )
    PLLE3_BASE_inst (
        .CLKOUT0(clk_100mhz),
        .CLKFBOUT(clk_fb),
        .CLKIN(osc_300),
        .CLKFBIN(clk_fb)
    );

    assign in0_out = in[0];
    assign in0_and_in1_out = in[0] && in[1];
    assign in0_or_in1_out = in[0] || in[1];
    assign not_in2_out = !in[2];

    generate_1point5hz_clk generate_1point5hz_clk_inst(clk_100mhz, clk_1point5hz);
endmodule

module generate_1point5hz_clk(
    input clk_100mhz,
    output logic clk_1point5hz
    );

    logic [25:0] clk_100mhz_count = 0;

    // 100000000/2^22 = 2.98023223876953125
    // Bit 25 will toggle at 2.98 Hz hence the real frquency is 2.98/2 = 1.49 Hz
    assign clk_1point5hz = clk_100mhz_count[25];

    always @(posedge clk_100mhz)
    begin
        // Ignore overflow
        clk_100mhz_count <= clk_100mhz_count + 1;
    end
endmodule
