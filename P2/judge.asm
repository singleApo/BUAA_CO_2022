.data
string: .space 32

.text
li $v0, 5
syscall
move $s0, $v0 #length
li $t0, 0 #i
in:
beq $t0, $s0, in_end
li $v0,12
syscall #char
sb $v0, string($t0)
addi $t0, $t0, 1
j in

in_end:
li $t0, 0 #head
subi $t1, $s0, 1 #tail
li $s1, 0 #isn't

judge:
bge $t0, $t1, isJudge
lb $t2, string($t0)
lb $t3, string($t1)
addi $t0, $t0, 1
subi $t1, $t1, 1
beq $t2, $t3, judge
j end

isJudge:
li $s1, 1 #is
j end

end:
move $a0, $s1
li $v0, 1
syscall #0/1
li $v0, 10
syscall


