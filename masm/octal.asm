data segment 
num db 16 dup(00h)
space db 0dh,0ah,24h
msg1 db "Entered byte:$"
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

mov cl,02h
shr bx,cl
and bx,0e000h
mov cl,03h
rol bx,cl
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
mov bx,packed
and bx,07000h
mov cl,04h
rol bx,cl
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
mov bx,packed
and bx,0e00h
mov cl,07h
rol bx,cl
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
mov bx,packed
and bx,01c0h
mov cl,06h
ror bx,cl
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
mov bx,packed
and bx,0038h
mov cl,03h
ror bx,cl
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
mov bx,packed
and bx,0007h
mov al,bl
call dis
mov dl,al
mov ah,02h
int 21h
lea dx,space
mov ah,09h
int 21h 

mov ah,4ch 
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