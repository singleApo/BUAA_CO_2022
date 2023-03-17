# P5 document
21371295 张昊翔
***
## 设计草稿
### NPC
| NPCOp | NPC |
| :--: | :--: |
| 00 | PC_F + 4 |
| 01 | PC_D + 4 + sign_extend(offset\|\|00) |
| 10 | PC_D31..28\|\|instr_index\|\|00 |
| 11 | GPR[rs_D] |

### IM
取: in[15:2] - 0x3000/4 

### Hazard
以E和D冒险为例:
1. rs_D/rt_D != 0
2. RegWrite_E == 1
3. rs_D = WriteReg_E
#### Tuse
| 指令 | rs | rt |
| :--: | :--: | :--: |
| add | 1 | 1 |
| sub | 1 | 1 |
| ori | 1 | / |
| lui | 1 | / |
| lw | 1 | / |
| sw | 1 | 2 |
| beq | 0 | 0 |
| jr | 0 | / |
| jal | / | / |

#### Tnew
| 部件 | E | M | W |
| :--: | :--: | :--: | :--: |
| ALU | 1 | 0 | 0 |
| DM | 2 | 1 | 0 |
| PC | 0 | 0 | 0 | 
>ALU: add, sub, ori, lui            
DM: lw       
PC: jal    
无: sw, beq, jr     

stall: Tuse(rs/rt) < Tnew(E/M)       

forwardOut: 
>PC_E + 8    
ALUOut_M        
WD        

forwardIn:
>D: ALU1_D, ALU2_D         
E: ALUa, WriteData_E          
M: DMIn

                
### CTRL
```
input wire [5:0] op;
input wire [5:0] func;
reg [18:0] tmp;
```

| 指令 | RegWrite | RegDst | ALUSrc | MemWrite | WDSrc1 | WDSrc2 | NPCOp | ALUOp | EXTOp | CMPOp |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |  :--: |
| add(000000+100000) | 1 | 01 | 0 | 0 |0|0| 00 | 000 | 00 | 00 |
| sub(000000+100010) | 1 | 01 | 0 | 0 |0|0| 00 | 001 | 00 | 00 |
| ori(001101) | 1 | 00 | 1 | 0 |0|0| 00 | 010 | 00 | 00 |
| lw(100011) | 1 | 00 | 1 | 0 |0|1| 00 | 000 | 01 | 00 |
| sw(101011) | 0 | 00 | 1 | 1 |0|0| 00 | 000 | 01 | 00 |
| beq(000100) | 0 | 00 | 0 | 0 |0|0| 01 | 000 | 00 | 00 |
| lui(001111) | 1 | 00 | 1 | 0 |0|0| 00 | 000 | 10 | 00 |
| jal(000011) | 1 | 10 | 0 | 0 |1|0| 10 | 000 | 00 | 00 |
| jr(000000+001000) | 0 | 00 | 0 | 0 |0|0| 11 | 000 | 00 | 00 |

注：`add`与`sub`实际上为`addu`与`subu`，不考虑溢出情况。
#### RegDst_E
[4:0] WriteReg_E
>00: rt_E            
01: rd_E                         
10: 31

#### ALUSrc_E
[31:0] ALUb
>0: WriteData_E                  
1: EXTOut_E            

#### WDSrc1_E
[31:0] ALUOut_E
>0: ALUResult            
1: PC_E + 8           

#### WDSrc2_W
[31:0] WD
>0: ALUOut_W                    
1: DMOut_W                     