module ram_sp_sr_sw (
clk , // Clock Input
address , // Address Input
data , // Data bi-directional
cs , // Chip Select
we , // Write Enable/Read Enable
oe // Output Enable
); 

parameter DATA_WIDTH = 64 ;
parameter ADDR_WIDTH = 32 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH; 

//--------------Input Ports----------------------- 
input clk ;
input [ADDR_WIDTH-1:0] address ;
input cs ;
input we ;
input oe ; 

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0] data ;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg oe_r;
reg test = 1'b0;
//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1
assign data = (cs && oe && !we) ? data_out : {DATA_WIDTH{1'bz}}; 

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (posedge clk)
	begin //: MEM_WRITE
		if ( cs && we ) begin
			mem[address] = data;
			test <= 1'b1;
		end
end

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
always @ (posedge clk)
	begin //: MEM_READ
		if (cs && !we && oe) begin
			data_out = mem[address];
			oe_r = 1;
		end else begin
			oe_r = 0;
	end
end

endmodule // End of Module ram_sp_sr_sw