// ----------------------------------------------------------------------------------
// -- Function : This module is a two-dimensional systolic array(Support up to 5*5 PEs)
// -- Designer : LXH
// ----------------------------------------------------------------------------------
module PE_Array_2D(
    clk,
    reset,
    start,    
    filter_size,
    Current_A1,
    Current_A2,
    Current_A3,
    Current_A4,
    Current_A5,
    Current_B1,
    Current_B2,
    Current_B3,
    Current_B4,
    Current_B5,
    PE_Array_out11, PE_Array_out12, PE_Array_out13, PE_Array_out14, PE_Array_out15,
    PE_Array_out21, PE_Array_out22, PE_Array_out23, PE_Array_out24, PE_Array_out25,
    PE_Array_out31, PE_Array_out32, PE_Array_out33, PE_Array_out34, PE_Array_out35,
    PE_Array_out41, PE_Array_out42, PE_Array_out43, PE_Array_out44, PE_Array_out45,
    PE_Array_out51, PE_Array_out52, PE_Array_out53, PE_Array_out54, PE_Array_out55,
    done
);

    parameter DATA_WIDTH = 16;

    input clk;
    input reset;
    input start;
    input [2:0] filter_size;
    input [DATA_WIDTH-1:0] Current_A1;
    input [DATA_WIDTH-1:0] Current_A2;
    input [DATA_WIDTH-1:0] Current_A3;
    input [DATA_WIDTH-1:0] Current_A4;
    input [DATA_WIDTH-1:0] Current_A5;
    input [DATA_WIDTH-1:0] Current_B1;
    input [DATA_WIDTH-1:0] Current_B2;
    input [DATA_WIDTH-1:0] Current_B3;
    input [DATA_WIDTH-1:0] Current_B4;
    input [DATA_WIDTH-1:0] Current_B5;
    output reg [DATA_WIDTH-1:0] PE_Array_out11, PE_Array_out12, PE_Array_out13, PE_Array_out14, PE_Array_out15;
    output reg [DATA_WIDTH-1:0] PE_Array_out21, PE_Array_out22, PE_Array_out23, PE_Array_out24, PE_Array_out25;
    output reg [DATA_WIDTH-1:0] PE_Array_out31, PE_Array_out32, PE_Array_out33, PE_Array_out34, PE_Array_out35;
    output reg [DATA_WIDTH-1:0] PE_Array_out41, PE_Array_out42, PE_Array_out43, PE_Array_out44, PE_Array_out45;
    output reg [DATA_WIDTH-1:0] PE_Array_out51, PE_Array_out52, PE_Array_out53, PE_Array_out54, PE_Array_out55;
    output reg done;

    wire [DATA_WIDTH-1:0] Next_A11, Next_A12, Next_A13, Next_A14;
    wire [DATA_WIDTH-1:0] Next_A21, Next_A22, Next_A23, Next_A24;
    wire [DATA_WIDTH-1:0] Next_A31, Next_A32, Next_A33, Next_A34;
    wire [DATA_WIDTH-1:0] Next_A41, Next_A42, Next_A43, Next_A44;
    wire [DATA_WIDTH-1:0] Next_A51, Next_A52, Next_A53, Next_A54;
    wire [DATA_WIDTH-1:0] Next_B11, Next_B12, Next_B13, Next_B14, Next_B15;
    wire [DATA_WIDTH-1:0] Next_B21, Next_B22, Next_B23, Next_B24, Next_B25;
    wire [DATA_WIDTH-1:0] Next_B31, Next_B32, Next_B33, Next_B34, Next_B35;
    wire [DATA_WIDTH-1:0] Next_B41, Next_B42, Next_B43, Next_B44, Next_B45;
    wire [DATA_WIDTH-1:0] P11, P12, P13, P14, P15;
    wire [DATA_WIDTH-1:0] P21, P22, P23, P24, P25;
    wire [DATA_WIDTH-1:0] P31, P32, P33, P34, P35;
    wire [DATA_WIDTH-1:0] P41, P42, P43, P44, P45;
    wire [DATA_WIDTH-1:0] P51, P52, P53, P54, P55;

    wire done1, done2, done3, done4, done5;
    reg isdone1, isdone2, isdone3, isdone4, isdone5;
    reg [4:0] counter1, counter2, counter3, counter4, counter5;

    ProcessingElement PE11(
        .clk(clk),
        .reset(reset),
        .Current_A(Current_A1),
        .Current_B(Current_B1),
        .Next_A(Next_A11),
        .Next_B(Next_B11),
        .PE_out(P11)
    );

    ProcessingElement PE12(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A11),
        .Current_B(Current_B2),
        .Next_A(Next_A12),
        .Next_B(Next_B12),
        .PE_out(P12)
    );
 
    ProcessingElement PE13(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A12),
        .Current_B(Current_B3),
        .Next_A(Next_A13),
        .Next_B(Next_B13),
        .PE_out(P13)
    );

    ProcessingElement PE14(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A13),
        .Current_B(Current_B4),
        .Next_A(Next_A14),
        .Next_B(Next_B14),
        .PE_out(P14)
    );    

    ProcessingElement PE15(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A14),
        .Current_B(Current_B5),
        .Next_A(),
        .Next_B(Next_B15),
        .PE_out(P15)
    );

    ProcessingElement PE21(
        .clk(clk),
        .reset(reset),
        .Current_A(Current_A2),
        .Current_B(Next_B11),
        .Next_A(Next_A21),
        .Next_B(Next_B21),
        .PE_out(P21)
    );

    ProcessingElement PE22(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A21),
        .Current_B(Next_B12),
        .Next_A(Next_A22),
        .Next_B(Next_B22),
        .PE_out(P22)
    );

    ProcessingElement PE23(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A22),
        .Current_B(Next_B13),
        .Next_A(Next_A23),
        .Next_B(Next_B23),
        .PE_out(P23)
    );

    ProcessingElement PE24(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A23),
        .Current_B(Next_B14),
        .Next_A(Next_A24),
        .Next_B(Next_B24),
        .PE_out(P24)
    );

    ProcessingElement PE25(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A24),
        .Current_B(Next_B15),
        .Next_A(),
        .Next_B(Next_B25),
        .PE_out(P25)
    );

    ProcessingElement PE31(
        .clk(clk),
        .reset(reset),
        .Current_A(Current_A3),
        .Current_B(Next_B21),
        .Next_A(Next_A31),
        .Next_B(Next_B31),
        .PE_out(P31)
    );

    ProcessingElement PE32(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A31),
        .Current_B(Next_B22),
        .Next_A(Next_A32),
        .Next_B(Next_B32),
        .PE_out(P32)
    );

    ProcessingElement PE33(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A32),
        .Current_B(Next_B23),
        .Next_A(Next_A33),
        .Next_B(Next_B33),
        .PE_out(P33)
    );

    ProcessingElement PE34(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A33),
        .Current_B(Next_B24),
        .Next_A(Next_A34),
        .Next_B(Next_B34),
        .PE_out(P34)
    );

    ProcessingElement PE35(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A34),
        .Current_B(Next_B25),
        .Next_A(),
        .Next_B(Next_B35),
        .PE_out(P35)
    );

    ProcessingElement PE41(
        .clk(clk),
        .reset(reset),
        .Current_A(Current_A4),
        .Current_B(Next_B31),
        .Next_A(Next_A41),
        .Next_B(Next_B41),
        .PE_out(P41)
    );

    ProcessingElement PE42(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A41),
        .Current_B(Next_B32),
        .Next_A(Next_A42),
        .Next_B(Next_B42),
        .PE_out(P42)
    );

    ProcessingElement PE43(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A42),
        .Current_B(Next_B33),
        .Next_A(Next_A43),
        .Next_B(Next_B43),
        .PE_out(P43)
    );

    ProcessingElement PE44(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A43),
        .Current_B(Next_B34),
        .Next_A(Next_A44),
        .Next_B(Next_B44),
        .PE_out(P44)
    );

    ProcessingElement PE45(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A44),
        .Current_B(Next_B35),
        .Next_A(),
        .Next_B(Next_B45),
        .PE_out(P45)
    );

    ProcessingElement PE51(
        .clk(clk),
        .reset(reset),
        .Current_A(Current_A5),
        .Current_B(Next_B41),
        .Next_A(Next_A51),
        .Next_B(),
        .PE_out(P51)
    );

    ProcessingElement PE52(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A51),
        .Current_B(Next_B42),
        .Next_A(Next_A52),
        .Next_B(),
        .PE_out(P52)
    );

    ProcessingElement PE53(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A52),
        .Current_B(Next_B43),
        .Next_A(Next_A53),
        .Next_B(),
        .PE_out(P53)
    );

    ProcessingElement PE54(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A53),
        .Current_B(Next_B44),
        .Next_A(Next_A54),
        .Next_B(),
        .PE_out(P54)
    );  

    ProcessingElement PE55(
        .clk(clk),
        .reset(reset),
        .Current_A(Next_A54),
        .Current_B(Next_B45),
        .Next_A(),
        .Next_B(),
        .PE_out(P55)
    );

    always @ (posedge clk or negedge reset) begin
        if (!reset) begin
            counter1 <= 0;
            counter2 <= 0; 
            counter3 <= 0;
            counter4 <= 0;
            counter5 <= 0;
        end
        else if(start) begin
            //row 1
            if (counter1 == filter_size+4)
                counter1 <= 0;
            else
                counter1 <= counter1 + 1'b1;
            //row 2
            if (counter2 == filter_size+5)
                counter2 <= 0;
            else
                counter2 <= counter2 + 1'b1;
            //row 3
            if (counter3 == filter_size+6)
                counter3 <= 0;
            else
                counter3 <= counter3 + 1'b1;
            //row 4
            if (counter4 == filter_size+7)
                counter4 <= 0;
            else
                counter4 <= counter4 + 1'b1;
            //row 5
            if (counter5 == filter_size+8)
                counter5 <= 0;
            else
                counter5 <= counter5 + 1'b1;
        end            
        else begin
            counter1 <= 0;
            counter2 <= 0;
            counter3 <= 0;
            counter4 <= 0;
            counter5 <= 0;  
        end      
    end

    always@ (posedge clk or negedge reset) begin
        if (!reset) begin
            isdone1 <= 0;
            isdone2 <= 0;
            isdone3 <= 0;
            isdone4 <= 0;
            isdone5 <= 0;
        end
        else begin
            //row 1
            if (counter1 == filter_size+4) begin
                isdone1 <= 1;
            end
            else begin
                isdone1 <= 0;
            end
            //row 2
            if (counter2 == filter_size+5) begin
                isdone2 <= 1;
            end
            else begin
                isdone2 <= 0;
            end
            //row 3
            if (counter3 == filter_size+6) begin
                isdone3 <= 1;
            end
            else begin
                isdone3 <= 0;
            end
            //row 4
            if (counter4 == filter_size+7) begin
                isdone4 <= 1;
            end
            else begin
                isdone4 <= 0;
            end
            //row 5
            if (counter5 == filter_size+8) begin
                isdone5 <= 1;
            end
            else begin
                isdone5 <= 0;
            end
        end
    end
    assign done1 = isdone1;
    assign done2 = isdone2;
    assign done3 = isdone3;
    assign done4 = isdone4;
    assign done5 = isdone5;

    always@ (posedge clk or negedge reset) begin
        if(!reset) begin
            done <= 0;
        end
        else
            done <= done5;
    end

    always@ (posedge clk or negedge reset) begin
        if(!reset) begin
            PE_Array_out11 <= 0;
            PE_Array_out12 <= 0;
            PE_Array_out13 <= 0;
            PE_Array_out14 <= 0;
            PE_Array_out15 <= 0;
            PE_Array_out21 <= 0;
            PE_Array_out22 <= 0;
            PE_Array_out23 <= 0;
            PE_Array_out24 <= 0;
            PE_Array_out25 <= 0;
            PE_Array_out31 <= 0;
            PE_Array_out32 <= 0;
            PE_Array_out33 <= 0;
            PE_Array_out34 <= 0;
            PE_Array_out35 <= 0;
            PE_Array_out41 <= 0;
            PE_Array_out42 <= 0;
            PE_Array_out43 <= 0;
            PE_Array_out44 <= 0;
            PE_Array_out45 <= 0;
            PE_Array_out51 <= 0;
            PE_Array_out52 <= 0;
            PE_Array_out53 <= 0;
            PE_Array_out54 <= 0;
            PE_Array_out55 <= 0;
        end
        else if(done1) begin
            PE_Array_out11 <= P11;
            PE_Array_out12 <= P12;
            PE_Array_out13 <= P13;
            PE_Array_out14 <= P14;
            PE_Array_out15 <= P15;
        end
        else if(done2) begin
            PE_Array_out21 <= P21;
            PE_Array_out22 <= P22;
            PE_Array_out23 <= P23;
            PE_Array_out24 <= P24;
            PE_Array_out25 <= P25;
        end
        else if(done3) begin
            PE_Array_out31 <= P31;
            PE_Array_out32 <= P32;
            PE_Array_out33 <= P33;
            PE_Array_out34 <= P34;
            PE_Array_out35 <= P35;
        end
        else if(done4) begin
            PE_Array_out41 <= P41;
            PE_Array_out42 <= P42;
            PE_Array_out43 <= P43;
            PE_Array_out44 <= P44;
            PE_Array_out45 <= P45;
        end
        else if(done5) begin
            PE_Array_out51 <= P51;
            PE_Array_out52 <= P52;
            PE_Array_out53 <= P53;
            PE_Array_out54 <= P54;
            PE_Array_out55 <= P55;
        end
        else begin
            PE_Array_out11 <= 0;
            PE_Array_out12 <= 0;
            PE_Array_out13 <= 0;
            PE_Array_out14 <= 0;
            PE_Array_out15 <= 0;
            PE_Array_out21 <= 0;
            PE_Array_out22 <= 0;
            PE_Array_out23 <= 0;
            PE_Array_out24 <= 0;
            PE_Array_out25 <= 0;
            PE_Array_out31 <= 0;
            PE_Array_out32 <= 0;
            PE_Array_out33 <= 0;
            PE_Array_out34 <= 0;
            PE_Array_out35 <= 0;
            PE_Array_out41 <= 0;
            PE_Array_out42 <= 0;
            PE_Array_out43 <= 0;
            PE_Array_out44 <= 0;
            PE_Array_out45 <= 0;
            PE_Array_out51 <= 0;
            PE_Array_out52 <= 0;
            PE_Array_out53 <= 0;
            PE_Array_out54 <= 0;
            PE_Array_out55 <= 0;
        end
    end    


endmodule