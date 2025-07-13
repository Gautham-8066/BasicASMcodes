data segment
ans db 00h
msg1 db "Enter the temperature to be converted:$"
msg2 db 0ah,0dh,24h

data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,30h
mov bh,0Ah
mul bh
mov bl,al
mov ah,01h
int 21h
sub al,30h
add al,bl

mov ans,al
call disp
lea dx,msg2
mov ah,09h
int 21h
mov ah,00h
mov al,ans
add ax,0111h
mov ans,ah
call disp
lea dx,msg2
mov ah,09h
int 21h
mov ans,al
call disp

mov ah,4ch
int 21h



disp proc 
push bx
push cx
push ax
push dx
mov al,ans
and al,0f0h
mov cl,04h
shr al,cl
add al,30h
mov dl,al
mov ah,02h
int 21h
mov al,ans
and al,0fh
add al,30h
mov dl,al
mov ah,02h
int 21h

pop bx
pop cx
pop ax
pop dx
ret
disp endp

code ends
end start