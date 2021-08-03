macro box color,row,col,row2,col2
    mov al,0
    mov bh,colorbit
    mov ch,8
    mov cl,col
    mov dh,10
    mov dl,col2
    mov ah,6
    int screen_int 
endm 



macro showMenu

box 1Fh,5,1,5,3
mov r,9
mov c,2
call gotoxy 
mov dl,"+"
call showchar
box 1Fh,5,5,5,7
mov r,9
mov c,6
call gotoxy 
mov dl,"-"
call showchar
box 1Fh,5,9,5,11
mov r,9
mov c,10
call gotoxy
mov dl,"*"
call showchar
box 1Fh,5,13,5,15
mov r,9
mov c,14
call gotoxy
mov dl,"/"
call showchar
mov ax,0
int mouse_int
mov ax,1
int mouse_int
for:
mov ax,3 
int mouse_int
cmp bx,1
je left
jmp for 
left:
cmp dx,28h
jg o1
jl for  
o1:;+
cmp dx,5Fh
jg for
cmp cx,1Fh
jl o2
jg o3
o2:
cmp cx,7h
jg plus
o3:;-
cmp cx,3Fh
jl o4
jg o5
o4:
cmp cx,27h
jg manfi
o5: ;*
cmp cx,5Fh
jl o6
jg o7
o6:
cmp cx,47h
jg zarb
o7:
cmp cx,7Fh
jl o8
jg for
o8:
cmp cx,67h
jg divs
jmp for

plus:
call add_pr 
mov char,"+"
jmp pause
manfi:
call sub_pr
mov char,"-"
jmp pause
zarb:
call mul_pr
mov char,"*"
jmp pause
divs:
call div_pr
mov char,"/"
pause:
mov ax,2
int mouse_int
mov r,15
mov c,0
call gotoxy
lea dx,msgres
mov ah,9
int io_int
call print_num
lea dx,msgend
mov ah,9
int io_int 
mov ah,8
int io_int
mov ax,4c00h
int io_int

endm