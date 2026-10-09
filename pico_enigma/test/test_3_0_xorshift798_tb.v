module test_3_0_xorshift798_tb();
    // Test 3.0: reset is held high, so random should load each new seed.
    reg clk;
    reg reset;
    reg [15:0] seed;
    wire [15:0] random;
    integer outfile;

    xorshift798 uut(.clk(clk), .reset(reset), .seed(seed), .random(random));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ...
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_3_0_xorshift798_tb);
        outfile = $fopen("test/results/test_3_0_xorshift798.txt", "w");
        $fdisplay(outfile, "time,reset,seed,random");
        clk = 0;

        reset = 1; seed = 16'h0001; #10;  // load the first seed
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%h,%h", $time, reset, seed, random);

        seed = 16'hACE1; #10;
        seed = 16'hFFFF; #10;
        seed = 16'h8000; #10;
        seed = 16'h1234; #10;
        seed = 16'h00FF; #10;
        $finish;
    end
endmodule
