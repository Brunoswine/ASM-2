name "word-reverse"

org 100h

jmp start

string1 db 255 dup('$')
instr db "enter string:",0Dh,0Ah,'$'

start: mov dx,offset instr ; ����������
mov ah,09h
int 21h

mov bx,offset string1 ; ���� ������
mov [bx],255
mov dx, bx
mov ah,0Ah
int 21h ; ���������� ��� ����������� �����
add bl, string1[1]
add bx, 2

mov [bx],'$' ; �������� ������ ����� ������

xor dx,dx
xor ax,ax

lea bx, string1 ; ���������� ������ ������ (���������� ������ string)
add bx, 2 ; adress+2

mov si, bx
mov di, bx
dec si

next_byte: inc si ; ������ �� ������
mov al,[si]
cmp al,' '
je found_the_end ; ���� ������ - ������, �� �������
mov al, [si]
cmp al,'$'
je found_the_end
jmp next_byte

found_the_end: mov dx,si ; ���� ������ ������ ��� $
dec si ; si�
mov bx, di

do_reverse: cmp bx, si ; ������ �����
jae done

mov al, [bx]
mov ah, [si]

mov [si], al
mov [bx], ah


inc bx
dec si
jmp do_reverse

done: mov si,dx ; ���������
inc dx
mov bx,dx
mov di,bx
mov al,[si]

mov ah,[si]
cmp ah,'$'
jne next_byte

mov dx,offset string1
add dx,2
mov ah, 09h ; ����� �� �����
int 21h

ret