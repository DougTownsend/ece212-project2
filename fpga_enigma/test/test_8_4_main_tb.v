module test_8_4_main_tb();
    // Test 8.4: button presses shorter than the debounce time should be ignored. The raw btn[1] (not the debounced one) must be used as reset.
    reg clk;
    reg [3:0] btn;
    reg [7:0] sw;
    wire strobe, data, shift_clk;
    integer outfile;

    main uut(.clk(clk), .btn(btn), .sw(sw), .strobe(strobe), .data(data), .shift_clk(shift_clk));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ... Buttons must be held for 11 clocks to get through debounce.
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_8_4_main_tb);
        outfile = $fopen("test/results/test_8_4_main.txt", "w");
        $fdisplay(outfile, "time,btn,sw,led,seven_seg");
        clk = 0;

        btn = 4'b0010; sw = 8'h4E; #200;  // press reset long enough to get through debounce
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%b,%b,%b", $time, btn, sw, uut.led, uut.seven_seg);

        btn = 4'b0000; #200;  // release reset
        btn = 4'b0001; #30;  // bounce
        btn = 4'b0000; #30;
        btn = 4'b0001; #50;  // bounce
        btn = 4'b0000; #50;
        btn = 4'b0001; #200;  // real press
        btn = 4'b0000; #30;  // bounce on release
        btn = 4'b0001; #30;
        btn = 4'b0000; #200;
        sw = 8'h80; #50;
        btn = 4'b0010; #50;  // reset bounce, seed is not loaded
        btn = 4'b0000; #200;
        btn = 4'b0001; #200;
        btn = 4'b0000; #200;
        sw = 8'hB2; #50;
        btn = 4'b0001; #100;  // press clock, debounced btn[0] rises in 10 more time units
        btn = 4'b0011; #10;  // tap reset as the clock rises, seed is loaded
        btn = 4'b0001; #190;
        btn = 4'b0000; #200;
        $finish;
    end
endmodule
