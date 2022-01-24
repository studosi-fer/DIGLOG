/* Verilog model created from schematic enkoder.sch -- Oct 21, 2013 13:32 */

module enkoder( code_0, code_1, code_2, code_3, code_4, code_5, code_6, enc_center,
                enc_down, enc_left, enc_right, enc_up );
output code_0;
output code_1;
output code_2;
output code_3;
output code_4;
output code_5;
output code_6;
 input enc_center;
 input enc_down;
 input enc_left;
 input enc_right;
 input enc_up;
wire N_7;

wire N_1;

wire N_2;

wire N_3;

wire N_4;

wire N_5;

wire N_6;




VLO I32 ( .Z(code_5) );
OR4 I33 ( .A(enc_right), .B(enc_up), .C(enc_center), .D(enc_left), .Z(code_6) );
AND2 I34 ( .A(enc_down), .B(code_6), .Z(code_4) );
AND2 I35 ( .A(N_6), .B(code_6), .Z(code_3) );
AND2 I36 ( .A(enc_center), .B(N_6), .Z(N_7) );
AND2 I37 ( .A(enc_center), .B(enc_down), .Z(N_2) );
AND2 I38 ( .A(enc_left), .B(N_6), .Z(N_1) );
AND2 I39 ( .A(enc_left), .B(enc_down), .Z(N_4) );
AND2 I40 ( .A(N_6), .B(N_5), .Z(N_3) );
OR2 I41 ( .A(N_4), .B(N_3), .Z(code_0) );
OR2 I42 ( .A(enc_right), .B(enc_up), .Z(N_5) );
OR3 I43 ( .A(enc_right), .B(enc_up), .C(N_7), .Z(code_2) );
OR3 I44 ( .A(enc_right), .B(N_2), .C(N_1), .Z(code_1) );
INV I11 ( .A(enc_down), .Z(N_6) );

endmodule // enkoder
