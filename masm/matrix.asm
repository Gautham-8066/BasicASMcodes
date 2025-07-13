data segment
wd1 db 9 dup(00h)
wd2 db 9 dup(00h)
ansx db 9 dup(00h)
convt db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
space db 0dh,0ah,24h
spc db 20h,24h
ans db 9 dup(00h)
msg1 db "Enter matrix1:$"
msg2 db "Enter matrix2:$"
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

;read matrix1
lea bx,wd1
lea dx,msg1
mov ah,09h
int 21h

mov cx,09h
read1:
mov ah,01h
int 21h
sub al,30h
mov [bx],al
inc bx
loop read1

lea dx,space
mov ah,09h
int 21h

lea dx,msg2
mov ah,09h
int 21h

;read matrix2
lea bx,wd2
mov cx,09h
read2:
mov ah,01h
int 21h
sub al,30h
mov [bx],al
inc bx
loop read2

lea dx,space
mov ah,09h
int 21h

;adding
lea si,wd1
lea di,wd2
lea bx,ans
mov cx,09h
adding:
mov al,[si]
mov dh,[di]
add al,dh
daa
mov dl,al
mov [bx],dl
inc si
inc di
inc bx
loop adding

;matrix printing
lea di,ans
mov cx,03h
matrix:
mov dl,[di]
add dl,30h
mov ah,02h
int 21h
lea dx,spc
mov ah,09h
int 21h
inc di
loop matrix

lea dx,space
mov ah,09h
int 21h

mov cx,03h
matrix1:
mov dl,[di]
add dl,30h
mov ah,02h
int 21h
lea dx,spc
mov ah,09h
int 21h
inc di
loop matrix1

lea dx,space
mov ah,09h
int 21h

mov cx,03h
matrix2:
mov dl,[di]
add dl,30h
mov ah,02h
int 21h
lea dx,spc
mov ah,09h
int 21h
inc di
loop matrix2
;end 

;modulo
mov dl,00h
mov bl,00h
lea si,ans
lea di,ansx
mov cx,9
pazham:
mov al,[si]
rcr al,1
rcl dl,1
mov bl,dl
mov dl,00h
push cx
mov cx,7
module:
rcr al,1
rcl dl,1
xor bl,dl
mov dl,00h
loop module
pop cx
mov [di],bl
inc si
inc di
loop pazham

lea dx,space
mov ah,09h
int 21h

lea si,ansx
mov cx,9
andi:mov al,[si]
call disp
mov dl,al
mov ah,02h
int 21h
inc si
loop andi

mov ah,4ch
int 21h
  
disp proc
push bx
lea bx,convt
xlatb
pop bx 
ret
disp endp

code ends
end start