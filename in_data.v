module in_data
#(parameter K_SIZE = 25)
(
    input                              iCLK,
    input                              iRSTn,
    input      signed [7:0]            iX,
    input      signed [7:0]            iW,
    input             [4:0]            iADDR,
    input                              iWren,
    input                              iValid,
    output reg signed [7:0]            buff_x,
    output reg signed [8*K_SIZE-1:0] kernel
);

//synchro
always@(posedge iCLK, negedge iRSTn) begin
    if(!iRSTn)
        buff_x <= 0;
    else begin
        if(iValid)
            buff_x <= iX;
    end
end

always@(posedge iCLK, negedge iRSTn) begin
    if(!iRSTn)
        kernel <= 0;
    else begin
        if(iWren) begin
            case(iADDR)
            0 : kernel[7:0] <= iW;
            1 : kernel[15:8] <= iW;
            2 : kernel[23:16] <= iW;
            3 : kernel[31:24] <= iW;
            4 : kernel[39:32] <= iW;
            5 : kernel[47:40] <= iW;
            6 : kernel[55:48] <= iW;
            7 : kernel[63:56] <= iW;
            8 : kernel[71:64] <= iW;
            9 : kernel[79:72] <= iW;
            10: kernel[87:80] <= iW;
            11: kernel[95:88] <= iW;
            12: kernel[103:96] <= iW;
            13: kernel[111:104] <= iW;
            14: kernel[119:112] <= iW;
            15: kernel[127:120] <= iW;
            16: kernel[135:128] <= iW;
            17: kernel[143:136] <= iW;
            18: kernel[151:144] <= iW;
            19: kernel[159:152] <= iW;
            20: kernel[167:160] <= iW;
            21: kernel[175:168] <= iW;
            22: kernel[183:176] <= iW;
            23: kernel[191:184] <= iW;
            24: kernel[199:192] <= iW;
            default : kernel <= kernel;
            endcase
        end
    end
end

endmodule
   
