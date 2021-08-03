
include const/const.asm
include utility/macro.asm
.model small
.data
input1 db "Enter first number:$"
input2 db 10,13,"Enter second number:$"
msg_div db "cannot divide by zero$"
msg_div2 db "cannot divide larger than num1$"  
msgres db "result: $"    
msgend db 10,13,"Thank you for using this calculator! Press any key...$"
r db 3
c db ?
num1 db ?
num2 db ?
res dw ?
char db ?
;------------------------------------------------------
.code
start:
mov ax,@data
mov ds,ax

lea dx,input1
mov ah,9
int io_int
mov cx,2

get:
mov ah,1
int io_int
cmp cx,1
je a1
cmp al,13
je oknum1
a1:
sub al,30h
cmp ah,9
jg get
cmp ah,0
jl get
cmp cx,1
je n1
jmp n2
n1:
mov num1,al
n2:

mov dl,al
mov ax,10
mul num1
add al,dl
mov num1,al 
oknum1: 

 
lea dx,input2
mov ah,9
int io_int
mov cx,2

get2:
mov ah,1
int io_int 
cmp cx,1
je f1
cmp al,13
je oknum2
f1:
sub al,30h
cmp ah,9
jg get2
cmp ah,0
jl get2
cmp cx,1
je n3
jmp n4
n3:
mov num2,al
n4:
 
mov dl,al
mov ax,10
mul num2
add al,dl
mov num2,al 
oknum2: 



show_menu:
showMenu

     
     
gotoxy proc
    mov dh,r
    mov dl,c
    mov bh,0
    mov ah,2
    int screen_int
    ret
gotoxy endp
showchar proc
    mov ah,2
    int io_int
    ret
showchar endp

add_pr proc
   mov ax,0
    mov bx,0
    mov al,num1
    mov bl,num2
    add ax,bx
    mov res,ax
    ret
add_pr endp
sub_pr proc
    mov ax,0
    mov bx,0
    mov al,num1
    mov bl,num2
    sub ax,bx
    mov res,ax
    ret
sub_pr endp
mul_pr proc
   mov ax,0
    mov bx,0
    mov al,num1
    mov bl,num2
    mul bx
    mov res,ax
    ret
mul_pr endp
div_pr proc
    mov ax,bx
    mov dx,0
    mov al,num1
    mov bl,num2
    cmp bx,0
    je err
    cmp bl,al
    jg err
    div  bx
     mov res,ax
    jmp noerr
    err:
   
    noerr:
    ret
div_pr endp
print_num proc
    cmp char,"/"
    je h_div
    cmp char,"-"
    je h_sub
    jmp h_sub
    h_div:
     cmp num2,0
    je printerr
    mov al,num1
    cmp num2,al
    jg prerr
     h_sub:
    cmp res,0
    jl prm
    jg pro
    prm:
    mov ax,0FFFFh
    sub ax,res
    inc ax
    mov res,ax
    mov dl,"-"
    mov ah,2
    int io_int
    pro: 
    mov ax,0
    mov ax,res
    call print_ax
    jmp k
    printerr:
    lea dx,msg_div
    mov ah,9
    int io_int
    jmp k
    prerr:
    lea dx,msg_div2
    mov ah,9
    int io_int
    k:
    ret 
print_num endp

print_ax proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int screen_int
    pop ax
    ret 
print_ax_r:
    push ax
    push bx
    push dx
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int screen_int    
    jmp pn_done
pn_done:
    pop dx
    pop bx
    pop ax  
    ret  
print_ax endp
end start