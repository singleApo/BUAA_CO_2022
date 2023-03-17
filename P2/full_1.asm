.data
symbol: .word 0 : 16 #initial: symbol[i]=0
array: .word 0 : 16 #initial: array[i]=0
str_enter: .asciiz "\n"
str_space: .asciiz " "

.macro push(%src)
    sw %src, 0($sp)
    subi $sp, $sp, 4
.end_macro

.macro pop(%des)
    addi $sp, $sp, 4
    lw %des, 0($sp) 
.end_macro

.macro printInt(%src)
    move $a0, %src
    li $v0, 1
    syscall
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0 #n

li $a0, 0
jal fullArray
li $v0, 10
syscall #end

fullArray:
    push($ra)
    push($t0)
    push($t1)
    move $t0, $a0 #index
    blt $t0, $s0, else

    if: #index >= n
        li $t1, 0 #i
        for1:
            beq $t1, $s0, end1
            sll $t2, $t1, 2
            lw $t3, array($t2)
            printInt($t3)
            la $a0, str_space
            li $v0, 4
            syscall #space
            addi $t1, $t1, 1
            j for1
        
        end1:
        la $a0, str_enter
  	    li $v0, 4
    	syscall #enter
        pop($t1)
        pop($t0)
        pop($ra)
        jr $ra

    else: #recursion
        li $t1, 0 #i
        for2:
            beq $t1, $s0, end2
            sll $t2, $t1, 2
            lw $t3, symbol($t2)
            bnez $t3, else2
            if2:
                sll $t4, $t0, 2
                addi $t5, $t1, 1
                sw $t5, array($t4)
                sll $t4, $t1, 2
                li $t5, 1
                sw $t5, symbol($t4) #symobl[i]=1
                addi $a0, $t0, 1
                jal fullArray
                sll $t4, $t1, 2
                li $t5, 0
                sw $t5, symbol($t4) #symobl[i]=0
            else2:
                addi $t1, $t1, 1
                j for2
        end2:
        pop($t1)
        pop($t0)
        pop($ra)
        jr $ra
        