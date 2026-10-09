module test_5_4_enigma_tb();
    // Test 5.4: load a seed and let the key change every clock. Seed changes while reset is low should do nothing.
    reg clk;
    reg reset;
    reg [7:0] seed;
    reg [3:0] in;
    wire [3:0] out, key;
    integer outfile;

    enigma uut(.clk(clk), .reset(reset), .seed(seed), .in(in), .out(out), .key(key));

    // The clock has a period of 10, with rising edges at 5, 15, 25, ...
    always #5 clk = ~clk;

    initial begin
        $dumpvars(0, test_5_4_enigma_tb);
        outfile = $fopen("test/results/test_5_4_enigma.txt", "w");
        $fdisplay(outfile, "time,reset,seed,in,out,key");
        clk = 0;

        reset = 1; seed = 8'hD3; in = 0; #10;  // load the seed
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%h,%0d,%0d,%0d", $time, reset, seed, in, out, key);

        reset = 0; #10;
        in = 7; #10;
        in = 2; #10;
        in = 13; #10;
        in = 0; #10;
        in = 9; #10;
        in = 4; #10;
        in = 15; #10;
        in = 11; #10;
        in = 6; #10;
        in = 1; #10;
        seed = 8'h01; #10;  // no effect, reset is low
        in = 10; #10;
        in = 3; #10;
        in = 14; #10;
        in = 8; #10;
        in = 5; #10;
        in = 12; #10;
        in = 2; #10;
        in = 7; #10;
        in = 0; #10;
        in = 9; #10;
        reset = 1; #10;  // load seed 0x01
        reset = 0; #10;
        in = 7; #10;
        in = 2; #10;
        in = 13; #10;
        in = 0; #10;
        in = 9; #10;
        in = 4; #10;
        in = 15; #10;
        in = 11; #10;
        $finish;
    end
endmodule
