// timescale directive to define meaning of timestep
// `timescale <time_unit>/<time_precision>
// The simulation log contained this message 'Time resolution is 1 ps'
// regardless of the timescale set here. I'm guessing that there is
// a global setting and making this the same will help the simulation.
// Also guessing that it is easier if time unit and precision are the same.
`timescale 1ns / 1ps

module simple_fpga_cvs_tb();
    parameter osc_300_period = 3.333;

    // 'reg' can store a logic state
    logic clock = 1'b0;
    logic in0_out;
    logic in0_and_in1_out;
    logic in0_or_in1_out;
    logic not_in2_out;

    logic osc_300_p;
    logic osc_300_n;
    logic clk_1point5hz;

    always #1 clock = !clock;

    always begin
        osc_300_p = 1'b0;
        osc_300_n = 1'b1;
        #(osc_300_period / 2) osc_300_p = 1'b1;
        osc_300_n = 1'b0;
        #(osc_300_period / 2);
    end

    initial begin
        $display ("start");

        #100

        $display ("finish");
        $finish;
    end

    simple_fpga_cvs simple_fpga_cvs('{clock, clock, clock, clock, clock}, in0_out, in0_and_in1_out, in0_or_in1_out, not_in2_out, osc_300_p, osc_300_n, clk_1point5hz);
endmodule
