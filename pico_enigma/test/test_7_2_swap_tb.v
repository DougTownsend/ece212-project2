module test_7_2_swap_tb();
    // Test 7.2: en, a, and b change one at a time.
    reg en;
    reg [3:0] a, b;
    wire [3:0] x, y;
    integer outfile;

    swap uut(.en(en), .a(a), .b(b), .x(x), .y(y));

    initial begin
        $dumpvars(0, test_7_2_swap_tb);
        outfile = $fopen("test/results/test_7_2_swap.txt", "w");
        $fdisplay(outfile, "time,en,a,b,x,y");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%0d,%0d,%0d,%0d", $time, en, a, b, x, y);
        #0;  // let every always @(*) block start before the inputs change

        en = 0; a = 3; b = 10; #10;
        en = 1; #10;
        a = 6; #10;
        b = 1; #10;
        en = 0; #10;
        a = 15; #10;
        b = 8; #10;
        en = 1; #10;
        a = 0; #10;
        en = 0; #10;
        $finish;
    end
endmodule
