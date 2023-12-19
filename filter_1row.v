module filter
#(parameter K_SIZE = 25, K_ROW = 1, BW1 = 16, BW2 = 19)
(
    input                   iCLK,
    input                   iRSTn,
    input  signed [7:0]     iX,
    input  signed [(8*K_SIZE)-1:0] kernel,
    input  signed [BW1-1:0] iPsum,
    output signed [BW2-1:0] oPsum
);

wire signed [BW1-1:0] tmp_sum; 
wire signed [BW1:0] tmp_sum1;
wire signed [BW1:0] tmp_sum2; 
wire signed [BW1+1:0] tmp_sum3;

// Fill in your code here
pe#(BW1,BW1)     pe_1(iCLK, iRSTn, iX, kernel[7+40*(K_ROW-1):40*(K_ROW-1)], iPsum, tmp_sum);
pe#(BW1,BW1+1)   pe_2(iCLK, iRSTn, iX, kernel[15+40*(K_ROW-1):8+40*(K_ROW-1)], tmp_sum, tmp_sum1);
pe#(BW1+1,BW1+1) pe_3(iCLK, iRSTn, iX, kernel[23+40*(K_ROW-1):16+40*(K_ROW-1)], tmp_sum1, tmp_sum2);
pe#(BW1+1,BW1+2) pe_4(iCLK, iRSTn, iX, kernel[31+40*(K_ROW-1):24+40*(K_ROW-1)], tmp_sum2, tmp_sum3);
pe#(BW1+2,BW2)   pe_5(iCLK, iRSTn, iX, kernel[39+40*(K_ROW-1):32+40*(K_ROW-1)], tmp_sum3, oPsum);

endmodule

