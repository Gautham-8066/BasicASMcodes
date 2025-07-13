data segment
msg1 db 0ah dup(00h)
msg2 db 0ah,0dh,24h
sum db 00h
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov cx,0ah
mov dl,00h
mov si,0h
lea si,msg1

again:
mov ah,01h
int 21h
mov [si],al
sub al,30h
add dl,al
inc si
loop again

mov [sum],dl




mov al,dl
mov bl,dl
mov ah,00h
and al,0f0h
mov cl,04h
shr al,cl
call disp
mov ah,02h
int 21h
mov ah,00h
mov al,bl
and al,0fh
call disp
mov ah,02h
int 21h

mov ah,4ch
int 21h

disp PROC
    push bx
lea bx,convt
xlatb
mov dl,al

pop bx
ret
endp

code ends
end start