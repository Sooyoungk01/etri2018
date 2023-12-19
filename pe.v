module pe
#(parameter BW1 = 16, BW2 = 16)
(
    input                       iCLK,
    input                       iRSTn,
    input      signed [7:0]     iX,
    input      signed [7:0]     iW,
    input      signed [BW1-1:0] iPsum,
    output reg signed [BW2-1:0] oPsum
);

always@(posedge iCLK, negedge iRSTn) begin
    // Fill in your code here
    if (!iRSTn) begin
        oPsum <= 0;
    end
    else begin
         oPsum <= iPsum + iX * iW;
    end   
end

endmodule

