data segment
m db 00h
n db 00h
bits db 00h
msg1 db "Enter the first number:$"
msg2 db "Enter the second number:$"
msg3 db "Padded:$"
counter db 00h
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ans db 00h
space db 0dh,0ah,24h
data ends


code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h


;reading
mov ah,01h
int 21h
sub al,30h
mov m,al


lea dx,space 
mov ah,09h
int 21h

lea dx,msg2
mov ah,09h
int 21h


mov ah,01h
int 21h
sub al,30h
mov n,al

lea dx,space 
mov ah,09h
int 21h

lea si,bits
mov dl,m
mov cx,dx
readm:
mov ah,01h
int 21h
sub al,30h
mov [si],al
inc si
loop readm

lea dx,space 
mov ah,09h
int 21h

lea di,bits
mov dl,m
mov cx,dx
mov counter,01h

show:
mov dh,00h
mov dl,[di]
mov al,counter
cmp al,n
jne endlp
xor dl,01h
endlp:
add dl,30h
mov ah,02h
int 21h
inc di
inc counter
loop show


lea dx,space 
mov ah,09h
int 21h
lea dx,msg3
mov ah,09h
int 21h

lea si,bits
mov dl,m
mov cx,dx
showp:
mov dl,[si]
add dl,30h
mov ah,02h
int 21h
push cx
mov dh,00h
mov dl,n
mov cx,dx 
zero:
mov dl,00h
add dl,30h
mov ah,02h
int 21h
loop zero
pop cx
inc si
loop showp


mov ah,4ch
int 21h


dis proc 
push bx
lea bx,convt
mov al,ans
xlatb
pop bx
ret
dis endp
code ends
end start