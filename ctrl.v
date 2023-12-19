module ctrl
#(parameter IN_COL_SIZE = 32, K_SIZE = 5, STRIDE = 1)
(
    input iCLK,
    input iRSTn,
    input iValid,
    output pre_ovalid
);

reg  buff_ivalid;
reg [4:0] i;
reg [4:0] j;


assign pre_ovalid = !buff_ivalid ? 1'b0 : i>(IN_COL_SIZE-K_SIZE) || j>(IN_COL_SIZE-K_SIZE) ? 1'b00 : (i==5'b0 || i%STRIDE==1'b0) && (j==5'b0 || j%STRIDE==1'b0) ? 1'b1 : 1'b0;

// x_in D
always@(posedge iCLK, negedge iRSTn) begin
    // Fill in your code here
    if (!iRSTn) begin
        buff_ivalid <= 0;
    end
    else 
        buff_ivalid <= iValid;
end

// i counter
always@(posedge iCLK, negedge iRSTn) begin
    if (!iRSTn) begin
        i <= 0;
    end
    else if (buff_ivalid) begin
        if (j==IN_COL_SIZE-1)
            i <= i + 1;
        else if (j==IN_COL_SIZE-1 && i==IN_COL_SIZE-1)
            i <= 0;
    end
end

// j counter
always@(posedge iCLK, negedge iRSTn) begin
    if (!iRSTn) begin
        j <= 0;
    end
    else if (buff_ivalid) begin
        if (j==IN_COL_SIZE-1)
            j <= 0;
        else
            j <= j + 1;
    end
end

endmodule

