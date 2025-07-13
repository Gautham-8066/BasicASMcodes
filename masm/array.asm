data segment
	nums db 01,02,03,04,05,06
	arsize dw 0007h
	table db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
data ends

code segment
assume cs:code,ds:data
start:	mov ax,data
	mov ds,ax
	lea bx,nums
	mov cx,arsize
	mov dh,00h
sum:add dh,[bx]
    mov al,dh
    DAA
	inc bx
	loop sum
	
	mov dl, dh
	and dl,0f0h
	mov cl,04h
	ror dl,cl
	call asciic
	mov ah,02
	int 21h
	mov dl,dh
	and dl,0fh
	call asciic
	mov ah,02h
	int 21h
	mov ah,4ch
	int 21h	

	asciic proc
	push bx
	lea bx, table
	mov al,dl
	xlatb
	mov dl,al
	pop bx
	ret
	asciic endp
code ends
end start
