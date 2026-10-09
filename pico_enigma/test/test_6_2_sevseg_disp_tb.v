module test_6_2_sevseg_disp_tb();
    // Test 6.2: in and dp change one at a time.
    reg [3:0] in;
    reg dp;
    wire [7:0] segs;
    integer outfile;

    sevseg_disp uut(.in(in), .dp(dp), .segs(segs));

    initial begin
        $dumpvars(0, test_6_2_sevseg_disp_tb);
        outfile = $fopen("test/results/test_6_2_sevseg_disp.txt", "w");
        $fdisplay(outfile, "time,in,dp,segs");
        // Writes a line to the file every time one of the signals changes
        $fmonitor(outfile, "%0t,%h,%b,%b", $time, in, dp, segs);
        #0;  // let every always @(*) block start before the inputs change

        dp = 0; in = 4'h8; #10;
        dp = 1; #10;
        dp = 0; #10;
        in = 4'h3; #10;
        dp = 1; #10;
        in = 4'hA; #10;
        dp = 0; #10;
        in = 4'h1; #10;
        dp = 1; #10;
        in = 4'hE; #10;
        $finish;
    end
endmodule
