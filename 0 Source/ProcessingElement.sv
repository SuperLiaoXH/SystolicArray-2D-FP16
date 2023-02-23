// ----------------------------------------------------------------------------------
// -- Function : This module is the basic PE unit in the 2D systolic array
// -- Designer : LXH
// ----------------------------------------------------------------------------------
module ProcessingElement(
    clk,
    reset,
    Current_A,
    Current_B,
    Next_A,
    Next_B,
    PE_out
);

    parameter DATA_WIDTH = 16;

    input clk;
    input reset;
    input [DATA_WIDTH-1:0] Current_A;
    input [DATA_WIDTH-1:0] Current_B;
    output [DATA_WIDTH-1:0] Next_A;
    output [DATA_WIDTH-1:0] Next_B;
    output reg [DATA_WIDTH-1:0] PE_out;

    reg [DATA_WIDTH-1:0] Current_A_reg;
    reg [DATA_WIDTH-1:0] Current_B_reg;
    wire [DATA_WIDTH-1:0] MulResult;
    wire [DATA_WIDTH-1:0] AddResult;

    Float16Mul FM
    (
        .floatA(Current_A_reg),
        .floatB(Current_B_reg),
        .product(MulResult)
    );

    Float16Add FA
    (
        .floatA(MulResult),
        .floatB(PE_out),
        .sum(AddResult)
    );

    always @ (posedge clk or negedge reset) begin
        if(!reset) begin
            PE_out <= 0;
            Current_A_reg <= 0;
            Current_B_reg <= 0;
        end
        else begin
            PE_out <= AddResult;
            Current_A_reg <= Current_A;
            Current_B_reg <= Current_B;
        end
    end

    assign Next_A = Current_A_reg;
    assign Next_B = Current_B_reg;

endmodule