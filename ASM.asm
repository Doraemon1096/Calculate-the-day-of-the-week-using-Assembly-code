.data
day: .asciiz "Enter the day: "
month: .asciiz "Enter the month: "
year: .asciiz "Enter the year: "

choice: .asciiz "Select a number from 1 to 7: "
result: .asciiz "The result: "
eol: .asciiz "\n"

currency: .asciiz "days"

is_leap_year: .asciiz "True\n"
is_not_leap_year: .asciiz "False\n"

flag_leap_year: .byte 0 # The year input is not leap year by default
flag_leap_year_1: .byte 0 # For the second date

days_in_year: .word 365
leap_year_count: .word 0
backup_year: .word 0

second_date: .asciiz "Input another date please.\n"
choice_2_error: .asciiz "Your choice is not valid, please choose again.\n"
choice_2_selection: .asciiz "Please choose A, B or C: "

title: .asciiz "------------You can select one of the number below--------------\n"
choice_1: .asciiz "1. Print the date on the screen in format DD/MM/YY.\n"
choice_2: .asciiz "2. Print the date in format:\n"
A: .asciiz "A: MM/DD/YY.\n"
B: .asciiz "B: Month DD, YY.\n"
C: .asciiz "C: DD Month, YY.\n"
choice_3: .asciiz "3. Find the weekday of the input date.\n"
choice_4: .asciiz "4. Check whether the year input is leap year or not.\n"
choice_5: .asciiz "5. Calculate the duration between two date (how many days left).\n"
choice_6: .asciiz "6. Find the two nearest leap year according to the input date.\n"
choice_7: .asciiz "7. Exit the program.\n"

errorchoice: .asciiz "Your selection is overloaded, please try again.\n"
errordate: .asciiz "The date is invalid, please enter again.\n"

numbers_of_day: .word 31,28,31,30,31,30,31,31,30,31,30,31 # February has 28 days by default (not leap year)
numbers_of_day_1: .word 31,28,31,30,31,30,31,31,30,31,30,31 # February has 28 days by default (not leap year)
month_table: .word 0,3,3,6,1,4,6,2,5,0,3,5 # The year is not leap year by default

monday: .asciiz "Monday\n"
tuesday: .asciiz "Tuesday\n"
wednesday: .asciiz "Wednesday\n"
thursday: .asciiz "Thursday\n"
friday: .asciiz "Friday\n"
saturday: .asciiz "Saturday\n"
sunday: .asciiz "Sunday\n"
 
january: .asciiz "January"
february: .asciiz "February"
march: .asciiz "March"
april: .asciiz "April"
may: .asciiz "May"
june: .asciiz "June"
july: .asciiz "July"
august: .asciiz "August"
september: .asciiz "September"
october: .asciiz "October"
november: .asciiz "November"
december: .asciiz "December"

.text
main_program:
# Print selections to the screen
la $a0,title
li $v0,4
syscall

la $a0,choice_1
li $v0,4
syscall

la $a0,choice_2
li $v0,4
syscall

la $a0,A
li $v0,4
syscall

la $a0,B
li $v0,4
syscall

la $a0,C
li $v0,4
syscall

la $a0,choice_3
li $v0,4
syscall

la $a0,choice_4
li $v0,4
syscall

la $a0,choice_5
li $v0,4
syscall

la $a0,choice_6
li $v0,4
syscall

la $a0,choice_7
li $v0,4
syscall

main:
Set_to_default:
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0($a0)
la $a0,flag_leap_year
lb $t0,($a0)
beq $t0,0,Input_day
addi $t0,$zero,0
sb $t0,($a0)
la $a0,month_table
sw $t0,($a0)
addi $t0,$zero,3
sw $t0,4($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)

Input_day:
la $a0,day
li $v0,4
syscall
li $v0,5
syscall
add $s0,$zero,$v0

Input_month:
la $a0,month
li $v0,4
syscall
li $v0,5
syscall
add $s1,$zero,$v0

Input_year:
la $a0,year
li $v0,4
syscall
li $v0,5
syscall
add $s2,$zero,$v0

Check_year:
slt $t0,$s2,$zero
bne $t0,1,Check_month
la $a0,errordate
li $v0,4
syscall
j main

Check_month:
addi $t1,$zero,13
slt $t0,$s1,$t1 # Check whether the month is greater than twelve
slt $t1,$zero,$s1
bne $t0,0,Month_Flag
la $a0,errordate
li $v0,4
syscall
j main
Month_Flag: # Check whether the month is smaller than one
bne $t1,0,Condition_1
la $a0,errordate
li $v0,4
syscall
j main

# Check if it is leap year or not
Condition_1:
move $t0,$s2
addi $t3,$zero,400
div $t0,$t3
mfhi $t1 # Get the quotient from the high register
bne $t1,0,Condition_2
addi $t1,$zero,1
la $t0,flag_leap_year
sb $t1,($t0)
la $a0,numbers_of_day # If it is leap year then February has 29 days
addi $t0,$zero,29
sw $t0,4($a0)
j Check_day

Condition_2:
move $t0,$s2
addi $t3,$zero,4
div $t0,$t3
mfhi $t1
bne $t1,0,Check_day
move $t0,$s2
addi $t3,$zero,100
div $t0,$t3
mfhi $t1
beq $t1,0,Check_day
addi $t1,$zero,1
la $t0,flag_leap_year
sb $t1,($t0)
la $a0,numbers_of_day # If it is leap year then February has 29 days
addi $t0,$zero,29
sw $t0,4($a0)

Check_day:
la $a0,numbers_of_day
beq $s1,1,one
beq $s1,2,two
beq $s1,3,three
beq $s1,4,four
beq $s1,5,five
beq $s1,6,six
beq $s1,7,seven
beq $s1,8,eight
beq $s1,9,nine
beq $s1,10,ten
beq $s1,11,eleven
beq $s1,12,twelve

one:
lw $t0,($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_1
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_1:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

two:
lw $t0,4($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_2
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_2:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

three:
lw $t0,8($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_3
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_3:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

four:
lw $t0,12($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_4
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_4:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

five:
lw $t0,16($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_5:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

six:
lw $t0,20($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_6
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_6:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

seven:
lw $t0,24($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_7
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_7:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

eight:
lw $t0,28($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_8
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_8:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

nine:
lw $t0,32($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_9
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_9:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

ten:
lw $t0,36($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_10
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_10:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

eleven:
lw $t0,40($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_11
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_11:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main

twelve:
lw $t0,44($a0)
addi $t0,$t0,1
slt $t1,$s0,$t0
slt $t0,$zero,$s0
bne $t1,0,day_flag_12
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
day_flag_12:
bne $t0,0,Methods
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day
addi $t0,$zero,28
sw $t0,4($a0)
j main
Find_month_table_value:
la $a0,flag_leap_year
lb $t0,($a0)
beq $t0,0,Methods
la $a0,month_table
addi,$t0,$zero,6
sw $t0,($a0)
addi $t0,$zero,2
sw $t0,4($a0)

Methods:
# Input user's selection
Input_choice:
la $a0,choice
li $v0,4
syscall
li $v0,5
syscall
add $t7,$zero,$v0
addi $t0,$zero,1
addi $t1,$zero,7
slt $t2,$t7,$t0
bne $t2,$t0,Error_Check
# Print the error to the screen
la $a0,errorchoice
li $v0,4
syscall
j Input_choice
Error_Check:
slt $t3,$t1,$t7
bne $t3,$t0,Flag
# Print the error to the screen, ask the user to input the choice again
la $a0,errorchoice
li $v0,4
syscall
j Input_choice
Flag:
beq $t7,1,Flag_1
beq $t7,2,Flag_2
beq $t7,3,Flag_3
beq $t7,4,Flag_4
beq $t7,5,Flag_5
beq $t7,6,Flag_6
beq $t7,7,Exit
Flag_1:
la $a0,result
li $v0,4
syscall
li $v0,1
add $a0,$zero,$s0
syscall
li $v0,11
add $a0,$zero,47
syscall
li $v0,1
add $a0,$zero,$s1
syscall
li $v0,11
add $a0,$zero,47
syscall
li $v0,1
add $a0,$zero,$s2
syscall
li $v0,4
la $a0,eol
syscall
j main
Flag_2:
la $a0,choice_2_selection
li $v0,4
syscall
li $v0,12
syscall
move $t0,$v0
beq $t0,'A',Choice_2_A
beq $t0,'B',Choice_2_B
beq $t0,'C',Choice_2_C
la $a0,choice_2_error
li $v0,4
syscall
la $a0,eol
syscall
j Flag_2
Choice_2_A:
la $a0,result
li $v0,4
syscall
li $v0,1
add $a0,$zero,$s1
syscall
li $v0,11
add $a0,$zero,47
syscall
li $v0,1
add $a0,$zero,$s0
syscall
li $v0,11
add $a0,$zero,47
syscall
li $v0,1
add $a0,$zero,$s2
syscall
li $v0,4
la $a0,eol
syscall
j main
Choice_2_B:
la $a0,result
li $v0,4
syscall
beq $s1,1,Format_1
beq $s1,2,Format_2
beq $s1,3,Format_3
beq $s1,4,Format_4
beq $s1,5,Format_5
beq $s1,6,Format_6
beq $s1,7,Format_7
beq $s1,8,Format_8
beq $s1,9,Format_9
beq $s1,10,Format_10
beq $s1,11,Format_11
beq $s1,12,Format_12
Format_1:
la $a0,january
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_2:
la $a0,february
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_3:
la $a0,march
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_4:
la $a0,april
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_5:
la $a0,may
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_6:
la $a0,june
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_7:
la $a0,july
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_8:
la $a0,august
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_9:
la $a0,september
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_10:
la $a0,october
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_11:
la $a0,november
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_12:
la $a0,december
li $v0,4
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Choice_2_C:
la $a0,result
li $v0,4
syscall
beq $s1,1,Format_1_C
beq $s1,2,Format_2_C
beq $s1,3,Format_3_C
beq $s1,4,Format_4_C
beq $s1,5,Format_5_C
beq $s1,6,Format_6_C
beq $s1,7,Format_7_C
beq $s1,8,Format_8_C
beq $s1,9,Format_9_C
beq $s1,10,Format_10_C
beq $s1,11,Format_11_C
beq $s1,12,Format_12_C
Format_1_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,january
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_2_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,february
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_3_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,march
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_4_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,april
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_5_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,may
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_6_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,june
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_7_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,july
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_8_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,august
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_9_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,september
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_10_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,october
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_11_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,november
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Format_12_C:
add $a0,$zero,$s0
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,december
li $v0,4
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
li $v0,11
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Flag_3:
la $a0,result
li $v0,4
syscall
beq $s1,1,Value_1
beq $s1,2,Value_2
beq $s1,3,Value_3
beq $s1,4,Value_4
beq $s1,5,Value_5
beq $s1,6,Value_6
beq $s1,7,Value_7
beq $s1,8,Value_8
beq $s1,9,Value_9
beq $s1,10,Value_10
beq $s1,11,Value_11
beq $s1,12,Value_12
Value_1:
la $a0,month_table
lw $t0,($a0)
j Flag_3_A
Value_2:
la $a0,month_table
lw $t0,4($a0)
j Flag_3_A
Value_3:
la $a0,month_table
lw $t0,8($a0)
j Flag_3_A
Value_4:
la $a0,month_table
lw $t0,12($a0)
j Flag_3_A
Value_5:
la $a0,month_table
lw $t0,16($a0)
j Flag_3_A
Value_6:
la $a0,month_table
lw $t0,20($a0)
j Flag_3_A
Value_7:
la $a0,month_table
lw $t0,24($a0)
j Flag_3_A
Value_8:
la $a0,month_table
lw $t0,28($a0)
j Flag_3_A
Value_9:
la $a0,month_table
lw $t0,32($a0)
j Flag_3_A
Value_10:
la $a0,month_table
lw $t0,36($a0)
j Flag_3_A
Value_11:
la $a0,month_table
lw $t0,40($a0)
j Flag_3_A
Value_12:
la $a0,month_table
lw $t0,44($a0)
Flag_3_A:
move $t1,$s2
addi $t2,$zero,100
div $t1,$t2
mfhi $t1
move $t5,$t1
addi $t2,$zero,4
div $t1,$t2
mflo $t1
move $t2,$s2
addi $t3,$zero,100
div $t2,$t3
mflo $t2
addi $t2,$t2,1
move $t4,$s0
add $t4,$t4,$t0
add $t4,$t4,$t1
add $t4,$t4,$t5
add $t4,$t4,$t2
addi $t0,$zero,7
div $t4,$t0
mfhi $t0
beq $t0,1,Sun
beq $t0,2,Mon
beq $t0,3,Tue
beq $t0,4,Wed
beq $t0,5,Thu
beq $t0,6,Fri
beq $t0,7,Sat
Sun:
la $a0,sunday
li $v0,4
syscall
j main
Mon:
la $a0,monday
li $v0,4
syscall
j main
Tue:
la $a0,tuesday
li $v0,4
syscall
j main
Wed:
la $a0,wednesday
li $v0,4
syscall
j main
Thu:
la $a0,thursday
li $v0,4
syscall
j main
Fri:
la $a0,friday
li $v0,4
syscall
j main
Sat:
la $a0,saturday
li $v0,4
syscall
j main
Flag_4:
la $a0,result
li $v0,4
syscall
la $t0,flag_leap_year
lb $t1,($t0)
beq $t1,1,IsLeapYear
la $a0,is_not_leap_year
li $v0,4
syscall
j main
IsLeapYear:
la $a0,is_leap_year
li $v0,4
syscall
j main
Flag_5:
la $a0,second_date
li $v0,4
syscall
main_1:
Input_day_1:
la $a0,day
li $v0,4
syscall
li $v0,5
syscall
add $s3,$zero,$v0

Input_month_1:
la $a0,month
li $v0,4
syscall
li $v0,5
syscall
add $s4,$zero,$v0

Input_year_1:
la $a0,year
li $v0,4
syscall
li $v0,5
syscall
add $s5,$zero,$v0

Check_year_1:
slt $t0,$s5,$zero
bne $t0,1,Check_month_1
la $a0,errordate
li $v0,4
syscall
j main_1

Check_month_1:
addi $t1,$zero,13
slt $t0,$s4,$t1 # Check whether the month is greater than twelve
slt $t1,$zero,$s4
bne $t0,0,Month_Flag_1
la $a0,errordate
li $v0,4
syscall
j main_1
Month_Flag_1: # Check whether the month is smaller than one
bne $t1,0,Condition_1_a
la $a0,errordate
li $v0,4
syscall
j main_1

# Check if it is leap year or not
Condition_1_a:
move $t0,$s5
addi $t3,$zero,400
div $t0,$t3
mfhi $t1 # Get the quotient from the high register
bne $t1,0,Condition_2_a
addi $t1,$zero,1
la $t0,flag_leap_year_1
sb $t1,($t0)
la $a0,numbers_of_day_1 # If it is leap year then February has 29 days
addi $t0,$zero,29
sw $t0,4($a0)
j Check_day_1

Condition_2_a:
move $t0,$s5
addi $t3,$zero,4
div $t0,$t3
mfhi $t1
bne $t1,0,Check_day_1
move $t0,$s5
addi $t3,$zero,100
div $t0,$t3
mfhi $t1
beq $t1,0,Check_day_1
addi $t1,$zero,1
la $t0,flag_leap_year_1
sb $t1,($t0)
la $a0,numbers_of_day_1 # If it is leap year then February has 29 days
addi $t0,$zero,29
sw $t0,4($a0)

Check_day_1:
la $a0,numbers_of_day_1
beq $s4,1,one_a
beq $s4,2,two_a
beq $s4,3,three_a
beq $s4,4,four_a
beq $s4,5,five_a
beq $s4,6,six_a
beq $s4,7,seven_a
beq $s4,8,eight_a
beq $s4,9,nine_a
beq $s4,10,ten_a
beq $s4,11,eleven_a
beq $s4,12,twelve_a

one_a:
lw $t0,($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_1_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_1_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

two_a:
lw $t0,4($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_2_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_2_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

three_a:
lw $t0,8($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_3_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_3_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

four_a:
lw $t0,12($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_4_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_4_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

five_a:
lw $t0,16($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_5_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_5_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

six_a:
lw $t0,20($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_6_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_6_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

seven_a:
lw $t0,24($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_7_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_7_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

eight_a:
lw $t0,28($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_8_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_8_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

nine_a:
lw $t0,32($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_9_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_9_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

ten_a:
lw $t0,36($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_10_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_10_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

eleven_a:
lw $t0,40($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_11_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_11_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1

twelve_a:
lw $t0,44($a0)
addi $t0,$t0,1
slt $t1,$s3,$t0
slt $t0,$zero,$s3
bne $t1,0,day_flag_12_a
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
day_flag_12_a:
bne $t0,0,Methods_f5
la $a0,errordate
li $v0,4
syscall
la $a0,flag_leap_year_1
addi $t0,$zero,0
sb $t0,($a0)
la $a0,numbers_of_day_1
addi $t0,$zero,28
sw $t0,4($a0)
j main_1
Methods_f5: # 1/1/year_1 -> Date_1/year_1 -> Duration -> 1/1/year_2 -> Date_2/year_2 -> 31/12/year_2
beq $s5,$s2,GMonth
slt $t0,$s2,$s5
bne $t0,1,switch_date
j Calculation
GMonth:
beq $s1,$s4,GDay
slt $t0,$s1,$s4
bne $t0,1,switch_date
j Calculation
GDay:
beq $s0,$s3,Calculation
slt $t0,$s0,$s3
bne $t0,1,switch_date
j Calculation
switch_date: # Make sure $s0, $s1, $s2 is the smaller date
move $t0,$s0
move $t1,$s1
move $t2,$s2
move $s0,$s3
move $s1,$s4
move $s2,$s5
move $s3,$t0
move $s4,$t1
move $s5,$t2
la $a0,numbers_of_day
lw $t0,4($a0)
la $a0,numbers_of_day_1
lw $t1,4($a0)
sw $t0,4($a0)
la $a0,numbers_of_day
sw $t1,4($a0)
la $a0,flag_leap_year
lb $t0($a0)
la $a0,flag_leap_year_1
lb $t1,($a0)
sb $t0($a0)
la $a0,flag_leap_year
sb $t1,($a0)
Calculation:
sub $t2,$s5,$s2
addi $t2,$t2,1
addi $t0,$zero,365
multu $t2,$t0
mflo $t2
la $a0,backup_year
add $t4,$zero,$s2
sw $t4,($a0)
addi $t5,$zero,0
addi $t6,$s5,1
j Condition_1_5
Next_year_5:
addi $s2,$s2,1
beq $s2,$t6,Finish_counting
Condition_1_5:
move $t0,$s2
addi $t3,$zero,400
div $t0,$t3
mfhi $t1 # Get the quotient from the high register
bne $t1,0,Condition_2_5
la $a0,leap_year_count
addi $t5,$t5,1
sw $t5,($a0)
j Next_year_5

Condition_2_5:
move $t0,$s2
addi $t3,$zero,4
div $t0,$t3
mfhi $t1
bne $t1,0,Next_year_5
move $t0,$s2
addi $t3,$zero,100
div $t0,$t3
mfhi $t1
beq $t1,0,Next_year_5
la $a0,leap_year_count
addi $t5,$t5,1
sw $t5,($a0)
j Next_year_5
Finish_counting:
la $a0,leap_year_count
lw $t0,($a0)
add $t2,$t2,$t0 # Total days between two year
la $a0,backup_year
lw $s2,($a0)
Get_days_1:
beq $s1,1,Days_1
beq $s1,2,Days_2
beq $s1,3,Days_3
beq $s1,4,Days_4
beq $s1,5,Days_5
beq $s1,6,Days_6
beq $s1,7,Days_7
beq $s1,8,Days_8
beq $s1,9,Days_9
beq $s1,10,Days_10
beq $s1,11,Days_11
beq $s1,12,Days_12
Days_1:
add $t0,$zero,$s0
j Get_days_2
Days_2:
la $a0,numbers_of_day
lw $t0,($a0)
add $t0,$t0,$s0
j Get_days_2
Days_3:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_4:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_5:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_6:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_7:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_8:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_9:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_10:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_11:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
lw $t1,36($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0
j Get_days_2
Days_12:
la $a0,numbers_of_day
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
lw $t1,36($a0)
add $t0,$t0,$t1
lw $t1,40($a0)
add $t0,$t0,$t1
add $t0,$t0,$s0

Get_days_2:
move $t3,$t0
beq $s4,1,Days_1_p
beq $s4,2,Days_2_p
beq $s4,3,Days_3_p
beq $s4,4,Days_4_p
beq $s4,5,Days_5_p
beq $s4,6,Days_6_p
beq $s4,7,Days_7_p
beq $s4,8,Days_8_p
beq $s4,9,Days_9_p
beq $s4,10,Days_10_p
beq $s4,11,Days_11_p
beq $s4,12,Days_12_p
Days_1_p:
add $t0,$zero,$s3
j Finish_getting_days
Days_2_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
add $t0,$t0,$s3
j Finish_getting_days
Days_3_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_4_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_5_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_6_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_7_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_8_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_9_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_10_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_11_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
lw $t1,36($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
j Finish_getting_days
Days_12_p:
la $a0,numbers_of_day_1
lw $t0,($a0)
lw $t1,4($a0)
add $t0,$t0,$t1
lw $t1,8($a0)
add $t0,$t0,$t1
lw $t1,12($a0)
add $t0,$t0,$t1
lw $t1,16($a0)
add $t0,$t0,$t1
lw $t1,20($a0)
add $t0,$t0,$t1
lw $t1,24($a0)
add $t0,$t0,$t1
lw $t1,28($a0)
add $t0,$t0,$t1
lw $t1,32($a0)
add $t0,$t0,$t1
lw $t1,36($a0)
add $t0,$t0,$t1
lw $t1,40($a0)
add $t0,$t0,$t1
add $t0,$t0,$s3
Finish_getting_days:
move $t4,$t0
la $a0,flag_leap_year_1
lb $t0,($a0)
beq $t0,1,Sub_leap_year
addi $t1,$zero,365
sub $t4,$t1,$t4
j Final_result
Sub_leap_year:
addi $t1,$zero,366
sub $t4,$t1,$t4
Final_result:
la $a0,result
li $v0,4
syscall
sub $t2,$t2,$t4
sub $t2,$t2,$t3
add $a0,$zero,$t2
li $v0,1
syscall
li $a0,32
li $v0,11
syscall
la $a0,currency
li $v0,4
syscall
la $a0,eol
li $v0,4
syscall
j main

Flag_6:
la $a0,result
li $v0,4
syscall
la $a0,flag_leap_year
lb $t0,($a0)
bne $t0,1,Find_the_nearest_leap_year
addi $a0,$s2,4 # First Leap Year -> 1 -> 2 -> 3 -> Current Leap Year -> 1 -> 2 -> 3 -> Next Leap Year
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
syscall
subi $a0,$s2,4
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Find_the_nearest_leap_year: # First Leap Year -> 1 -> 2 -> 3 -> Next Leap Year/ for any year except leap year
Next_year:
addi $s2,$s2,1
Condition_1_c:
move $t0,$s2
addi $t3,$zero,400
div $t0,$t3
mfhi $t1
bne $t1,0,Condition_2_c
j Print_leap_year_1
Condition_2_c:
move $t0,$s2
addi $t3,$zero,4
div $t0,$t3
mfhi $t1
bne $t1,0,Next_year
move $t0,$s2
addi $t3,$zero,100
div $t0,$t3
mfhi $t1
beq $t1,0,Next_year
Print_leap_year_1:
subi $a0,$s2,4
li $v0,1
syscall
li $a0,44
li $v0,11
syscall
li $a0,32
syscall
add $a0,$zero,$s2
li $v0,1
syscall
la $a0,eol
li $v0,4
syscall
j main
Exit:
li $v0,10
syscall
