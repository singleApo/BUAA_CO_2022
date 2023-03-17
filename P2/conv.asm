.data
matrix_f: .space 2048
matrix_h: .space 2048
str_enter: .asciiz "\n"
str_space: .asciiz " "

.macro input
	li $v0, 5
	syscall
.end_macro

.macro getindex(%ans, %i, %j)
	sll %ans, %i, 4
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro


.text
input
move $s0, $v0 #m1
input
move $s1, $v0 #n1
input
move $s2, $v0 #m2
input
move $s3, $v0 #n2
sub $s4, $s0, $s2
addi $s4, $s4, 1 #g_i
sub $s5, $s1, $s3
addi $s5, $s5, 1 #g_j

li $t0, 0 #i
in1_i: #matrix_f
beq $t0, $s0, in1_i_end
li $t1, 0 #j

    in1_j:
    beq $t1, $s1, in1_j_end
    input
    getindex($t2, $t0, $t1)
    sw $v0,matrix_f($t2)
    addi $t1, $t1, 1
    j in1_j

in1_j_end:
addi $t0, $t0, 1
j in1_i

in1_i_end:
li $t0, 0

in2_i: #matrix_h
beq $t0, $s2, in2_i_end
li $t1, 0

    in2_j:
    beq $t1, $s3, in2_j_end
    input
    getindex($t2, $t0, $t1)
    sw $v0,matrix_h($t2)
    addi $t1, $t1, 1
    j in2_j

in2_j_end:
addi $t0, $t0, 1
j in2_i

in2_i_end:
li $t0, 0 #i

out_i: #convolution
beq $t0, $s4, out_i_end
li $t1, 0 #j

    out_j:
    beq $t1, $s5, out_j_end
    li $t2, 0 #k
    li $t4, 0 #g[i][j]

        out_k:
        beq $t2, $s2, out_k_end
        li $t3, 0 #l
        
            out_l:
            beq $t3, $s3, out_l_end
            add $t5, $t0, $t2
            add $t6, $t1, $t3
            getindex($t5, $t5, $t6)
            getindex($t6, $t2, $t3)
            lw $t5, matrix_f($t5) #f[i+k][j+l]
            lw $t6, matrix_h($t6) #h[k][l]
            mult $t5, $t6
            mflo $t7 #multiply
            add $t4, $t4, $t7
            addi $t3, $t3, 1
            j out_l
        
        out_l_end:
        addi $t2, $t2, 1
        j out_k

    out_k_end:
    move $a0, $t4
    li $v0, 1
    syscall #g[i][j]
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