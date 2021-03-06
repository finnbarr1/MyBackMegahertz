module RegisterFile32x64_Testbench();
	// create registers for holding the simulated input values to the DUT
	reg [4:0]SA, SB, DA;
	reg [63:0]D;
	reg W, reset, clock;
	// create wires for the output of the DUT
	wire [63:0]A, B;
	reg flag = 1'b0;
	RegisterFile32x64 dut (A, B, SA, SB, D, DA, W, reset, clock);
	
	// give all inputs initial values
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		D <= 64'b0;
		W <= 1'b1;
		DA <= 5'd31; // write to register 0 first since D will be incremented before first clock
		SA <= 5'd28; // read from register 31 first on A bus
		SB <= 5'd2; // read from register 30 first on B bus	
		#5 reset <= 1'b0; // delay 5 ticks then turn reset off
		#600 W <= 1'b0; // delay 320 ticks then turn write off
		#600 $stop; // delay another 320 ticks then stop the simulation
	end
	
	always
		#5 clock <= ~clock;
		
	always begin
		#5;
		if(DA == 5'd30)
			DA <= DA + 5'd2;
		else
			DA <= DA + 5'b1;
		if(SA == 5'd30)
			SA <= SA + 5'd2;
		else
			SA <= SA + 5'b1;
		if((B == 64'd0)&(flag == 1'b0)) begin
			D <= {59'd0, DA + 5'd2};
		end
		else begin
			D <= A;	
			flag <= 1'b1;
		end
		//SB <= SB + 5'b1;
		#5;
	end
	
	
	// create wires for each register in the dut then connect them accordingly so they
	// show up on the wave view in ModelSim automatically
	wire [63:0]R00, R01, R02, R03, R04, R05, R06, R07, R08, R09;
	wire [63:0]R10, R11, R12, R13, R14, R15, R16, R17, R18, R19;
	wire [63:0]R20, R21, R22, R23, R24, R25, R26, R27, R28, R29;
	wire [63:0]R30, R31;
	
	assign R00 = dut.R00;
	assign R01 = dut.R01;
	assign R02 = dut.R02;
	assign R03 = dut.R03;
	assign R04 = dut.R04;
	assign R05 = dut.R05;
	assign R06 = dut.R06;
	assign R07 = dut.R07;
	assign R08 = dut.R08;
	assign R09 = dut.R09;
	assign R10 = dut.R10;
	assign R11 = dut.R11;
	assign R12 = dut.R12;
	assign R13 = dut.R13;
	assign R14 = dut.R14;
	assign R15 = dut.R15;
	assign R16 = dut.R16;
	assign R17 = dut.R17;
	assign R18 = dut.R18;
	assign R19 = dut.R19;
	assign R20 = dut.R20;
	assign R21 = dut.R21;
	assign R22 = dut.R22;
	assign R23 = dut.R23;
	assign R24 = dut.R24;
	assign R25 = dut.R25;
	assign R26 = dut.R26;
	assign R27 = dut.R27;
	assign R28 = dut.R28;
	assign R29 = dut.R29;
	assign R30 = dut.R30;
	assign R31 = dut.R31;
	
endmodule
