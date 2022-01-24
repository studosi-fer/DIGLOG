/* Verilog model created from schematic lab2.sch -- Nov 05, 2017 19:41 */

module lab2( btn_center, btn_down, btn_left, btn_right, btn_up, clk_25m, led, rs232_tx );
 input btn_center;
 input btn_down;
 input btn_left;
 input btn_right;
 input btn_up;
 input clk_25m;
output [7:0] led;
output rs232_tx;
wire N_26;
wire N_27;
wire N_28;
wire N_29;
wire N_23;
wire N_24;
wire N_25;
wire N_9;
wire N_11;
wire N_12;
wire N_14;
wire N_15;
wire N_16;
wire N_17;
wire N_18;
wire N_19;
wire N_20;
wire N_21;
wire N_8;



VLO I42 ( .Z(N_15) );
OR5 I60 ( .A(btn_right), .B(N_14), .C(N_9), .D(N_29), .E(N_26), .Z(N_18) );
OR5 I43 ( .A(btn_right), .B(btn_up), .C(N_14), .D(N_11), .E(N_29), .Z(N_21) );
OR3 I44 ( .A(N_14), .B(N_9), .C(N_29), .Z(N_8) );
INV I45 ( .A(btn_center), .Z(N_12) );
INV I46 ( .A(btn_down), .Z(N_23) );
AND2 I61 ( .A(btn_up), .B(btn_down), .Z(N_26) );
AND2 I56 ( .A(btn_down), .B(btn_right), .Z(N_27) );
AND2 I57 ( .A(btn_down), .B(btn_up), .Z(N_24) );
AND2 I58 ( .A(N_23), .B(btn_right), .Z(N_25) );
AND2 I59 ( .A(N_23), .B(btn_left), .Z(N_28) );
AND2 I47 ( .A(btn_down), .B(btn_left), .Z(N_9) );
AND2 I48 ( .A(btn_down), .B(btn_center), .Z(N_29) );
AND2 I49 ( .A(btn_left), .B(N_12), .Z(N_11) );
AND2 I50 ( .A(N_23), .B(btn_center), .Z(N_14) );
OR2 I51 ( .A(N_28), .B(N_25), .Z(N_19) );
OR4 I52 ( .A(N_29), .B(N_28), .C(N_27), .D(btn_up), .Z(N_16) );
OR4 I53 ( .A(N_25), .B(N_14), .C(N_9), .D(N_24), .Z(N_17) );
OR4 I55 ( .A(btn_right), .B(btn_up), .C(N_29), .D(N_14), .Z(N_20) );
OB I19 ( .I(N_19), .O(led[3]) );
OB I18 ( .I(N_17), .O(led[1]) );
OB I20 ( .I(N_18), .O(led[2]) );
OB I21 ( .I(N_16), .O(led[0]) );
OB I22 ( .I(N_8), .O(led[4]) );
OB I23 ( .I(N_21), .O(led[6]) );
OB I24 ( .I(N_20), .O(led[5]) );
OB I25 ( .I(N_15), .O(led[7]) );
serial_tx I1 ( .byte_in({ N_15,N_21,N_20,N_8,N_19,N_18,N_17,N_16 }),
            .clk(clk_25m), .ser_out(rs232_tx) );

endmodule // lab2
