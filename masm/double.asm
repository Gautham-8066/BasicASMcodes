data segment
msg1 db 4h
msg2 db 0ah,0dh,24h
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov ah,01h
int 21h

sub al,30h 
mov bh,02h
mul bh
lea bx,convt
xlatb
mov dl,al
mov ah,02h
int 21h

mov ah,4ch
int 21h
code ends
end start