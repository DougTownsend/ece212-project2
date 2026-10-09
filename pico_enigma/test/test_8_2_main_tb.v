module test_8_2_main_tb();
    // Test 8.2: btn[2] swaps what is shown on led[3:0] and the seven segment display.
    reg clk;
    reg [3:0] btn;
    reg [7:0] sw;
    wire strobe, data, shift_clk;
    integer outfile;

    main uut(.clk(clk), .btn(btn), .sw(sw), .strobe(strobe), .data(data), .shift_clk(shift_clk));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ... Buttons must be held for 11 clocks to get through debounce.
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_8_2_main_tb);
        outfile = $fopen("test/results/test_8_2_main.txt", "w");
        $fdisplay(outfile, "time,btn,sw,led,seven_seg");
        clk = 0;

        btn = 4'b0010; sw = 8'h6B; #200;  // press reset long enough to get through debounce
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%b,%b,%b", $time, btn, sw, uut.led, uut.seven_seg);

        btn = 4'b0000; #200;  // release reset
        btn = 4'b0100; #50;  // swap
        sw = 8'h64; #50;
        btn = 4'b0000; #50;
        btn = 4'b0100; #50;
        btn = 4'b0101; #200;  // clock while swapped
        btn = 4'b0100; #200;
        sw = 8'h6E; #50;
        btn = 4'b0000; #50;
        $finish;
    end
endmodule
