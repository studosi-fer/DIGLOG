/* Verilog model created from schematic tenk_upravljac.sch -- Oct 22, 2017 17:52 */

module tenk_upravljac( btn_center, btn_down, btn_left, btn_right, btn_up, clk_25m, led,
                       p_ring, p_tip, sw );
 input btn_center;
 input btn_down;
 input btn_left;
 input btn_right;
 input btn_up;
 input clk_25m;
output [7:0] led;
output p_ring;
output [3:0] p_tip;
 input [3:0] sw;
wire N_23;
wire N_24;
wire N_25;
wire N_26;
wire N_27;
wire N_28;
wire N_29;
wire N_30;
wire N_17;
wire N_22;
wire N_14;
wire N_16;



INV I6 ( .A(btn_center), .Z(N_27) );
AND2 I26 ( .A(btn_left), .B(btn_right), .Z(N_23) );
AND2 I27 ( .A(btn_center), .B(btn_up), .Z(N_22) );
AND2 I28 ( .A(btn_center), .B(btn_down), .Z(N_24) );
AND2 I29 ( .A(btn_center), .B(btn_right), .Z(N_25) );
AND2 I30 ( .A(btn_center), .B(btn_left), .Z(N_26) );
AND2 I31 ( .A(N_27), .B(btn_left), .Z(N_28) );
AND2 I32 ( .A(N_27), .B(btn_right), .Z(N_30) );
AND2 I8 ( .A(N_27), .B(btn_down), .Z(N_29) );
AND2 I10 ( .A(N_27), .B(btn_up), .Z(N_17) );
AND3 I11 ( .A(btn_down), .B(btn_up), .C(N_27), .Z(N_16) );
OB I19 ( .I(N_30), .O(led[3]) );
OB I18 ( .I(N_29), .O(led[1]) );
OB I20 ( .I(N_28), .O(led[2]) );
OB I21 ( .I(N_17), .O(led[0]) );
OB I22 ( .I(N_26), .O(led[4]) );
OB I23 ( .I(N_24), .O(led[6]) );
OB I24 ( .I(N_25), .O(led[5]) );
OB I25 ( .I(N_22), .O(led[7]) );
OB I5 ( .I(N_14), .O(p_tip[1]) );
OB I4 ( .I(N_14), .O(p_tip[0]) );
OB I3 ( .I(N_14), .O(p_tip[2]) );
OB I2 ( .I(N_14), .O(p_tip[3]) );
OB I1 ( .I(N_14), .O(p_ring) );
rf_modulator I12 ( .brzina(sw[3:2]), .clk(clk_25m), .desno(N_30),
                .kanal(sw[1:0]), .lijevo(N_28), .motor(N_16), .naprijed(N_17),
                .natrag(N_29), .rf(N_14), .strojnica(N_23), .top_desno(N_25),
                .top_lijevo(N_26), .top_visina(N_24), .top_zvuk(N_22) );

endmodule // tenk_upravljac
