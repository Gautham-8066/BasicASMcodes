data segment
    msg1 db 'gautham$', 0    
    msg2 db 'Number of occurrences of first character: $'
    msg3 db 0dh, 0ah, '$'    
data ends

print macro msg
    lea dx, msg              
    mov ah, 09h              
    int 21h
endm

code segment
assume cs:code, ds:data
start:
    mov ax, data             ; Set up DS to point to data segment
    mov ds, ax

    ; Print the input string and message
    print msg1
    print msg3
    print msg2

    ; Initialize counter (DH = 0)
    mov dh, 0

    ; Set up SI to point to the start of msg1
    lea si, msg1
    mov al, [si]             ; Load the first character into AL
    inc si                   ; Move SI to the next character
    mov dl, al               ; Save the first character in DL for comparison

count_loop:
    mov al, [si]             ; Load the current character
    cmp al, '$'              ; Check for end of string
    je display_count
    cmp al, dl               ; Compare current character with the first one
    jne skip_increment
    inc dh                   ; Increment counter if match
skip_increment:
    inc si                   ; Move SI to the next character
    jmp count_loop

display_count:
    ; Add 1 to DH because the first character should be counted as well
    inc dh

    ; Convert counter in DH to ASCII and print it
    add dh, '0'              ; Convert to ASCII
    mov dl, dh               ; DL = ASCII value of the count
    mov ah, 02h              ; DOS function to print a single character
    int 21h

    ; Terminate program
    mov ah, 4Ch              ; DOS terminate program
    int 21h
code ends
end start
