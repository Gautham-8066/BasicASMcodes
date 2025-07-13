data segment
temp db 00h
tempk db 00h,00h
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ans db 00h
space db 0dh,0ah,24h
msg1 db "Temperature in kelvin:$"
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov ah,01h
int 21h 
sub al,30h
mov bl,al
mov cl,04h
shl bl,cl


mov ah,01h
int 21h
sub al,30h
add al,bl
mov temp,al

lea dx,space
mov ah,09h
int 21h

lea dx,msg1
mov ah,09h
int 21h

mov al,temp
add al,73h
daa
mov tempk,al
mov cl,02h
adc tempk+1,cl
mov al,tempk+1
mov ans,al
call dis
mov al,tempk
mov ans,al
call dis

mov ah,4ch
int 21h


  
dis proc
push bx
lea bx,convt
mov al,ans
and al,0f0h
mov cl,04h
ror al,cl
xlatb
mov dl,al
mov ah,02h
int 21h
mov al,ans
and al,0fh
xlatb
mov dl,al
mov ah,02h
int 21h
pop bx
ret
dis endp
code ends
end start