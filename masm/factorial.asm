data segment
num db 00h
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
mov cl,al
xor ax,ax
mov ax,01h
mult:
mul cl
loop mult
call dis


dis proc
mov dh,al
and al,0f0h
mov cl,04h
ror al,cl
mov dl,al
push bx
lea bx,convt
xlatb
mov ah,02h
int 21h
mov al,dh
and al,0fh
xlatb
mov ah,02h
int 21h
pop bx
ret
dis endp

code ends 
end start

