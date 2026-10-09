module real_main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output strobe,
    output data,
    output shift_clk
);

    wire clk_1khz;
    clockdiv div_1khz(clk, 6000, clk_1khz);
    main m(clk_1khz, btn, sw, strobe, data, shift_clk);

endmodule