module sevseg_disp(
    input [3:0] in,
    input dp,
    output reg [7:0] segs
);
    /*
    Takes in a 4 bit value and decimal point
    outputs signals for the 8 LEDs on the display
    Segments are assigned a=seg[0], b=seg[1], etc.
    seg[7] is the decimal point.
    Displays the hexadecimal value of the 4 bit input.
    Decimal point is controled by the dp input.
    */
    //Do not modify above this line


endmodule