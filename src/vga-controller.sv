module vga_controller (
    input  logic        clk,
    input  logic        reset,

    output logic [10:0] pixel_x,     // Horizontal pixel position
    output logic [9:0]  pixel_y,     // Vertical line position
    output logic        hsync,
    output logic        vsync,
    output logic        video_on,
	 output logic [3:0]  red,
    output logic [3:0]  green,
    output logic [3:0]  blue
);

    // ─────────────────────────────────────
    // Intermediate Signals
    // ─────────────────────────────────────
    logic video_on_h, video_on_v;
    logic line_done;

    // ─────────────────────────────────────
    // HSYNC Controller Instance
    // ─────────────────────────────────────
    fsm_hsync hsync_inst (
        .clk        (clk),
        .reset      (reset),
        .pixel_x    (pixel_x),
        .hsync      (hsync),
        .video_on_h (video_on_h),
        .line_done  (line_done)
    );

    // ─────────────────────────────────────
    // VSYNC Controller Instance
    // ─────────────────────────────────────
    fsm_vsync vsync_inst (
        .clk        (clk),
        .reset      (reset),
        .line_done  (line_done),
        .pixel_y    (pixel_y),
        .vsync      (vsync),
        .video_on_v (video_on_v)
    );
	 
	 // ─────────────────────────────────────
	 // Instantiate RGB pattern generator
    // ─────────────────────────────────────
	 video_pattern pattern_inst (
		.pixel_x  (pixel_x),
		.pixel_y  (pixel_y),
		.video_on (video_on),
		.red      (red),
		.green    (green),
		.blue     (blue)
    );
	 
    // ─────────────────────────────────────
    // Final Output Logic
    // ─────────────────────────────────────
    assign video_on = video_on_h && video_on_v;

	 
endmodule
