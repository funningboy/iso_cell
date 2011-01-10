module TOP(D1,D2,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,ISOB,ISOC);
  input   D1, D2, ISOB, ISOC;
  output Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8;
  wire   I1_Y,IB_Y,IC_Y,I2_Y,I3_Y,I5_Y1,I5_Y2,I5_Y3,I6_Y1,I6_Y2,I6_Y3;
  SC_BUF    I1(.Y(I1_Y), .A(D1));
  SC_BUF    I4(.Y(Y2), .A(IB_Y2));
  BLKB      IB(.Y1(IB_Y1), .A1(I1_Y), .Y2(IB_Y2), .A2(IC_Y2));
  BLKC      IC(.Y1(IC_Y1), .A1(IB_Y1), .Y2(IC_Y2), .A2(I2_Y));
  SC_BUF    I2(.Y(Y1),   .A(IC_Y1));
  SC_BUF    I3(.Y(I2_Y), .A(D2));
  BLKD I5(.Y1(I5_Y1), .Y2(I5_Y2), .Y3(I5_Y3), .A1(IB_Y2), .A2(IC_Y1));
  BLKE I6(.Y1(I6_Y1), .Y2(I6_Y2), .Y3(I6_Y3), .A1(IB_Y2), .A2(IC_Y1));
  SC_BUF    I7(.Y(Y3),  .A(I5_Y1));
  SC_BUF    I8(.Y(Y4),   .A(I5_Y2));
  SC_BUF    I9(.Y(Y6),   .A(I6_Y1));
  SC_BUF    I10(.Y(Y7),  .A(I6_Y2));
  SC_BUF    I11(.Y(Y5),  .A(I5_Y3));
  SC_BUF    I12(.Y(Y8),  .A(I6_Y3));
endmodule

