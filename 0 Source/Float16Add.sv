// ----------------------------------------------------------------------------------
// -- Function : This module is used for half precision floating-point addition
// -- Designer : LXH
// ----------------------------------------------------------------------------------
module Float16Add(
    floatA,
    floatB,
    sum
);

    input [15:0] floatA;
    input [15:0] floatB;
    output reg [15:0] sum;

    reg sign;
    reg signed [5:0] exponent; //fifth bit is sign
    reg [9:0] mantissa;

    reg [4:0] exponentA;
    reg [4:0] exponentB;
    reg [10:0] fractionA;
    reg [10:0] fractionB;
    reg [10:0] fraction; //fraction = {1,mantissa}
    reg [7:0] shiftAmount;
    reg cout;

    always @(floatA or floatB) begin
        exponentA = floatA[14:10];
        exponentB = floatB[14:10];
        fractionA = {1'b1,floatA[9:0]};
        fractionB = {1'b1,floatB[9:0]};

        exponent = exponentA;
        
        //special situation
        if (floatA == 0) begin
            sum = floatB;
        end
        else if (floatB == 0) begin
            sum = floatA;
        end
        else if (floatA[14:0] == floatB[14:0] && floatA[15]^floatB[15] == 1'b1) begin
            sum = 0;
        end

        //general situation
        else begin
            //1 matching of exponents
            if(exponentA > exponentB) begin
                shiftAmount = exponentA - exponentB;
                fractionB = fractionB >> (shiftAmount);
                exponent = exponentA;
            end
            else if (exponentB > exponentA)begin
                shiftAmount = exponentB - exponentA;
                fractionA = fractionA >> (shiftAmount);
                exponent = exponentB;
            end

            //2 mantissa addition and subtraction
            if(floatA[15] == floatB[15]) begin
                {cout,fraction} = fractionA + fractionB;
                if (cout == 1'b1) begin
                    {cout,fraction} = {cout,fraction} >> 1;
                    exponent = exponent + 1;
                end
                sign = floatA[15];
            end
            else begin
                if(floatA[15] == 1'b1) begin
                    {cout,fraction} = fractionB - fractionA;
                end
                else begin
                    {cout,fraction} = fractionA - fractionB;
                end
                sign = cout;
                if (cout == 1'b1) begin
                    fraction = -fraction;
                end
            end

            //3 mantissa normalization
            if (fraction [10] == 0) begin
				if (fraction[9] == 1'b1) begin
					fraction = fraction << 1;
					exponent = exponent - 1;
				end
                else if (fraction[8] == 1'b1) begin
					fraction = fraction << 2;
					exponent = exponent - 2;
				end
                else if (fraction[7] == 1'b1) begin
					fraction = fraction << 3;
					exponent = exponent - 3;
				end 
                else if (fraction[6] == 1'b1) begin
					fraction = fraction << 4;
					exponent = exponent - 4;
				end 
                else if (fraction[5] == 1'b1) begin
					fraction = fraction << 5;
					exponent = exponent - 5;
				end 
                else if (fraction[4] == 1'b1) begin
					fraction = fraction << 6;
					exponent = exponent - 6;
				end 
                else if (fraction[3] == 1'b1) begin
					fraction = fraction << 7;
					exponent = exponent - 7;
				end 
                else if (fraction[2] == 1'b1) begin
					fraction = fraction << 8;
					exponent = exponent - 8;
				end 
                else if (fraction[1] == 1'b1) begin
					fraction = fraction << 9;
					exponent = exponent - 9;
				end 
                else if (fraction[0] == 1'b1) begin
					fraction = fraction << 10;
					exponent = exponent - 10;
				end 
			end

            mantissa = fraction[9:0];
            
            //4 prevent overflow
		    if(exponent[5]==1'b1) begin //exponent is negative
		    	sum = 16'b0000000000000000;
		    end
		    else begin
		    	sum = {sign,exponent[4:0],mantissa};
		    end	
            
        end
        
    end

endmodule