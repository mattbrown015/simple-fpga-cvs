// timescale directive to define meaning of timestep
// `timescale <time_unit>/<time_precision>
// The simulation log contained this message 'Time resolution is 1 ps'
// regardless of the timescale set here. I'm guessing that there is
// a global setting and making this the same will help the simulation.
// Also guessing that it is easier if time unit and precision are the same.
`timescale 1ps / 1ps

module simple_fpga_cvs_tb();
    // 'reg' can store a logic state
    reg clock;
    wire out[4:0];

    reg osc_300;
    wire osc_300_pn[1:0];

    assign osc_300_pn = '{osc_300, !osc_300};

    always begin
        // '#' is unsynthesizable element that specifies simulation delay
        #1 clock = !clock;
    end

    always begin
        // The timescale precision is 1ps so the .666 will be ignored.
        // Changing the timescale precision to 1fs makes it possible to see the .666ps in the waveform but I feel that 1fs precision is unnecessary
        // I assume increasing the precision slows the simulation.
        #1666.666 osc_300 = !osc_300; // 300 MHz, period is 3333.333 ps but the state change frequency is 600 MHz so delay is 1666.666
    end

    initial begin
        clock = 0;
        osc_300 = 0;
    end

    simple_fpga_cvs simple_fpga_cvs('{clock, clock, clock, clock, clock}, out);
endmodule
