module sat
#(parameter OVER_BW1 = 19, SAT_BW2 = 16)
(
    input      signed [OVER_BW1-1:0] iData,
    output reg signed [SAT_BW2-1:0]  oData
);

always@(*) begin
    // Fill in your code here
    if (iData > 2**(SAT_BW2-1)-1)
        oData = 2**(SAT_BW2-1)-1;
    else if (iData < -2**(SAT_BW2-1))
        oData = -2**(SAT_BW2-1);
    else
        oData = iData;
    
end

endmodule

