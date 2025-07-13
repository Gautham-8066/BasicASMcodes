data segment
wd db 8 dup(00h)
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea bx,wd

mov cx,08h
read:
mov ah,01h
int 21h

mov [bx],al
inc bx
loop read

lea di,wd
mov cx,08h
displ:
mov dl,[di]
xor dl,20h

mov ah,02h
int 21h
inc di
loop displ


code ends
end start