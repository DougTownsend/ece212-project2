module test_8_1_main_tb();
    // Test 8.1: btn[0] clocks the enigma machine.
    reg clk;
    reg [3:0] btn;
    reg [7:0] sw;
    wire strobe, data, shift_clk;
    integer outfile;

    main uut(.clk(clk), .btn(btn), .sw(sw), .strobe(strobe), .data(data), .shift_clk(shift_clk));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ... Buttons must be held for 11 clocks to get through debounce.
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_8_1_main_tb);
        outfile = $fopen("test/results/test_8_1_main.txt", "w");
        $fdisplay(outfile, "time,btn,sw,led,seven_seg");
        clk = 0;

        btn = 4'b0010; sw = 8'hC5; #200;  // press reset long enough to get through debounce
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%b,%b,%b", $time, btn, sw, uut.led, uut.seven_seg);

        btn = 4'b0000; #200;  // release reset
        btn = 4'b0001; #200;  // press clock
        btn = 4'b0000; #200;  // release clock
        sw[3:0] = 4'hA; #50;
        btn = 4'b0001; #200;  // press clock
        btn = 4'b0000; #200;  // release clock
        sw[3:0] = 4'h2; #50;
        btn = 4'b0001; #200;  // press clock
        btn = 4'b0000; #200;  // release clock
        sw[3:0] = 4'h7; #50;
        btn = 4'b0001; #200;  // press clock
        btn = 4'b0000; #200;  // release clock
        sw[3:0] = 4'hF; #50;
        btn = 4'b0001; #200;  // press clock
        btn = 4'b0000; #200;  // release clock
        sw[3:0] = 4'h0; #50;
        btn = 4'b0010; sw = 8'h11; #200;  // reset with a new seed
        btn = 4'b0000; #200;
        btn = 4'b0001; #200;
        btn = 4'b0000; #200;
        $finish;
    end
endmodule
