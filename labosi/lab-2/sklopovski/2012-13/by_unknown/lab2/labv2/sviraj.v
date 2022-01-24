/* Verilog model created from schematic sviraj.sch -- Oct 21, 2013 13:32 */

module sviraj( btn_center, btn_down, btn_left, btn_right, btn_up, clk_25m, led_0, led_1,
               led_2, led_3, led_4, led_5, led_6, led_7, p_ring, p_tip_0,
               p_tip_1, p_tip_2, p_tip_3, sw_0, sw_1 );
 input btn_center;
 input btn_down;
 input btn_left;
 input btn_right;
 input btn_up;
 input clk_25m;
output led_0;
output led_1;
output led_2;
output led_3;
output led_4;
output led_5;
output led_6;
output led_7;
output p_ring;
output p_tip_0;
output p_tip_1;
output p_tip_2;
output p_tip_3;
 input sw_0;
 input sw_1;
wire N_10;

wire N_11;

wire N_12;

wire N_13;

wire N_14;

wire N_15;

wire N_16;

wire N_9;




enkoder I34 ( .code_0(N_10), .code_1(N_11), .code_2(N_12), .code_3(N_13),
           .code_4(N_14), .code_5(N_15), .code_6(N_16),
           .enc_center(btn_center), .enc_down(btn_down), .enc_left(btn_left),
           .enc_right(btn_right), .enc_up(btn_up) );
OB I29 ( .I(N_9), .O(p_ring) );
OB I30 ( .I(N_9), .O(p_tip_3) );
OB I31 ( .I(N_9), .O(p_tip_2) );
OB I32 ( .I(N_9), .O(p_tip_1) );
OB I33 ( .I(N_9), .O(p_tip_0) );
OB I21 ( .I(N_14), .O(led_4) );
OB I22 ( .I(N_15), .O(led_5) );
OB I23 ( .O(led_7) );
OB I24 ( .I(N_16), .O(led_6) );
OB I25 ( .I(N_13), .O(led_3) );
OB I26 ( .I(N_12), .O(led_2) );
OB I27 ( .I(N_11), .O(led_1) );
OB I28 ( .I(N_10), .O(led_0) );
tonegen I1 ( .clk_25m(clk_25m), .code({ N_16,N_15,N_14,N_13,N_12,N_11,N_10 }),
          .tone_out(N_9), .volume({ sw_1,sw_0 }) );

endmodule // sviraj
