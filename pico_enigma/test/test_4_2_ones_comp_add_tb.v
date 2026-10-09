module test_4_2_ones_comp_add_tb();
    // Test 4.2: a and b change one at a time.
    reg [3:0] a, b;
    wire [3:0] out;
    integer outfile;

    ones_comp_add uut(.a(a), .b(b), .out(out));

    initial begin
        $dumpvars(0, test_4_2_ones_comp_add_tb);
        outfile = $fopen("test/results/test_4_2_ones_comp_add.txt", "w");
        $fdisplay(outfile, "time,a,b,out");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%0d,%0d,%0d", $time, a, b, out);
        #0;  // let every always @(*) block start before the inputs change

        a = 5; b = 3; #10;
        b = 12; #10;
        a = 9; #10;
        b = 6; #10;
        a = 15; #10;
        b = 0; #10;
        a = 0; #10;
        b = 15; #10;
        a = 1; #10;
        b = 14; #10;
        a = 3; #10;
        b = 1; #10;
        $finish;
    end
endmodule
