data segment
year db 4 dup(00h)
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ans db 00h
space db 0dh,0ah,24h
msg1 db "Eligible for voting:$"
msg2 db "Not Eligible for voting:$"
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
mov cx,02h
mov bx,00h
;packing
packing:
mov al,[di+2]
push cx
mov cx,08h
epack:
rcr al,1
rcl bx,1
loop epack
pop cx
inc di
loop packing
;
mov dl,24h
sub dl,bl
das
cmp dl,18h
jbe neligible
print msg1
jmp endc
neligible:
print msg2

endc:mov ah,4ch
     int 21h

code ends 
end start