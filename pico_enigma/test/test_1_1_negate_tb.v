module test_1_1_negate_tb();
    // Test 1.1: en is 1, so out should be -in for every input.
    reg en;
    reg [3:0] in;
    wire [3:0] out;
    integer outfile;

    negate uut(.en(en), .in(in), .out(out));

    initial begin
        $dumpvars(0, test_1_1_negate_tb);
        outfile = $fopen("test/results/test_1_1_negate.txt", "w");
        $fdisplay(outfile, "time,en,in,out");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%b,%0d,%0d", $time, en, in, out);
        #0;  // let every always @(*) block start before the inputs change

        en = 1; in = 0; #10;
        en = 1; in = 1; #10;
        en = 1; in = 2; #10;
        en = 1; in = 3; #10;
        en = 1; in = 4; #10;
        en = 1; in = 5; #10;
        en = 1; in = 6; #10;
        en = 1; in = 7; #10;
        en = 1; in = 8; #10;
        en = 1; in = 9; #10;
        en = 1; in = 10; #10;
        en = 1; in = 11; #10;
        en = 1; in = 12; #10;
        en = 1; in = 13; #10;
        en = 1; in = 14; #10;
        en = 1; in = 15; #10;
        $finish;
    end
endmodule
