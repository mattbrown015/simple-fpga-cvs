`timescale 1ps / 1ps

module simple_fpga_cvs(
    input wire clock,
    output wire clock_out
    );

    assign clock_out = clock;
endmodule
