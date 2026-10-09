module test_7_1_swap_tb();
    // Test 7.1: en is 1, so x = b and y = a.
    reg en;
    reg [3:0] a, b;
    wire [3:0] x, y;
    integer outfile;

    swap uut(.en(en), .a(a), .b(b), .x(x), .y(y));

    initial begin
        $dumpvars(0, test_7_1_swap_tb);
        outfile = $fopen("test/results/test_7_1_swap.txt", "w");
        $fdisplay(outfile, "time,en,a,b,x,y");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%0d,%0d,%0d,%0d", $time, en, a, b, x, y);
        #0;  // let every always @(*) block start before the inputs change

        en = 1; a = 0; b = 15; #10;
        en = 1; a = 1; b = 2; #10;
        en = 1; a = 3; b = 12; #10;
        en = 1; a = 9; b = 6; #10;
        en = 1; a = 10; b = 5; #10;
        en = 1; a = 7; b = 7; #10;
        en = 1; a = 14; b = 0; #10;
        en = 1; a = 4; b = 11; #10;
        $finish;
    end
endmodule
