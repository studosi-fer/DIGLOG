/* Verilog model created from schematic lego_upravljac.sch -- Oct 26, 2015 00:12 */

module lego_upravljac( btn_down, btn_left, btn_right, btn_up, clk_25m, led, p_ring,
                       p_tip, sw );
 input btn_down;
 input btn_left;
 input btn_right;
 input btn_up;
 input clk_25m;
output [7:0] led;
output p_ring;
output [3:0] p_tip;
 input [1:0] sw;
wire N_4;
wire N_5;
wire N_3;



OR2 I20 ( .A(btn_left), .B(btn_right), .Z(N_5) );
OR2 I21 ( .A(btn_up), .B(btn_down), .Z(N_4) );
lego_ir I9 ( .ch(sw[1:0]), .clk(clk_25m), .ir(N_3),
          .pwm_a({ btn_down,btn_up,btn_up,N_4 }),
          .pwm_b({ btn_right,btn_left,btn_left,N_5 }) );
OB I2 ( .I(N_3), .O(p_ring) );
OB I3 ( .I(N_3), .O(p_tip[0]) );
OB I4 ( .I(N_3), .O(p_tip[3]) );
OB I5 ( .I(N_3), .O(p_tip[2]) );
OB I6 ( .I(N_3), .O(p_tip[1]) );
OB I12 ( .I(btn_down), .O(led[7]) );
OB I13 ( .I(btn_up), .O(led[5]) );
OB I14 ( .I(btn_up), .O(led[6]) );
OB I15 ( .I(N_4), .O(led[4]) );
OB I16 ( .I(N_5), .O(led[0]) );
OB I17 ( .I(btn_left), .O(led[2]) );
OB I18 ( .I(btn_left), .O(led[1]) );
OB I19 ( .I(btn_right), .O(led[3]) );

endmodule // lego_upravljac
