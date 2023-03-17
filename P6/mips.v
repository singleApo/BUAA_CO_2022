`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:05 12/06/2022 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macro.v"
`default_nettype none

module mips(
    input wire clk,
    input wire reset,
    input wire [31:0] i_inst_rdata,  //instr_F
    input wire [31:0] m_data_rdata,  //DMOut
    output wire [31:0] i_inst_addr,  //PC_F
    output wire [31:0] m_data_addr,  //ALUOut_M
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    output wire [31:0] m_inst_addr,  //PC_M
    output wire w_grf_we,            //RegWrite_W
    output wire [4:0] w_grf_addr,    //WriteReg_W
    output wire [31:0] w_grf_wdata,  //WD
    output wire [31:0] w_inst_addr   //PC_W
);

	 wire [31:0] PC_D;
	 wire [31:0] PC_E;
	 wire [31:0] npc;
	 wire branch;
	 wire [31:0] instr_D;
	 wire [31:0] instr_E;
	 wire [31:0] instr_M;
	 wire [31:0] instr_W;

	 wire stall;
	 wire en;
	 wire start;
	 wire busy;
	 wire [1:0] forward_CMP1;
	 wire [1:0] forward_CMP2;
	 wire [1:0] forward_ALU1;
	 wire [1:0] forward_ALU2;
	 wire forward_DM;
	 
    wire [5:0] op;
    wire [4:0] rs_D;
	 wire [4:0] rs_E;
	 wire [4:0] rs_M;
	 wire [4:0] rt_D;
    wire [4:0] rt_E;
	 wire [4:0] rt_M;
    wire [4:0] rd_D;
	 wire [4:0] rd_E;
    wire [5:0] func;
    wire [15:0] Imm16;
    wire [25:0] Imm26;
	 
	 wire [31:0] RD1;
	 wire [31:0] RD2;
	 
	 wire [31:0] EXTOut_D;
	 wire [31:0] EXTOut_E;
	 
	 wire [31:0] ALU1_D;
	 wire [31:0] ALU1_E;
	 wire [31:0] ALU2_D;
	 wire [31:0] ALU2_E;
	 wire [31:0] ALUa;
	 wire [31:0] ALUb;
	 wire [31:0] ALUResult;
	 wire [31:0] ALUOut_E;
	 wire [31:0] ALUOut_W;
	 wire [31:0] MDUOut;
	 
	 wire [4:0] WriteReg_E;
	 wire [4:0] WriteReg_M;
	 
	 wire [31:0] WriteData_E;
	 wire [31:0] WriteData_M;
	 wire [31:0] DMIn;
	 wire [31:0] DMOut_M;
	 wire [31:0] DMOut_W;
	 
	 wire RegWrite_D;
	 wire RegWrite_E;
	 wire RegWrite_M;
	 
    wire [1:0] RegDst_D;
	 wire [1:0] RegDst_E;
    wire ALUSrc_D;
	 wire ALUSrc_E;
	 
    wire [2:0] MemOp_D;
	 wire [2:0] MemOp_E;
	 wire [2:0] MemOp_M;
	 
    wire [1:0] WDSrc1_D;
	 wire [1:0] WDSrc1_E;
	 wire WDSrc2_D;
	 wire WDSrc2_E;
	 wire WDSrc2_M;
	 wire WDSrc2_W;
	 
    wire [2:0] NPCOp;
    wire [2:0] ALUOp_D;
	 wire [2:0] ALUOp_E;
    wire [1:0] EXTOp;
	 wire [1:0] CMPOp;
	 wire [3:0] MDUOp_D;
	 wire [3:0] MDUOp_E;
	 
	 wire [1:0] Tnew_D;
	 wire [1:0] Tnew_E;
	 wire [1:0] Tnew_M;
	 wire [1:0] Tnew_W;
	 
	 assign op = instr_D[31:26];
    assign rs_D = instr_D[25:21];
    assign rt_D = instr_D[20:16];
    assign rd_D = instr_D[15:11];
    assign func = instr_D[5:0];
    assign Imm26 = instr_D[25:0];
    assign Imm16 = instr_D[15:0];
	 
	 assign en = ~stall;
    assign start = (MDUOp_E == `MDU_MULT)|(MDUOp_E == `MDU_MULTU)|(MDUOp_E == `MDU_DIV)|(MDUOp_E == `MDU_DIVU);

	 assign ALU1_D = (forward_CMP1 == 2'b11) ? PC_E + 8 :
                    (forward_CMP1 == 2'b10) ? m_data_addr :
						  (forward_CMP1 == 2'b01) ? w_grf_wdata : RD1;
	 
	 assign ALU2_D = (forward_CMP2 == 2'b11) ? PC_E + 8 :
                    (forward_CMP2 == 2'b10) ? m_data_addr :
						  (forward_CMP2 == 2'b01) ? w_grf_wdata : RD2;
	
	 assign ALUa = (forward_ALU1 == 2'b10) ? m_data_addr :
                  (forward_ALU1 == 2'b01) ? w_grf_wdata : ALU1_E;
						
	 assign WriteData_E = (forward_ALU2 == 2'b10) ? m_data_addr :
                         (forward_ALU2 == 2'b01) ? w_grf_wdata : ALU2_E;
								 
    assign WriteReg_E = (RegDst_E == 2'b00) ? rt_E :
                        (RegDst_E == 2'b01) ? rd_E :
                        (RegDst_E == 2'b10) ? 5'h1f : 5'b0;
	 
	 assign ALUb = (ALUSrc_E == 1'b0) ? WriteData_E :
                  (ALUSrc_E == 1'b1) ? EXTOut_E : 0;
		
	 assign ALUOut_E = (WDSrc1_E == 2'b00) ? ALUResult :
                      (WDSrc1_E == 2'b01) ? PC_E + 8 : 
							 (WDSrc1_E == 2'b10) ? MDUOut : 0;				
	 
	 assign DMIn = (forward_DM == 1'b1) ? w_grf_wdata :
                  (forward_DM == 1'b0) ? WriteData_M : 0;
					
	 assign w_grf_wdata = (WDSrc2_W == 1'b0) ? ALUOut_W :
                         (WDSrc2_W == 1'b1) ? DMOut_W : 0;
						  
	 PC pc (
    .clk(clk), 
    .reset(reset), 
    .en(en), 
    .in(npc), 
    .out(i_inst_addr)
    );
	 
	 NPC next (
    .PC_D(PC_D), 
    .PC_F(i_inst_addr), 
    .Imm26(Imm26), 
    .RA(ALU1_D), 
    .NPCOp(NPCOp), 
    .branch(branch), 
    .out(npc)
    );
	 	 
	 reg_D D (
    .clk(clk), 
    .en(en), 
    .reset(reset), 
    .instr_F(i_inst_rdata), 
    .PC_F(i_inst_addr), 
    .instr_D(instr_D), 
    .PC_D(PC_D)
    );

	 GRF grf32 (
    .clk(clk), 
    .reset(reset), 
    .RegWrite(w_grf_we), 
    .a1(rs_D), 
    .a2(rt_D), 
    .a3(w_grf_addr), 
    .WD(w_grf_wdata),  
    .RD1(RD1), 
    .RD2(RD2)
    );
	 
	 CTRL ctrl (
    .op(op), 
    .func(func), 
    .RegWrite(RegWrite_D), 
    .RegDst(RegDst_D), 
    .ALUSrc(ALUSrc_D), 
    .MemOp(MemOp_D), 
    .WDSrc1(WDSrc1_D), 
	 .WDSrc2(WDSrc2_D),
    .NPCOp(NPCOp), 
    .ALUOp(ALUOp_D), 
    .EXTOp(EXTOp),
	 .CMPOp(CMPOp),
	 .MDUOp(MDUOp_D),	 
    .Tnew(Tnew_D)
    );

	 CMP cmp (
    .c1(ALU1_D), 
    .c2(ALU2_D), 
    .CMPOp(CMPOp), 
    .CMPOut(branch) 
    );

	 EXT ext (
    .Imm16(Imm16), 
    .EXTOp(EXTOp), 
    .EXTOut(EXTOut_D)
    );
	 
	 reg_E E(
    .clk(clk), 
    .reset(reset | stall), 
    .ALU1_D(ALU1_D), 
    .ALU2_D(ALU2_D), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rd_D(rd_D), 
    .EXTOut_D(EXTOut_D), 
    .instr_D(instr_D), 
    .PC_D(PC_D), 
    .RegWrite_D(RegWrite_D), 
    .RegDst_D(RegDst_D), 
    .ALUSrc_D(ALUSrc_D), 
    .MemOp_D(MemOp_D), 
    .WDSrc1_D(WDSrc1_D),
	 .WDSrc2_D(WDSrc2_D),	 
    .ALUOp_D(ALUOp_D),
    .MDUOp_D(MDUOp_D),	 
    .Tnew_D(Tnew_D), 
    .ALU1_E(ALU1_E), 
    .ALU2_E(ALU2_E), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .rd_E(rd_E), 
    .EXTOut_E(EXTOut_E), 
    .instr_E(instr_E), 
    .PC_E(PC_E), 
    .RegWrite_E(RegWrite_E), 
    .RegDst_E(RegDst_E), 
    .ALUSrc_E(ALUSrc_E), 
    .MemOp_E(MemOp_E), 
    .WDSrc1_E(WDSrc1_E),
	 .WDSrc2_E(WDSrc2_E), 
    .ALUOp_E(ALUOp_E),
    .MDUOp_E(MDUOp_E),	 
    .Tnew_E(Tnew_E)
    );
	 
	 Hazard hazard (
    .Tnew_E(Tnew_E), 
    .Tnew_M(Tnew_M), 
    .Tnew_W(Tnew_W), 
    .op(op), 
    .func(func), 
    .RegWrite_E(RegWrite_E), 
    .RegWrite_M(RegWrite_M), 
    .RegWrite_W(w_grf_we), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .rt_M(rt_M), 
    .WriteReg_E(WriteReg_E), 
    .WriteReg_M(WriteReg_M), 
    .WriteReg_W(w_grf_addr), 
    .MDUOp(MDUOp_D),
	 .start(start), 
	 .busy(busy), 
	 .stall(stall), 
    .forward_CMP1(forward_CMP1), 
    .forward_CMP2(forward_CMP2), 
    .forward_ALU1(forward_ALU1), 
    .forward_ALU2(forward_ALU2), 
    .forward_DM(forward_DM)
    );
	 
	 ALU alu (
    .a(ALUa), 
    .b(ALUb), 
    .ALUOp(ALUOp_E), 
    .ALUOut(ALUResult) 
    );
	 
	 MulDiv mdu (
    .clk(clk), 
    .reset(reset), 
    .a(ALUa), 
    .b(WriteData_E), 
    .MDUOp(MDUOp_E), 
    .out(MDUOut), 
    .Busy(busy)
    );

	 reg_M M (
    .clk(clk), 
    .reset(reset), 
    .ALUOut_E(ALUOut_E), 
    .WriteData_E(WriteData_E), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .WriteReg_E(WriteReg_E), 
    .instr_E(instr_E), 
    .PC_E(PC_E), 
    .RegWrite_E(RegWrite_E), 
    .MemOp_E(MemOp_E), 
    .WDSrc2_E(WDSrc2_E), 
    .Tnew_E(Tnew_E), 
    .ALUOut_M(m_data_addr), 
    .WriteData_M(WriteData_M), 
    .rs_M(rs_M), 
    .rt_M(rt_M), 
    .WriteReg_M(WriteReg_M), 
    .instr_M(instr_M), 
    .PC_M(m_inst_addr), 
    .RegWrite_M(RegWrite_M), 
    .MemOp_M(MemOp_M), 
    .WDSrc2_M(WDSrc2_M), 
    .Tnew_M(Tnew_M)
    );
	 
	 BE be (
    .addr(m_data_addr), 
    .MemOp(MemOp_M), 
    .DMIn(DMIn), 
    .m_data_byteen(m_data_byteen), 
    .m_data_wdata(m_data_wdata)
    );
    
	 DE de (
    .addr(m_data_addr), 
    .in(m_data_rdata), 
    .MemOp(MemOp_M), 
    .out(DMOut_M)
    );

	 reg_W W (
    .clk(clk), 
    .reset(reset), 
    .ALUOut_M(m_data_addr), 
    .DMOut_M(DMOut_M), 
    .WriteReg_M(WriteReg_M), 
    .instr_M(instr_M), 
    .PC_M(m_inst_addr), 
    .RegWrite_M(RegWrite_M), 
    .WDSrc2_M(WDSrc2_M), 
    .Tnew_M(Tnew_M), 
    .ALUOut_W(ALUOut_W), 
    .DMOut_W(DMOut_W), 
    .WriteReg_W(w_grf_addr), 
    .instr_W(instr_W), 
    .PC_W(w_inst_addr), 
    .RegWrite_W(w_grf_we), 
    .WDSrc2_W(WDSrc2_W), 
    .Tnew_W(Tnew_W)
    );
	 

endmodule
