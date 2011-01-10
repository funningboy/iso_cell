module TOP(D1, Y2, Y3, ISO);
input D1,ISO;
output Y2, Y3;
wire I1_Y;
SC_BUF I1(.Y(I1_Y), .A(D1));
SC_IP5 I2(.Y(Y2), .A(I1_Y));
SC_IP6 I3(.Y(Y3), .A(I1_Y));
endmodule


