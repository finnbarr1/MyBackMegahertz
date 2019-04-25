 module ROM(address, data, chip_select, output_enable); 
	input [31:0] address; 
	input chip_select;
	input output_enable;
	output [63:0] data;
	
	reg [63:0] out;
	triState romOut (data, out, (output_enable&chip_select));
	
	
	always@(address)
	begin
		case(address)
			/*32'h00000000: out = {10'b1001000100,12'hFF, 5'd31, 5'd0}; //ADDI X0 X31 #hAAA
			32'h00000004: out = {9'b110100101, 2'b11, 16'hFFFF, 5'd0}; //MOVZ X0 #hFFFF (Byte 6-7)
			32'h00000008: out = {9'b111100101, 2'b01, 16'hAAAA, 5'd0}; //MOVK X0 #hAAAA (Byte 2-3)
			32'h0000000C: out = {10'b1001000100,12'd266, 5'd31, 5'd0}; //ADDI X0 X31 #10
			32'h00000010: out = {11'b01111000000, 9'd0, 2'd0, 5'd31, 5'd0}; //STURH X0 [X31 #0]
			32'h00000014: out = {11'b01111000010, 9'd0, 2'd0, 5'd31, 5'd1}; //LOADH X1 [X31 #0]
			32'h00000018: out = {11'b00111000000, 9'd0, 2'd0, 5'd31, 5'd0}; //STURB X0 [X31 #0]
			32'h0000001C: out = {11'b00111000010, 9'd0, 2'd0, 5'd31, 5'd2}; //LOADB X2 [X31 #0]
			*/
			/*32'h0000:  out = 32'b10010001000000000000011111100000; // ADDI X0, XZR, 1
			32'h0004:  out = 32'b10010001000000000000011111100001; // ADDI X1, XZR, 1
			32'h0008:  out = 32'b11110001000000000011110000000100; // SUBIS X4, X0, 15
			32'h000C:  out = {8'b01010100, 19'd4, 5'b01010}; //B.GE 4
			32'h0010:  out = 32'b10101010000000000000001111100011; // ORR X3, XZR, X0
			32'h0014:  out = 32'b10001011000000010000000000000000; // ADD X0, X0, X1
			32'h0018:  out = 32'b10101010000000110000001111100001; // ORR X1, XZR, X3
			16'h001C:  out = 32'b00010111111111111111111111111010; // B -6
			32'h0020:  out = 32'b11010110000000000000001111100000; // BR XZR*/
			/*32'h0000:  out = 32'b10010001000000000010101111100000; // ADDI X0, XZR, 10
			32'h0004:  out = 32'b11111000000011111110001111100000; // STUR X0, [XZR, 254]
			32'h0008:  out = 32'b10010001000000000101001111100001; // ADDI X1, XZR, 20
			32'h000C:  out = 32'b11111000000011111111001111100000; // STUR X0, [XZR, 255]
			32'h0010:  out = 32'b11111000000000000000001111100000; // STUR X0, [XZR, 0]
			32'h0014:  out = 32'b11111000010000000000001111100010; // LDUR X2, [XZR, 0]
			32'h0018:  out = 32'b00010111111111111111111111111001; // B -7*/
			32'h0000:  out = 32'b10110010000000000000111111100000; // ORRI X0, XZR, 3
			32'h0004:  out = 32'b11111000000011111110001111100000; // STUR X0, [XZR, 254] //Setting DIR
			32'h0008:  out = 32'b11010010100101010101010101000000; // MOVZ X0, 43690 //hAAAA
			32'h000C:  out = 32'b10010010000000000000000000100001; // ANDI X1, X1, 0
			32'h0010:  out = 32'b10010010000000000000000001100011; // ANDI X3, X3, 0
			32'h0014:  out = 32'b10010010000000000000000010000100; // ANDI X4, X4, 0
			32'h0018:  out = 32'b11110001000000000011000010011111; // SUBIS XZR, X4, 12 //loop starts here
			32'h001C:  out = 32'b01010100111111111111111100001010; // B.GE -8
			32'h0020:  out = 32'b10010010000000000000010000000011; // ANDI X3, X0, 1
			32'h0024:  out = 32'b11010011011000000000010001100011; // LSL X3, X3, 1 //shift data into position
			32'h0028:  out = 32'b11111000000011111111001111100011; // STUR X3, [XZR, 255] //data write
			32'h002C:  out = 32'b10110010000000000000010001100011; // ORRI X3, X3, 1
			32'h0030:  out = 32'b11111000000011111111001111100011; // STUR X3, [XZR, 255] //clock write 1
			32'h0034:  out = 32'b11010011010000000000010000000000; // LSR X0, X0, 1
			32'h0038:  out = 32'b10010001000000000000010010000100; // ADDI X4, X4, 1
			32'h003C:  out = 32'b11111000000011111111001111111111; // STUR X31, [XZR, 255] //clock write 0
			32'h0040:  out = 32'b00010111111111111111111111110101; // B -11 //top of loop
			default:   out=32'hD60003E0; //BR XZR
		endcase
	end
endmodule
			
			