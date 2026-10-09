module test_3_2_xorshift798_tb();
    // Test 3.2: seed changes while reset is low should do nothing. Then reset with a new seed.
    reg clk;
    reg reset;
    reg [15:0] seed;
    wire [15:0] random;
    integer outfile;

    xorshift798 uut(.clk(clk), .reset(reset), .seed(seed), .random(random));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ...
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_3_2_xorshift798_tb);
        outfile = $fopen("test/results/test_3_2_xorshift798.txt", "w");
        $fdisplay(outfile, "time,reset,seed,random");
        clk = 0;

        reset = 1; seed = 16'hACE1; #10;  // load the seed
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%h,%h", $time, reset, seed, random);

        reset = 0; #30;
        seed = 16'h5555; #50;
        reset = 1; seed = 16'hBEEF; #10;
        reset = 0; #40;
        seed = 16'h0000; #40;
        $finish;
    end
endmodule
