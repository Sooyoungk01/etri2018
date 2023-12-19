module top_conv
#(parameter K_SIZE = 25, BW1 = 16, BW2 = 19)
(
    input              iCLK,
    input              iRSTn,
    input signed [7:0] iX,
    input signed [7:0] iW,
    input        [4:0] iADDR,
    input              iWren,
    input              iValid,
    output signed [15:0] oY,
    output oValid
);

localparam DELAY_NB1 = 27,
           DELAY_NB2 = 133;

// Fill in your code here
wire signed [7:0] buff_x;
wire signed [8*K_SIZE-1:0] kernel;
wire signed [5*BW2-1:0] oPsum;
wire signed [5*BW1-1:0] sat_oPsum;
wire signed [5*BW1-1:0] finaloPsum;
wire signed pre_ovalid;

in_data#(K_SIZE) in_data(iCLK, iRSTn, iX, iW, iADDR, iWren, iValid, buff_x, kernel);

filter#(K_SIZE, 1, BW1, BW2) filter1(iCLK, iRSTn, buff_x, kernel, 0, oPsum[BW2-1:0]);
sat#(BW2, BW1) sat1(oPsum[BW2-1:0], sat_oPsum[BW1-1:0]);
delay#(DELAY_NB1, BW1) delay1(iCLK, iRSTn, sat_oPsum[BW1-1:0], finaloPsum[BW1-1:0]);

filter#(K_SIZE, 2, BW1, BW2) filter2(iCLK, iRSTn, buff_x, kernel, finaloPsum[BW1-1:0], oPsum[2*BW2-1:BW2]);
sat#(BW2, BW1) sat2(oPsum[2*BW2-1:BW2], sat_oPsum[2*BW1-1:BW1]);
delay#(DELAY_NB1, BW1) delay2(iCLK, iRSTn, sat_oPsum[2*BW1-1:BW1], finaloPsum[2*BW1-1:BW1]);

filter#(K_SIZE, 3, BW1, BW2) filter3(iCLK, iRSTn, buff_x, kernel, finaloPsum[2*BW1-1:BW1], oPsum[3*BW2-1:2*BW2]);
sat#(BW2, BW1) sat3(oPsum[3*BW2-1:2*BW2], sat_oPsum[3*BW1-1:2*BW1]);
delay#(DELAY_NB1, BW1) delay3(iCLK, iRSTn, sat_oPsum[3*BW1-1:2*BW1], finaloPsum[3*BW1-1:2*BW1]);

filter#(K_SIZE, 4, BW1, BW2) filter4(iCLK, iRSTn, buff_x, kernel, finaloPsum[3*BW1-1:2*BW1], oPsum[4*BW2-1:3*BW2]);
sat#(BW2, BW1) sat4(oPsum[4*BW2-1:3*BW2], sat_oPsum[4*BW1-1:3*BW1]);
delay#(DELAY_NB1, BW1) delay4(iCLK, iRSTn, sat_oPsum[4*BW1-1:3*BW1], finaloPsum[4*BW1-1:3*BW1]);

filter#(K_SIZE, 5, BW1, BW2) filter5(iCLK, iRSTn, buff_x, kernel, finaloPsum[4*BW1-1:3*BW1], oPsum[5*BW2-1:4*BW2]);
sat#(BW2, BW1) sat5(oPsum[5*BW2-1:4*BW2], oY);


ctrl#(32, 5, 1) ctrl(iCLK, iRSTn, iValid, pre_ovalid);
delay#(DELAY_NB2, 1) delay_ctrl2(iCLK, iRSTn, pre_ovalid, oValid);

endmodule

