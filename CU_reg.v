module CU_reg (IR, state, status, NS, k_mux, controlWord);
//----DP_reg_sel
parameter CUL = 36;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [3:0] NS;
output [CUL:0] controlWord;
wire [10:0] opcode = IR[31:21];
wire [2:0] trimOp = {opcode[9:8], opcode[3]};

wire [4:0] FS;

wire ADD;
wire SUB;
wire ADDS;
wire SUBS;
wire AND;
wire ORR;
wire EOR;
wire ANDS;
Decoder3to8 opToSignal ({SUBS, ANDS, SUB, EOR, ADDS, ORR, ADD, AND},trimOp, 1'b1);

assign FS = (ADD|ADDS) ? 5'b01000 : 
				(SUB|SUBS) ? 5'b01001 :
				(AND|ANDS) ? 5'b00000 :
				(ORR)      ? 5'b00100 : 5'b01100;

wire [3:0] NS           = 4'b0000; //All single state instructions
wire [4:0] SA           = IR[9:5];
wire [4:0] SB           = IR[20:16];
wire [4:0] DA           = IR[4:0];
wire w_reg              = 1'b1;
wire C0                 = opcode[9];
wire [1:0] mem_cs       = 2'b01;
wire B_Sel              = 1'b0;
wire mem_write_en       = 1'b0;
wire IR_load            = 1'b0;
wire status_load        = (opcode[8]&opcode[3]) | (opcode[9]&opcode[8]); //B&E + A&B
wire [1:0] size         = 2'b00;
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = 2'b00;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = 2'b01;
wire [2:0] k_mux        = 3'b000;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule