data segment
msg1 db 4h
msg2 db "The number is even$"
msg3 db "The number is odd$"
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov al,msg1
and al,01h
jz even

lea dx,msg3
jmp to
even:
lea dx,msg2

jmp to
to:
mov ah,09h
int 21h
mov ah,4ch
int 21h
code ends
end start