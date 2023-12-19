module delay

#(parameter DELAY_NB = 27, BW1 = 16)
(
    input                 iCLK,
    input                 iRSTn,
    input       [BW1-1:0] iData,
    output      [BW1-1:0] oData
);

reg [BW1-1:0] oData_[0:DELAY_NB-1];

assign oData = oData_[DELAY_NB-1];

genvar i;

generate
    for(i=0; i<DELAY_NB; i=i+1) begin :_u
		  if(i==0) begin
			always@(posedge iCLK, negedge iRSTn) begin
					if(!iRSTn)
						oData_[i] <= 0;
					else
						oData_[i] <= iData;
					
			end
		  end
		  else begin
			// oData_ D
			always@(posedge iCLK, negedge iRSTn) begin
				// Fill in your code here
					if(!iRSTn)
						oData_[i] <= 0;
					else
						oData_[i] <= oData_[i-1];

			end
        end
	end
endgenerate

endmodule
