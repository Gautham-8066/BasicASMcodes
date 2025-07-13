data segment 
num db 16 dup(00h)
space db 0dh,0ah,24h
msg1 db "Entered byte:$"
msg2 db "Modulo 2:$"
packed dw 0000h
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
data ends
code segment 
assume cs:code,ds:data 
start:
mov ax,data
mov ds,ax

lea bx,num
mov cx,10h
read:
mov ah,01h
int 21h
sub al,30h
mov [bx],al
inc bx
loop read

lea dx,space
mov ah,09h
int 21h 

lea di,num
mov cx,10h
displ:
mov dl,[di]
add dl,30h
mov ah,02h
int 21h
inc di
loop displ
lea dx,space
mov ah,09h
int 21h 
xor dx,dx
lea dx,msg2
mov ah,09h
int 21h
xor dx,dx
mov al,00h
lea bx,num
mov cx,10h
modulo:
xor al,[bx]
inc bx
loop modulo
mov dl,al
add dl,30h
mov ah,02h
int 21h

xor bx,bx
lea di,num
mov cx,10h
packing:
mov al,[di]
rcr al,1
rcl bx,1
inc di
loop packing
mov packed,bx

lea dx,space
mov ah,09h
int 21h 

lea bx,msg1
mov dx,bx
mov ah,09h
int 21h


mov ax,packed
and ax,0f000h
mov cl,04h
rol ax,cl
call dis
mov dx,ax
mov ah,02h
int 21h
mov ax,packed
and ax,00f00h
mov cl,08h
ror ax,cl
call dis
mov dx,ax
mov ah,02h
int 21h
mov ax,packed
and ax,00f0h
mov cl,04h
ror ax,cl
call dis
mov dx,ax
mov ah,02h
int 21h
mov ax,packed
and ax,000fh
call dis
mov dx,ax
mov ah,02h
int 21h



dis proc

push bx 
lea bx,convt
xlatb
pop bx
ret
dis endp


code ends 
end start