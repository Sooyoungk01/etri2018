module tb_top_conv;

reg iCLK;
reg iRSTn;
reg signed [7:0] iX;
reg signed [7:0] iW;
reg        [4:0] iADDR;
reg iWren;
reg iValid;

wire signed [15:0] oY;
wire oValid;

integer fd_x, fd_w, fo;
integer h_x, h_w;
integer i, j;

localparam K_SIZE = 25, BW1 = 16, BW2 = 19;

top_conv#(K_SIZE, BW1, BW2) top_conv(iCLK, iRSTn, iX, iW, iADDR, iWren, iValid, oY, oValid);

initial begin
    fd_w = $fopen("testvector/w_in_1s.dat","r");
    fo   = $fopen("testvector/y_rtl_1s.dat", "w");
    iCLK = 0;
    iRSTn = 0;
    iX = 0;
    iW = 0;
    iADDR = 0;
    iWren = 0;
    iValid = 0;
    
    @(posedge iCLK);
    #1 iRSTn = 1;
    @(posedge iCLK);
    #1 iValid = 1;
       iWren = 1;
       for(j=0; j<6; j=j+1) begin
           fd_x = $fopen("testvector/x_in_1s.dat","r");
           for(i=0; i<1024; i=i+1) begin 
               if(i<=24) begin
                #1 iWren = 1;
                   iADDR = i;
                   h_w = $fscanf(fd_w, "%d\n", iW);
                   h_x = $fscanf(fd_x, "%d\n", iX);
               end
               else begin
                #1 iWren = 0;
                   iADDR = 0;
                   iW = 0;
                   h_x = $fscanf(fd_x, "%d\n", iX);
               end
               @(posedge iCLK);
           end
       end
       repeat(3)@(posedge iCLK);
       iValid = 0;
       repeat(10) @(posedge iCLK);
       $fclose(fd_x);
       $fclose(fd_w);
       $fclose(fo);
       $finish;

end

always #5 iCLK = ~iCLK;

always@(posedge iCLK) begin
    if(oValid) begin
        $fwrite(fo,"%0d\n", oY);
    end
end

initial begin
	$dumpfile("tb_top_conv.vcd");
	$dumpvars(0, tb_top_conv);
end

endmodule
