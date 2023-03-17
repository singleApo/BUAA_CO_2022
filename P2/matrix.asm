.data
matrix1: .space 256
matrix2: .space 256
str_enter: .asciiz "\n"
str_space: .asciiz " "

.macro getindex(%ans, %i, %j)
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro 


.text
li $v0, 5
syscall
move $s0, $v0 #nxn square

li $t0, 0 #i
in1_i: #matrix_a
beq $t0, $s0, in1_i_end
li $t1, 0 #j

    in1_j:
    beq $t1, $s0, in1_j_end
    li $v0, 5
    syscall
    getindex($t2, $t0, $t1)
    sw $v0,matrix1($t2)
    addi $t1, $t1, 1
    j in1_j

in1_j_end:
addi $t0, $t0, 1
j in1_i

in1_i_end:
li $t0, 0

in2_i: #matrix_b
beq $t0, $s0, in2_i_end
li $t1, 0

    in2_j:
    beq $t1, $s0, in2_j_end
    li $v0, 5
    syscall
    getindex($t2, $t0, $t1)
    sw $v0,matrix2($t2)
    addi $t1, $t1, 1
    j in2_j

in2_j_end:
addi $t0, $t0, 1
j in2_i

in2_i_end:
li $t0, 0

out_i: #multiply
beq $t0, $s0, out_i_end
li $t1, 0 #j

    out_j:
    beq $t1, $s0, out_j_end
    li $t2, 0 #k
    li $t3, 0 #result

        out_k:
        beq $t2, $s0, out_k_end
        getindex($t4, $t0, $t2)
        getindex($t5, $t2, $t1)
        lw $t6, matrix1($t4) #a[i][k]
        lw $t7, matrix2($t5) #b[k][j]
        mult $t6, $t7
        mflo $t4 #a[i][k]*b[k][j]
        add $t3, $t3, $t4
        addi $t2, $t2, 1
        j out_k

    out_k_end:
    move $a0, $t3
    li $v0, 1
    syscall #c[i][j]
    la $a0, str_space
    li $v0, 4
    syscall #space
    addi $t1, $t1, 1
    j out_j

out_j_end:
la $a0, str_enter
li $v0, 4
syscall #enter
addi $t0, $t0,1
j out_i

out_i_end:
li $v0, 10
syscall

