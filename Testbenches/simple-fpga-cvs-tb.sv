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

    always begin
        // '#' is unsynthesizable element that specifies simulation delay
        #1 clock = !clock;
    end

    initial begin
        clock = 0;
    end

    simple_fpga_cvs simple_fpga_cvs('{clock, clock, clock, clock, clock}, out);
endmodule
