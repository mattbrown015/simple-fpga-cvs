`timescale 1ps / 1ps

module simple_fpga_cvs(
    input wire in[4:0],
    output wire out[4:0],
    input wire osc_300_pn[1:0],
    output wire osc_300_out
    );

    assign out = in;
    assign osc_300_out = osc_300_pn[0];
endmodule
