module BLKB(Y1,Y2,A1,A2);
  input A1,A2;
  output Y1,Y2;
  SC_BUF      IB1(.Y(Y1), .A(A1));
  SC_BUF      IB2(.Y(Y2), .A(A2));
endmodule

module BLKC(Y1,Y2,A1,A2);
  input A1,A2;
  output Y1,Y2;
  SC_BUF        IC1(.Y(Y1), .A(A1));
  SC_BUF        IC2(.Y(Y2), .A(A2));
endmodule

module BLKD(Y1, Y2, Y3, A1, A2);
  input A1, A2;
  output Y1, Y2, Y3;
  SC_IP2      ID1(.Y(Y1), .A(A1), .B(A2));
  SC_IP1      ID2(.Y(Y2), .A(A1), .B(A2));
  SC_BUF      ID3(.Y(Y3), .A(A1));
endmodule

module BLKE(Y1, Y2, Y3, A1, A2);
  input A1, A2;
  output Y1, Y2, Y3;
  SC_IP3      IE1(.Y(Y1), .A(A1), .B(A2));
  SC_IP4      IE2(.Y(Y2), .A(A1), .B(A2));
  SC_BUF      IE3(.Y(Y3), .A(A1));
endmodule

module SC_BUF (A, Y);
input A;
output Y;
  buf U1 (Y, A);
endmodule

module SC_IP1 (A, B, Y);
input A, B;
output Y;
  //IP1 Black Box
endmodule

module SC_IP2 (A, B, Y);
input A, B;
output Y;
  //IP2 Black Box
endmodule

module SC_IP3 (A, B, Y);
input A, B;
output Y;
  //IP3 Black Box
endmodule

module SC_IP4 (A, B, Y);
input A, B;
output Y;
  //IP4 Black Box
endmodule

module IsoLH (A, En, Y);
  input A, En;
  output Y;
     or U1(Y, En, A);
endmodule

module IsoHL (A, En, Y);
  input A, En;
  output Y;
     and U1(Y, En, A);
endmodule

