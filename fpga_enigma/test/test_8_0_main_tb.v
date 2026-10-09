module test_8_0_main_tb();
    // Test 8.0: reset loads the seed. Changing the switches without a clock changes in and out, but not key.
    reg clk;
    reg [3:0] btn;
    reg [7:0] sw;
    wire strobe, data, shift_clk;
    integer outfile;

    main uut(.clk(clk), .btn(btn), .sw(sw), .strobe(strobe), .data(data), .shift_clk(shift_clk));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ... Buttons must be held for 11 clocks to get through debounce.
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_8_0_main_tb);
        outfile = $fopen("test/results/test_8_0_main.txt", "w");
        $fdisplay(outfile, "time,btn,sw,led,seven_seg");
        clk = 0;

        btn = 4'b0010; sw = 8'h3A; #200;  // press reset long enough to get through debounce
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%b,%b,%b", $time, btn, sw, uut.led, uut.seven_seg);

        btn = 4'b0000; #200;  // release reset
        sw = 8'h35; #50;
        sw = 8'h3F; #50;
        sw = 8'hF0; #50;
        sw = 8'h09; #50;
        $finish;
    end
endmodule
