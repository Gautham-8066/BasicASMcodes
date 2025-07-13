data segment
 input db 08h dup(00h)
 packed db 00h
 table db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
 upper db 00h
 lower db 00h
 common db 00h
 msg1 db 0dh,0ah,24h
 msg2 db "Enter 8 bits:$"
 msg3 db "Modulo 2 sum :$"
 msg4 db "Entered byte:$"
 data ends
 code segment
 assume cs:code,ds:data
 start:mov ax,data
 mov ds,ax
 lea dx,msg2
 mov ah,09h
 int 21h
 lea bx,input
 mov cx,08h
 read :mov ah,01h
 int 21h
 sub al,30h
 mov[bx],al
 inc bx
 loop read
 CALL nextline
 lea dx,msg3
 mov ah,09h
 int 21h
 lea bx,input
 mov cx,08h
 mov al,00h
 sum :xor al,[bx]
 inc bx
 loop sum
 add al,30h
 mov dl,al
 mov ah,02h
 int 21h
 lea bx,input
 mov cx,08h
 mov dl,00h
 packing:mov al,[bx]
     rcr al,1
 rcl dl,1
 inc bx

loop packing
 mov packed,dl
 call nextline
 lea dx,msg4
 mov ah,09h
 int 21h
 mov dl,packed
 mov common,dl
 call display
 call nextline
 mov al,upper
 mov dl,lower
 cmp al,09h
 JLE small
 JMP grey
 small:cmp dl,09h
 JLE excess
 excess:mov dl,packed
 add dl,33h
 mov common,dl
 call display
 jmp exit
 grey:mov dl,packed
 mov bl,dl
 shr dl,1
 xor dl,bl
 mov common,dl
 call display
 exit:mov ah,4ch
 int 21h
 display proc
 mov al,common
 and al,0f0h
 mov cl,04h
 ror al,cl
 mov dl,al
 mov upper,dl
 push bx
 lea bx,table
 mov al,dl
 xlatb
 mov dl,al
 mov ah,02h
 int 21h
 mov dl,common
 and dl,0fh
 mov lower ,dl
 lea bx,table

mov al,dl
 xlatb
 mov dl,al
 mov ah,02h
 int 21h
 pop bx
 ret
 display endp
 nextline proc
 lea dx,msg1
 mov ah,09h
 int 21h
 ret
 nextline endp                                                                                                          
code ends
end start