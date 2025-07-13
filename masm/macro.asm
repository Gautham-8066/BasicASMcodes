data segment
msg1 db "Gautham$"
msg2 db 0ah,0dh,24h
msg3 db "1234$"
data ends
code segment
assume cs:code,ds:data
print macro msg 
lea dx,msg
mov ah,09h
int 21h
endm
start:
mov ax,data
mov ds,ax

mov cx,04h
again:print msg1
      print msg2
      print msg3
      print msg2
      loop again

mov ah,4ch
int 21h
code ends
end start
