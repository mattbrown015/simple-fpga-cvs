`timescale 1ps / 1ps

module simple_fpga_cvs(
    input logic in[4:0],
    output logic in0_out,
    output logic in0_and_in1_out,
    output logic in0_or_in1_out,
    output logic not_in2_out,
    input logic osc_300_pn[1:0],
    output logic clk_1point2hz
    );

    logic osc_300;
    logic clk_10mhz;
    logic clk_fb;
    logic [22:0] clk_10mhz_count = 0;

    IBUFDS IBUFDS_inst (
        .O(osc_300),
        .I(osc_300_pn[0]),
        .IB(osc_300_pn[1])
    );

    PLLE3_BASE #(
        .CLKFBOUT_MULT(2),
        .CLKIN_PERIOD(3.333),
        .CLKOUT0_DIVIDE(60.0)
    )
    PLLE3_BASE_inst (
        .CLKOUT0(clk_10mhz),
        .CLKFBOUT(clk_fb),
        .CLKIN(osc_300),
        .CLKFBIN(clk_fb)
    );

    assign in0_out = in[0];
    assign in0_and_in1_out = in[0] && in[1];
    assign in0_or_in1_out = in[0] || in[1];
    assign not_in2_out = !in[2];

    // 10000000/2^22 = 2.384185791015625
    // Bit 22 will toggle at 2.38 Hz hence the real frquency is 2.38/2 = 1.2 Hz
    assign clk_1point2hz = clk_10mhz_count[22];

    always @(posedge clk_10mhz)
    begin
        // Ignore overflow
        clk_10mhz_count <= clk_10mhz_count + 1;
    end
endmodule
