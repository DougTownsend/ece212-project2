module test_4_1_ones_comp_add_tb();
    // Test 4.1: sums with a carry out, which must be added back in.
    reg [3:0] a, b;
    wire [3:0] out;
    integer outfile;

    ones_comp_add uut(.a(a), .b(b), .out(out));

    initial begin
        $dumpvars(0, test_4_1_ones_comp_add_tb);
        outfile = $fopen("test/results/test_4_1_ones_comp_add.txt", "w");
        $fdisplay(outfile, "time,a,b,out");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%0d,%0d,%0d", $time, a, b, out);
        #0;  // let every always @(*) block start before the inputs change

        a = 1; b = 15; #10;
        a = 15; b = 1; #10;
        a = 8; b = 8; #10;
        a = 9; b = 9; #10;
        a = 15; b = 15; #10;
        a = 14; b = 2; #10;
        a = 10; b = 10; #10;
        a = 12; b = 7; #10;
        a = 7; b = 12; #10;
        a = 11; b = 13; #10;
        a = 15; b = 8; #10;
        a = 6; b = 13; #10;
        a = 13; b = 13; #10;
        a = 4; b = 14; #10;
        a = 9; b = 7; #10;
        a = 5; b = 11; #10;
        $finish;
    end
endmodule
