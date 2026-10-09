module test_5_3_enigma_tb();
    // Test 5.3: reset is held high with seed 0xC7. random[1:0] = 11, so negate, sbox, and XOR are used.
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
        $dumpvars(0, test_5_3_enigma_tb);
        outfile = $fopen("test/results/test_5_3_enigma.txt", "w");
        $fdisplay(outfile, "time,reset,seed,in,out,key");
        clk = 0;

        reset = 1; seed = 8'hC7; in = 0; #10;  // load the seed
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%h,%0d,%0d,%0d", $time, reset, seed, in, out, key);

        in = 0; #10;
        in = 1; #10;
        in = 2; #10;
        in = 3; #10;
        in = 4; #10;
        in = 5; #10;
        in = 6; #10;
        in = 7; #10;
        in = 8; #10;
        in = 9; #10;
        in = 10; #10;
        in = 11; #10;
        in = 12; #10;
        in = 13; #10;
        in = 14; #10;
        in = 15; #10;
        $finish;
    end
endmodule
