module SC_BUF (A, Y);
input A;
output Y;
buf U1 (Y, A);
endmodule

module SC_IP5 (A, Y);
input A;
output Y;
//IP5 Black box
endmodule

module SC_IP6 (A, Y);
input A;
output Y;
//IP6 Black box
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
