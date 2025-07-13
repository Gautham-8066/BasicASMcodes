data segment
year db 4 dup(00h)
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ans db 00h
tmp db 00h
space db 0dh,0ah,24h
ryear db "20$"
msg1 db 0ah,0dh,"Eligible for voting:$"
msg2 db 0ah,0dh,"Not Eligible for voting:$"
msg3 db 0ah,0dh,"Retirement year:20$"
data ends

print macro msg
lea dx,msg
mov ah,09h
int 21h
endm

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

lea si,year
mov cx,04h
ready:
mov ah,01h
int 21h
sub al,30h
mov [si],al
inc si
loop ready


lea di,year
inc di
inc di
mov al,[di]
inc di
mov ah,[di]
mov cl,04h
shl al,cl
add al,ah
mov tmp,al
mov dl,18h
sub dl,al
mov al,dl
das
cmp al,18
jbe neligible
print msg1
jmp endc
neligible:
print msg2

endc:
lea dx,space
mov ah,09h
int 21h
lea dx,msg3
mov ah,09h
int 21h

mov al,tmp
add al,60h
mov bl,al
and al,0f0h
mov cl,04h
ror al,cl
add al,30h
mov dl,al
mov ah,02h
int 21h
mov al,bl
and al,0fh
add al,30h
mov dl,al
mov ah,02h
int 21h


    mov ah,4ch
     int 21h

code ends 
end start