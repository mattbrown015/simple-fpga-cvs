// timescale directive to define meaning of timestep
// `timescale <time_unit>/<time_precision>
// The simulation log contained this message 'Time resolution is 1 ps'
// regardless of the timescale set here. I'm guessing that there is
// a global setting and making this the same will help the simulation.
// Also guessing that it is easier if time unit and precision are the same.
`timescale 1ns / 1ps

module simple_fpga_cvs_tb();
    // 'reg' can store a logic state
    logic clock = 1'b0;
    logic in0_out;
    logic in0_and_in1_out;
    logic in0_or_in1_out;
    logic not_in2_out;

    logic osc_300 = 1'b0;
    logic osc_300_pn[1:0];
    logic clk_1point5hz;

    assign osc_300_pn = '{!osc_300, osc_300};

    always #1 clock = !clock;
    always #1.666 osc_300 = !osc_300; // 300 MHz, period is 3.333 ns but the state change frequency is 600 MHz so delay is 1.666

    initial begin
        $display ("start");

        #100

        $display ("finish");
        $finish;
    end

    simple_fpga_cvs simple_fpga_cvs('{clock, clock, clock, clock, clock}, in0_out, in0_and_in1_out, in0_or_in1_out, not_in2_out, osc_300_pn, clk_1point5hz);
endmodule
