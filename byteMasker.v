module byteMasker32(maskSize, out);
input [1:0] maskSize; 
output [31:0] out;

//00 -> 00 00 00 FF
//01 -> 00 00 FF FF
//10 -> 00 FF FF FF
//11 -> FF FF FF FF

wire [7:0] byte0 = 8'hFF;
wire [7:0] byte1 = (maskSize[1]|maskSize[0]) ? 8'hFF : 8'h00;
wire [7:0] byte2 = (maskSize[1]) ? 8'hFF : 8'h00;
wire [7:0] byte3 = (maskSize[1]&maskSize[0]) ? 8'hFF : 8'h00;

assign out = {byte3, byte2, byte1, byte0};

endmodule

module byteMasker64(size, mask);

input [1:0] size;
output [63:0] mask;
wire [63:0] mask = 63'hFF_FF << 6'd16 * {4'd0, size};

endmodule