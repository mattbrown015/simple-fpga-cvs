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
    logic in[4:0] = '{ 0, 0, 0, 0, 0 };
    logic in0_out;
    logic in0_and_in1_out;
    logic in0_or_in1_out;
    logic not_in2_out;

    logic osc_300_p;
    logic osc_300_n;
    logic clk_1point5hz;

    always begin
        osc_300_p = 1'b0;
        osc_300_n = 1'b1;
        #(osc_300_period / 2) osc_300_p = 1'b1;
        osc_300_n = 1'b0;
        #(osc_300_period / 2);
    end

    initial begin
        $display ("start");

        #(100 * osc_300_period)

        $display ("finish");
        $finish;
    end

    in0_out_tb in0_out_tb(in[0], in0_out);
    in0_and_in1_out_tb in0_and_in1_out_tb(in[0], in[1], in0_and_in1_out);
    in0_or_in1_out_tb in0_or_in1_out_tb(in[0], in[1], in0_or_in1_out);
    not_in2_out_tb not_in2_out_tb(in[2], not_in2_out);

    simple_fpga_cvs simple_fpga_cvs(in, in0_out, in0_and_in1_out, in0_or_in1_out, not_in2_out, osc_300_p, osc_300_n, clk_1point5hz);
endmodule

module in0_out_tb(output logic in0, input in0_out);
    function check_in0_out(input logic in0, input logic in0_out);
        $display ("check_in0_out");
        if (in0_out != in0) begin
            $display ("in0_out != in0");
            return 0;
        end
        return 1;
    endfunction

    initial begin
        #1
        in0 = 0;
        #0.001
        if (check_in0_out(in0, in0_out) != 1) $finish;

        #1
        in0 = 1;
        #0.001
        if (check_in0_out(in0, in0_out) != 1) $finish;
    end
endmodule

module in0_and_in1_out_tb(output logic in0, output logic in1, input in0_and_in1_out);
    function check_in0_and_in1_out(input logic in0, input logic in1, input logic in0_and_in1_out);
        $display ("check_in0_and_in1_out");
        if (in0_and_in1_out != (in0 && in1)) begin
            $display ("in0_and_in1_out != (in0 && in1)");
            return 0;
        end
        return 1;
    endfunction

    initial begin
        #10
        in0 = 0;
        in1 = 0;
        #0.001
        if (check_in0_and_in1_out(in0, in1, in0_and_in1_out) != 1) $finish;

        #1
        in0 = 1;
        in1 = 0;
        #0.001
        if (check_in0_and_in1_out(in0, in1, in0_and_in1_out) != 1) $finish;

        #1
        in0 = 0;
        in1 = 1;
        #0.001
        if (check_in0_and_in1_out(in0, in1, in0_and_in1_out) != 1) $finish;

        #1
        in0 = 1;
        in1 = 1;
        #0.001
        if (check_in0_and_in1_out(in0, in1, in0_and_in1_out) != 1) $finish;
    end
endmodule

module in0_or_in1_out_tb(output logic in0, output logic in1, input in0_or_in1_out);
    function check_in0_or_in1_out(input logic in0, input logic in1, input logic in0_or_in1_out);
        $display ("check_in0_or_in1_out");
        if (in0_or_in1_out != (in0 || in1)) begin
            $display ("in0_or_in1_out != (in0 || in1)");
            return 0;
        end
        return 1;
    endfunction

    initial begin
        #20
        in0 = 0;
        in1 = 0;
        #0.001
        if (check_in0_or_in1_out(in0, in1, in0_or_in1_out) != 1) $finish;

        #1
        in0 = 1;
        in1 = 0;
        #0.001
        if (check_in0_or_in1_out(in0, in1, in0_or_in1_out) != 1) $finish;

        #1
        in0 = 0;
        in1 = 1;
        #0.001
        if (check_in0_or_in1_out(in0, in1, in0_or_in1_out) != 1) $finish;

        #1
        in0 = 1;
        in1 = 1;
        #0.001
        if (check_in0_or_in1_out(in0, in1, in0_or_in1_out) != 1) $finish;
    end
endmodule

module not_in2_out_tb(output logic in2, input not_in2_out);
    function check_not_in2_out(input logic in2, input logic not_in2_out);
        $display ("check_not_in2_out");
        if (not_in2_out == in2) begin
            $display ("not_in2_out == in2");
            return 0;
        end
        return 1;
    endfunction

    initial begin
        #30
        in2 = 0;
        #0.001
        if (check_not_in2_out(in2, not_in2_out) != 1) $finish;

        #1
        in2 = 1;
        #0.1
        if (check_not_in2_out(in2, not_in2_out) != 1) $finish;
    end
endmodule
