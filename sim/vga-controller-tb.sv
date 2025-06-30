`timescale 1ns/1ps

module vga_tb;

    // ─────────────────────────────────────
    // Testbench Signals
    // ─────────────────────────────────────
    logic clk;
    logic reset;
    logic [10:0] pixel_x;
    logic [9:0]  pixel_y;
    logic hsync, vsync, video_on;
    logic [3:0] red, green, blue;

    // ─────────────────────────────────────
    // Clock Generation (65 MHz = 15.384 ns period)
    // ─────────────────────────────────────
    parameter real CLK_PERIOD_NS = 15.384;

	 initial clk = 0;
	 always #(CLK_PERIOD_NS / 2.0) clk = ~clk;


    // ─────────────────────────────────────
    // DUT Instantiation
    // ─────────────────────────────────────
	 vga_controller dut (
	 	.clk       (clk),
	 	.reset     (reset),
	 	.pixel_x   (pixel_x),
	 	.pixel_y   (pixel_y),
	 	.hsync     (hsync),
	 	.vsync     (vsync),
	 	.video_on  (video_on),
	 	.red       (red),
	 	.green     (green),
	 	.blue      (blue)
	 );


    // RGB outputs are internal to vga_controller — you can optionally wire them out
    // or monitor them from pattern module if needed.

    // ─────────────────────────────────────
    // Simulation Control
    // ─────────────────────────────────────
    initial begin
        // Dump VCD waveform for GTKWave
        $dumpfile("vga_tb.vcd");
        $dumpvars(0, vga_tb);

        // Reset for first 100 ns
        reset = 1;
        #100;
        reset = 0;

        // Run enough time to see a few frames (e.g. ~3 ms)
        #33000000;

        $display("Simulation complete.");
        $finish;
    end

endmodule
