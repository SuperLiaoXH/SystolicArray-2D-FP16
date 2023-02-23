`timescale 1ns/1ps

module PE_Array_2D_TB();

	parameter DATA_WIDTH = 16;
	localparam PERIOD = 100;

    reg clk;
    reg reset;
    reg [2:0] filter_size;
	reg start;
    reg [DATA_WIDTH-1:0] Current_A1;
    reg [DATA_WIDTH-1:0] Current_A2;
    reg [DATA_WIDTH-1:0] Current_A3;
    reg [DATA_WIDTH-1:0] Current_A4;
    reg [DATA_WIDTH-1:0] Current_A5;
    reg [DATA_WIDTH-1:0] Current_B1;
    reg [DATA_WIDTH-1:0] Current_B2;
    reg [DATA_WIDTH-1:0] Current_B3;
    reg [DATA_WIDTH-1:0] Current_B4;
    reg [DATA_WIDTH-1:0] Current_B5;
    wire [DATA_WIDTH-1:0] PE_Array_out11, PE_Array_out12, PE_Array_out13, PE_Array_out14, PE_Array_out15;
    wire [DATA_WIDTH-1:0] PE_Array_out21, PE_Array_out22, PE_Array_out23, PE_Array_out24, PE_Array_out25;
    wire [DATA_WIDTH-1:0] PE_Array_out31, PE_Array_out32, PE_Array_out33, PE_Array_out34, PE_Array_out35;
    wire [DATA_WIDTH-1:0] PE_Array_out41, PE_Array_out42, PE_Array_out43, PE_Array_out44, PE_Array_out45;
    wire [DATA_WIDTH-1:0] PE_Array_out51, PE_Array_out52, PE_Array_out53, PE_Array_out54, PE_Array_out55;
	wire done;

	PE_Array_2D PE_Array_2D_inst(
		.clk(clk),
		.reset(reset),
		.start(start),
		.filter_size(filter_size),
		.Current_A1(Current_A1),
		.Current_A2(Current_A2),
		.Current_A3(Current_A3),
		.Current_A4(Current_A4),
		.Current_A5(Current_A5),
		.Current_B1(Current_B1),
		.Current_B2(Current_B2),
		.Current_B3(Current_B3),
		.Current_B4(Current_B4),
		.Current_B5(Current_B5),
		.PE_Array_out11(PE_Array_out11),
		.PE_Array_out12(PE_Array_out12),
		.PE_Array_out13(PE_Array_out13),
		.PE_Array_out14(PE_Array_out14),
		.PE_Array_out15(PE_Array_out15),
		.PE_Array_out21(PE_Array_out21),
		.PE_Array_out22(PE_Array_out22),
		.PE_Array_out23(PE_Array_out23),
		.PE_Array_out24(PE_Array_out24),
		.PE_Array_out25(PE_Array_out25),
		.PE_Array_out31(PE_Array_out31),
		.PE_Array_out32(PE_Array_out32),
		.PE_Array_out33(PE_Array_out33),
		.PE_Array_out34(PE_Array_out34),
		.PE_Array_out35(PE_Array_out35),
		.PE_Array_out41(PE_Array_out41),
		.PE_Array_out42(PE_Array_out42),
		.PE_Array_out43(PE_Array_out43),
		.PE_Array_out44(PE_Array_out44),
		.PE_Array_out45(PE_Array_out45),
		.PE_Array_out51(PE_Array_out51),
		.PE_Array_out52(PE_Array_out52),
		.PE_Array_out53(PE_Array_out53),
		.PE_Array_out54(PE_Array_out54),
		.PE_Array_out55(PE_Array_out55),
		.done(done)
	);

	task wait_clk;
		@(posedge clk);
		#(PERIOD/2);
	endtask

	task one_clk;
		#(PERIOD);
	endtask

	always #(PERIOD/2) clk = ~clk;

	initial begin

		#0
		clk = 1'b0;
        filter_size = 5;
		reset = 0;

		#(PERIOD/2);
		reset = 1;
		start = 1;
	//1
		// A1 = 1 , B1 = -2
		// A2 = 0 , B2 = -2
		// A3 = 0 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h3C00;
		Current_B1 = 16'hC000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		#(PERIOD/2);
		// A1 = 2 , B1 = -2
		// A2 = 2 , B2 = -2
		// A3 = 0 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h4000;	
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4000;		
		Current_B2 = 16'hC000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		one_clk;
		// A1 = 3 , B1 = -2
		// A2 = 2 , B2 = -2
		// A3 = 3 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h4200;
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4000;	
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4200;
		Current_B3 = 16'hC000;
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

        one_clk;
        // A1 = 4 , B1 = -2
		// A2 = 3 , B2 = -2
		// A3 = 2 , B3 = -2
		// A4 = 4 , B4 = -2
		// A5 = 0 , B5 = -2
	    Current_A1 = 16'h4400;
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4200;
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4000;	
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4400;
		Current_B4 = 16'hC000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

        one_clk;
        // A1 = 5 , B1 = -2
		// A2 = 4 , B2 = -2
		// A3 = 3 , B3 = -2
		// A4 = 2 , B4 = -2
		// A5 = 5 , B5 = -2
	    Current_A1 = 16'h4500;
		Current_B1 = 16'hC000;
	    Current_A2 = 16'h4400;
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4200;
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4000;	
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4500;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
        // A2 = 5 , B2 = -2
		// A3 = 4 , B3 = -2
		// A4 = 3 , B4 = -2
		// A5 = 2 , B5 = -2		
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h4500;
		Current_B2 = 16'hC000;
	    Current_A3 = 16'h4400;
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4200;
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4000;	
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 5 , B3 = -2
		// A4 = 4 , B4 = -2
		// A5 = 3 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h4500;
		Current_B3 = 16'hC000;
	    Current_A4 = 16'h4400;
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4200;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 5 , B4 = -2
		// A5 = 4 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;
	    Current_A4 = 16'h4500;
		Current_B4 = 16'hC000;
	    Current_A5 = 16'h4400;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 0 , B4 = 0
		// A5 = 5 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h4500;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 0 , B4 = 0
		// A5 = 0 , B5 = 0
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		#(PERIOD*10);

	//2
		wait_clk;
		wait_clk;
		reset = 0;
		start = 0;

		#(PERIOD/2);
		reset = 1;
		start = 1;
		// A1 = 1 , B1 = -2
		// A2 = 0 , B2 = -2
		// A3 = 0 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h3C00;
		Current_B1 = 16'hC000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		#(PERIOD/2);
		// A1 = 2 , B1 = -2
		// A2 = 2 , B2 = -2
		// A3 = 0 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h4000;	
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4000;		
		Current_B2 = 16'hC000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		one_clk;
		// A1 = 3 , B1 = -2
		// A2 = 2 , B2 = -2
		// A3 = 3 , B3 = -2
		// A4 = 0 , B4 = -2
		// A5 = 0 , B5 = -2
		Current_A1 = 16'h4200;
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4000;	
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4200;
		Current_B3 = 16'hC000;
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

        one_clk;
        // A1 = 4 , B1 = -2
		// A2 = 3 , B2 = -2
		// A3 = 2 , B3 = -2
		// A4 = 4 , B4 = -2
		// A5 = 0 , B5 = -2
	    Current_A1 = 16'h4400;
		Current_B1 = 16'hC000;
		Current_A2 = 16'h4200;
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4000;	
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4400;
		Current_B4 = 16'hC000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

        one_clk;
        // A1 = 5 , B1 = -2
		// A2 = 4 , B2 = -2
		// A3 = 3 , B3 = -2
		// A4 = 2 , B4 = -2
		// A5 = 5 , B5 = -2
	    Current_A1 = 16'h4500;
		Current_B1 = 16'hC000;
	    Current_A2 = 16'h4400;
		Current_B2 = 16'hC000;
		Current_A3 = 16'h4200;
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4000;	
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4500;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
        // A2 = 5 , B2 = -2
		// A3 = 4 , B3 = -2
		// A4 = 3 , B4 = -2
		// A5 = 2 , B5 = -2		
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h4500;
		Current_B2 = 16'hC000;
	    Current_A3 = 16'h4400;
		Current_B3 = 16'hC000;
		Current_A4 = 16'h4200;
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4000;	
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 5 , B3 = -2
		// A4 = 4 , B4 = -2
		// A5 = 3 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h4500;
		Current_B3 = 16'hC000;
	    Current_A4 = 16'h4400;
		Current_B4 = 16'hC000;
		Current_A5 = 16'h4200;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 5 , B4 = -2
		// A5 = 4 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;
	    Current_A4 = 16'h4500;
		Current_B4 = 16'hC000;
	    Current_A5 = 16'h4400;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 0 , B4 = 0
		// A5 = 5 , B5 = -2
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h4500;
		Current_B5 = 16'hC000;

		one_clk;
		// A1 = 0 , B1 = 0
		// A2 = 0 , B2 = 0
		// A3 = 0 , B3 = 0
		// A4 = 0 , B4 = 0
		// A5 = 0 , B5 = 0
	    Current_A1 = 16'h0000;
		Current_B1 = 16'h0000;
	    Current_A2 = 16'h0000;
		Current_B2 = 16'h0000;
	    Current_A3 = 16'h0000;
		Current_B3 = 16'h0000;		
	    Current_A4 = 16'h0000;
		Current_B4 = 16'h0000;
	    Current_A5 = 16'h0000;
		Current_B5 = 16'h0000;

		#(PERIOD*10);

		wait_clk;
		$stop;

	end

endmodule
