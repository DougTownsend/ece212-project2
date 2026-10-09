module test_3_3_xorshift798_tb();
    // Test 3.3: a seed of 0 should be treated as 0x0100.
    reg clk;
    reg reset;
    reg [15:0] seed;
    wire [15:0] random;
    integer outfile;

    xorshift798 uut(.clk(clk), .reset(reset), .seed(seed), .random(random));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ...
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_3_3_xorshift798_tb);
        outfile = $fopen("test/results/test_3_3_xorshift798.txt", "w");
        $fdisplay(outfile, "time,reset,seed,random");
        clk = 0;

        reset = 1; seed = 16'h0000; #10;  // load the seed
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%h,%h", $time, reset, seed, random);

        reset = 0; #50;
        reset = 1; #10;
        reset = 0; #30;
        $finish;
    end
endmodule
