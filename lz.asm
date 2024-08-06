.model small
.stack 100h

.data
nameArr db 15 dup(0)
player db "Enter player name: ", '$'
game db "BRICK BREAKER GAME", '$'

pause_ db "Game pause, press enter to resume.", ' '
rem db 0
quo db 0

s1 dw 14
s2 dw 10

menu db "Welcome to Game Menu", ' '
option_ db "Choose your desired option: ", ' '
line1 db "Start Game", ' '
line2 db "Highest Score", ' '
line3 db "How To Play", ' '
line4 db "Exit Game", ' '
line5 db "Designed by:", ' '
line6 db "Zainab & Laraib", ' '

exitl1 db 'X GAME EXIT X',' '
exitl2 db 'You have exited the game',' '
exitl3 db 'THANKS FOR PLAYING',' '

instl1 db 'HOW TO PLAY?',' '
instl2 db '* Use arrow keys to move paddle.',' '
instl3 db '* Eliminate BRICKS, hitting with BALL.',' '
instl4 db '* If ball hits enclosure game ends.',' '
instl5 db '* Elimiate all bricks to win.',' '
instl6 db 'Red Brick --- 20 points',' '
instl7 db 'Pink Brick --- 15 points',' '
instl8 db 'Orange Brick --- 10 points',' '
instl9 db 'Blue Brick --- 5  points',' '


var dw 1
score1 db 'HIGHSCORE TABLE',' '


x_ db 6
y_ db 8

gamename db "BRICKS VS THE BALL", 0
gname db "A Game by Laraib & Zainab", 0
fname db "player.txt"
;player db "Enter name: ",'$'

pname db 10 DUP(' ')
PNAME_LEN DB 0
fhandle dw ?

enterpressm db "Press Enter to move forward", '$'
a dw 25
_s2_ dw 0
stx dw 0

;------------------ level 1
__var__ db "level 1", '$'
__var__2 db "level 2", '$'
__var____ db "Level 3", '$'
score dw 0
lives db 3
count db 0
x dw 100
y dw 180

ball_x dw 150       ; starting coordinates of x- axis 
ball_y dw 150       ; starting coordinates of y axis 
ball_size dw 4h     ; size of the ball 
ball_xspeed dw 02h  ; ball velocity in x axis 
ball_yspeed dw 02h  ; ball velocity in y axis 

h dw 155    
h_ dw 02h
time_aux db 0       ; previous time is stored 

width_ dw 316      ; window's width 
height dw 196      ; window's height 
WINDOW_BOUNDS DW 6 

PADDLE_X DW 150                    ;current X position of the left paddle
PADDLE_Y DW 180                     ;current Y position of the left paddle
PADDLE_WIDTH DW 50                  ;default paddle width
PADDLE_HEIGHT DW 10                 ;default paddle height
PADDLE_VELOCITY DW 0FH               ;default paddle velocity
WINDOW_HEIGHT DW 0C8h                ;the height of the window (200 pixels)

brick_x dw 0
brick_y dw 0
brick_height dw 19
brick_width dw 49

heart_x dw 0
heart_y dw 1
heart_size dw 15

one_ dw 0
two_ dw 0
three_ dw 0
four_ dw 0
five_ dw 0
six_ dw 0
seven_ dw 0
eight_ dw 0
nine_ dw 0
ten_ dw 0
eleven_ dw 0
twelve_ dw 0
thirteen_ dw 0
fourteen_ dw 0
fifteen_ dw 0
sixteen_ dw 0
seventeen_ dw 0
eighteen_ dw 0
nineteen_ dw 0
twenty_ dw 0
twentyone_ dw 0
twentytwo_ dw 0

one_complete db "YOU HAVE PASSED LEVEL ONE ", 0
two_complete db "YOU HAVE PASSED LEVEL TWO ", 0
three_complete db "YOU HAVE PASSED LEVEL THREE", 0
game_over db "GAME OVER (press backspace for menu)",0
cong db "CONGRAGULATIONS ", 0
pressm db "Press enter to start level two..", 0
pressm1 db "Press enter to start level three..", 0
pressm2 db "Press enter to go to main menu :) ", 0

out_ dw 0
lev_2 dw 0
lev_3 dw 0

name_ db "highscore.txt", 0
handle dw ?
buffer db 10 dup(0), '$' ;reads all the data we read from file
enter_ db "Enter again",'$'

.code
jmp main

;                       FUNCTION OF STARTING SCREEN

startscreen proc
;call scorebox

    mov bx, 0                   ; starting code of pink square 

 l1:             ; for lines 
    mov ah, 0Ch
    mov al, 5h
    mov cx, 30        ; x axis 
    mov dx, a         ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,150
    je hi
    jne l1
hi:
    mov bx, 0
    mov a, 25

 l11:             ; for lines 
    mov ah, 0Ch
    mov al, 5h
    mov cx, 270        ; x axis 
    mov dx, a         ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,150
    je hi1
    jne l11
hi1:

     mov bx, 0
    mov a, 30

 l12:             ; for lines 
    mov ah, 0Ch
    mov al, 5h
    mov cx, a        ; x axis 
    mov dx, 25        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,240
    je hi2
    jne l12
hi2:

    mov bx, 0
    mov a, 30

 l13:             ; for lines 
    mov ah, 0Ch
    mov al, 5h
    mov cx, a        ; x axis 
    mov dx, 175       ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,240
    je hi3
    jne l13
hi3:

;                           ending code of pink square



;;                                              for game name
mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 001011b
mov cx, lengthof gamename
mov dh, 4
mov dl, 10
mov es,si
mov bp, offset gamename
int 10h
;                                               laraib and zainab

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 001011b
mov cx, lengthof gname
mov dh, 20   ; y axis 
mov dl, 6   ; x axis 
mov es,si
mov bp, offset gname
int 10h


;                                                 for player name
mov ah, 3ch		
mov cl, 0		
mov dx, offset fname    ;FILE NAME
INT 21H

MOV fhandle,AX
MOV AH,02H
MOV BH,0
MOV DH,9	 
MOV DL,13	 
INT 10H
;PLAYER KI ARRAY MEIN NAME INPUT
MOV DX, offset player		
MOV AH,09H
INT 21H
MOV AH,02H
MOV BH,0		
MOV DH,12	 
MOV DL,13	
INT 10H	
MOV SI, OFFSET pname

;move name in array till space occurs
.REPEAT
INC PNAME_LEN
MOV AH,01
INT 21H
MOV AH,0
MOV [SI],AL
inc SI
.UNTIL AL== 13;EOL


mov byte ptr [SI], 36		
MOV AH,3DH 		
MOV CL,2		
INT 21H
MOV CX, LENGTHOF PNAME
MOV BX,fhandle	
MOV DX,OFFSET pname
MOV AH,40H
INT 21H		
mov ah, 3eh

;                                             for "please enter to move next"

; ;FILE HANDLING
open:
mov ah, 3dh
mov al,  2
lea dx, name_
int 21h
mov handle, ax



write:
mov cx, 0
mov dx, 0
mov bx, handle
mov ah, 42h
mov al, 2 
int 21h

mov bx, handle
mov cx, lengthof pname
lea dx, pname
mov ah, 40h
int 21h


mov ah, 3eh
mov bx, handle
int 21h

mov ah, 3dh
mov al,  2
lea dx, name_
int 21h
mov handle, ax

close:
mov ah, 3eh
mov bx, handle
int 21h
mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 001111b
mov cx, lengthof enterpressm
mov dh, 20;;col
mov dl, 6
mov es,si
mov bp, offset enterpressm
int 10h

presskro1:
mov al, 0
mov ah, 00
int 16h
mov ah, 02
cmp al, 13
je bahir1
jmp presskro1
bahir1:
call menu_
ret
startscreen endp

;==============================CLEAR SCREEN ==============
clrscreen proc
mov bp,sp
mov ah, 0
int 16h
mov ah, 03
int 10h
mov ah, 13
mov ah, 00h
mov al, 13h
int 10h
ret
clrscreen endp


;------------------------------level 1

level1 proc
   
    call background
    call playersname
    call heart
    call levelone
    call score_   
    call brick 
    
check_time:
    mov ah, 2ch     ; get system time
    int 21h

    cmp dl, time_aux
    je check_time
    
    mov time_aux, dl
    
    call clear_ball
    call moveball
    call draw_ball
    
    
    call clear_paddle
    call move_paddle
    call draw_paddle
    
    call score_
    
    .if (lives==0)
        mov out_, 1
        jmp byebye
    .endif
    
    .if (one_==1 && two_==1 && three_==1 && four_ ==1 && five_ ==1 && six_ ==1 && seven_ ==1 && eight_ ==1  && nine_ ==1 && ten_ ==1 && eleven_ ==1 && twelve_ ==1 && thirteen_ ==1 && fourteen_ ==1 && fifteen_ ==1 && sixteen_ ==1 && seventeen_ ==1 && eighteen_ ==1 && nineteen_ ==1 && twenty_ ==1 && twentyone_ ==1 && twentytwo_ ==1)
    jmp byebye
    .endif
    
jmp check_time

byebye:
ret 
level1 endp



;------------------------------level 2

level2 proc
   
    call background
    call playersname
    call heart
    call leveltwo
    call score_   
    call brick 
    
    mov ball_xspeed, 04h  ; ball velocity in x axis         ; increasing the speed of the ball
    mov ball_yspeed, 04h  ; ball velocity in y axis 
    mov PADDLE_WIDTH, 35                                  ; shortening the paddle 
    
checktime:
    mov ah, 2ch     ; get system time
    int 21h

    cmp dl, time_aux
    je checktime
    
    mov time_aux, dl
    
    call clear_ball
    call moveball
    call draw_ball
    
    
    call clear_paddle
    call move_paddle
    call draw_paddle
    
    call score_
    
    .if (lives==0)
        mov out_, 1
        jmp byebye_
    .endif
    
    .if (one_==2 && two_==2 && three_==2 && four_ ==2 && five_ ==2 && six_ ==2 && seven_ ==2 && eight_ ==2  && nine_ ==2 && ten_ ==2 && eleven_ ==2 && twelve_ ==2 && thirteen_ ==2 && fourteen_ ==2 && fifteen_ ==2 && sixteen_ ==2 && seventeen_ ==2 && eighteen_ ==2 && nineteen_ ==2 && twenty_ ==2 && twentyone_ ==2 && twentytwo_ ==2)
    jmp byebye_
    .endif
    
jmp checktime

byebye_:
ret 
level2 endp

level3 proc


    call background
    call playersname
    call heart
    call levelthree
    call score_   
    call brick 
    
; ;if the user enters backspace, it goes back to main menu 


     mov ball_xspeed, 05h  ; ball velocity in x axis         ; increasing the speed of the ball
    mov ball_yspeed, 05h  ; ball velocity in y axis 
   mov PADDLE_WIDTH, 25                                    ; shortening the paddle 
    
checktime:
    mov ah, 2ch     ; get system time
    int 21h

    cmp dl, time_aux
    je checktime
    
    mov time_aux, dl
    
    call clear_ball
    call moveball
    call draw_ball
    
	
    
    call clear_paddle
    call move_paddle
    call draw_paddle
    
    call score_
    
    .if (lives==0)
        mov out_, 1
        jmp byebye___
    .endif
    
    .if (two_==3 && three_==2 && four_ ==3 && five_ ==3 && six_ ==3 && seven_ ==3 && eight_ ==3  && nine_ ==3 && ten_ ==3 && eleven_ ==3 && twelve_ ==3 && thirteen_ ==3 && fourteen_ ==3 && fifteen_ ==3 && sixteen_ ==3 && seventeen_ ==3 && eighteen_ ==3 && nineteen_ ==3 && twenty_ ==3 && twentyone_ ==3 && twentytwo_ ==3)
    jmp byebye___
    .endif
    
jmp checktime



byebye___:
ret 
level3 endp

pauseScreen ProC
  mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 9h     ;   color
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof pause_
    mov dh, 8   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset pause_
    int 10h

 mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,13
je zainab_end

zainab_end:
ret
pauseScreen endp

clear_heart proc

    mov cx, heart_x   ; x axis 
    mov dx, heart_y   ; y axis 
    
    horizontal0:
    mov ah, 0ch
    mov al, 5h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx           ; inc x axis
    mov ax, cx
    sub ax, heart_x
    cmp ax, heart_size
    jng horizontal0  ; if size not equal then go back to horizontal
    
    mov cx, heart_x
    inc dx
    mov ax, dx
    sub ax, heart_y
    cmp ax, heart_size
    jng horizontal0
    
ret
clear_heart endp



draw_ball proc

    mov cx, ball_x   ; x axis 
    mov dx, ball_y   ; y axis 
    
    horizontal:
    mov ah, 0ch
    mov al, 00h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         ; inc x axis
    mov ax, cx
    sub ax, ball_x
    cmp ax, ball_size
    jng horizontal  ; if size not equal then go back to horizontal
    
    mov cx, ball_x
    inc dx
    mov ax, dx
    sub ax, ball_y
    cmp ax, ball_size
    jng horizontal

ret
draw_ball endp


clear_ball proc

    mov cx, ball_x   ; x axis 
    mov dx, ball_y   ; y axis 
    
 horizontal_:
    mov ah, 0ch
    mov al, 52h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         ; inc x axis
    mov ax, cx
    sub ax, ball_x
    cmp ax, ball_size
    jng horizontal_  ; if size not equal then go back to horizontal
    
    mov cx, ball_x
    inc dx
    mov ax, dx
    sub ax, ball_y
    cmp ax, ball_size
    jng horizontal_

ret
clear_ball endp


clear_brick proc

;.if(
    mov cx, brick_x   ; x axis 
    mov dx, brick_y   ; y axis 
    
 horizontal1:
    mov ah, 0ch
    mov al, 52h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         ; inc x axis
    mov ax, cx
    sub ax, brick_x
    cmp ax, brick_width
    jng horizontal1  ; if size not equal then go back to horizontal
    
    mov cx, brick_x
    inc dx
    mov ax, dx
    sub ax, brick_y
    cmp ax, brick_height
    jng horizontal1

ret
clear_brick endp



color_brick proc

    mov cx, brick_x   ; x axis 
    mov dx, brick_y   ; y axis 
    
 horizontal1:
    mov ah, 0ch
    mov al, 1h      ; color
    mov bh, 00h  
    int 10h
        
    inc cx         ; inc x axis
    mov ax, cx
    sub ax, brick_x
    cmp ax, brick_width
    jng horizontal1  ; if size not equal then go back to horizontal
    
    mov cx, brick_x
    inc dx
    mov ax, dx
    sub ax, brick_y
    cmp ax, brick_height
    jng horizontal1

ret
color_brick endp




clear_paddle proc
		MOV CX,PADDLE_X 			 ;set the initial column (X)
		MOV DX,PADDLE_Y 			 ;set the initial line (Y)
		
		DRAW_HORIZONTAL:
			MOV AH,0Ch 					 ;set the configuration to writing a pixel
			MOV AL,52h 					 ;choose white as color
			MOV BH,00h 					 ;set the page number 
			INT 10h    					 ;execute the configuration
			
			INC CX     				 	 ;CX = CX + 1
			MOV AX,CX         			 ;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y -> We go to the next line, N -> We continue to the next column
			SUB AX,PADDLE_X
			CMP AX,PADDLE_WIDTH
			JNG DRAW_HORIZONTAL
			
			MOV CX,PADDLE_X 		    ;the CX register goes back to the initial column
			INC DX       				 ;we advance one line
			
			MOV AX,DX            	     ;DX - PADDLE_LEFT_Y > PADDLE_HEIGHT (Y -> we exit this procedure,N -> we continue to the next line
			SUB AX,PADDLE_Y
			CMP AX,PADDLE_HEIGHT
			JNG DRAW_HORIZONTAL
		RET
clear_paddle ENDP


draw_paddle PROC 
		
		MOV CX,PADDLE_X 			 ;set the initial column (X)
		MOV DX,PADDLE_Y 			 ;set the initial line (Y)
		
		DRAW_PADDLE_LEFT_HORIZONTAL:
			MOV AH,0Ch 					 ;set the configuration to writing a pixel
			MOV AL,0h 					 ;choose white as color
			MOV BH,00h 					 ;set the page number 
			INT 10h    					 ;execute the configuration
			
			INC CX     				 	 ;CX = CX + 1
			MOV AX,CX         			 ;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y -> We go to the next line, N -> We continue to the next column
			SUB AX,PADDLE_X
			CMP AX,PADDLE_WIDTH
			JNG DRAW_PADDLE_LEFT_HORIZONTAL
			
			MOV CX,PADDLE_X 		    ;the CX register goes back to the initial column
			INC DX       				 ;we advance one line
			
			MOV AX,DX            	     ;DX - PADDLE_LEFT_Y > PADDLE_HEIGHT (Y -> we exit this procedure,N -> we continue to the next line
			SUB AX,PADDLE_Y
			CMP AX,PADDLE_HEIGHT
			JNG DRAW_PADDLE_LEFT_HORIZONTAL
		RET
draw_paddle ENDP


move_paddle PROC                ;process movement of the paddles
		
;      paddle movement
		
		                                        ;check if any key is being pressed 
		MOV AH,01h
		INT 16h
		JZ bye                                  ;ZF = 1, JZ -> Jump If Zero
		
		                                        ;check which key is being pressed (AL = ASCII character)
		MOV AH,00h
		INT 16h
		
		                                         ;if it is left arrow key, move left
		CMP AH,4Bh                              ;LEFT
		JE move_left

		
		                                         ;if it is right arrow key, move right  
		CMP AH,4Dh                              ; right 
		JE move_right
		JMP bye
		
		
move_left:
			MOV AX,PADDLE_VELOCITY
			SUB PADDLE_X,AX
			
			cmp PADDLE_X, 3
			jl fix
			JMP  bye
			
fix:
    mov PADDLE_X, 3
    jmp bye
    
		
			
move_right:
			MOV AX,PADDLE_VELOCITY
			ADD PADDLE_X,AX
			
			.if (lev_2==0)
			cmp PADDLE_X, 270
			JG fix_
				JMP bye
			.else 
			    cmp PADDLE_X, 290
			JG fix_
				JMP bye
			
			.endif
fix_:
mov PADDLE_X, 265
jmp bye
		
		
bye:	
			RET
		
move_paddle ENDP




moveball proc

    mov ax, ball_xspeed   ; moving the ball horizontally 
    add ball_x , ax 
    
    cmp ball_x, 00h       ; checking with the left boundary
    jl neg_x
    
    mov ax, width_          ; checking with the right boundary
    cmp ball_x, ax
    jg neg_x
    
    
    mov ax, ball_yspeed    ; moving the ball vertically
    add ball_y , ax
    
    cmp ball_y, 28
    jl neg_y
    
    mov ax, height
    cmp ball_y, ax
    jg neg_y
    
    mov ax, h_
    add h, ax
    
    
    ; check if the ball is colliding with the paddle
    ; ball_y +ball_size < paddle_y
    mov ax, ball_y
    add ax, ball_size
    cmp ax, PADDLE_Y
    jng a_
    
    ; ball_X < PADDLE_x+PADDLE_width
    mov ax, PADDLE_X
    add ax, PADDLE_WIDTH
    cmp ball_x, ax
    jg a_
    
    ; ball_x + ball_size > paddle_x
    mov ax, ball_x
    add ax,ball_size
    cmp ax, PADDLE_X
    jng a_
      
    
    neg ball_yspeed 
    
    a_:
    .if(lev_2==2)
        call collision_l3
    .elseif(lev_2==1)
        call collision_l2
	.else
		call collisions
    .endif
    
     mov ax, ball_y
     add ax, ball_size
    .if (ax>197 )
        call beep
        dec lives
        neg ball_yspeed
    .endif    
    
    .if (lives==2)
    mov heart_x, 35
    mov heart_y, 8
    call clear_heart
    .endif
    
    .if (lives==1)
    mov heart_x, 20
    mov heart_y, 8
    call clear_heart
    .endif
    
    .if (lives==0)
    mov heart_x, 5
    mov heart_y, 8
    call clear_heart
	call gameOver
    .endif
    
ret
    neg_x:
    neg ball_xspeed
    ret
    
    neg_y:
    neg ball_yspeed
    neg h_
    ret
    
moveball endp


collisions proc
    .if (one_ == 0)    ;-----> blue 
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>93 && cx<113)
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 93
             call clear_brick
             add score, 5
              mov one_, 1
              call beep
        .endif
    .endif
    
     .if (two_ == 0)            ;-----> orange
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>93 && cx<113)
             neg ball_yspeed
             mov brick_x, 56
             mov brick_y, 93
             call clear_brick
             add score, 10
              mov two_, 1
              call beep
        .endif
    .endif
    
    .if (three_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( ax > 107 && ax < 157 && dx> 93  && cx<113)
             neg ball_yspeed
             mov brick_x, 107
             mov brick_y, 93
             call clear_brick
             add score , 15
              mov three_, 1
              call beep
        .endif
    .endif
    
     .if (four_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>93 && cx<113)
             neg ball_yspeed
             mov brick_x, 158
             mov brick_y, 93
             call clear_brick
             add score, 5
              mov four_, 1
              call beep
        .endif
    .endif
    
    .if (five_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>93 && cx<113)
             neg ball_yspeed
             mov brick_x, 209
             mov brick_y, 93
             call clear_brick
             add score, 10
             mov five_, 1
             call beep
        .endif
        
    .endif
    
     .if (six_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>93 && cx<113)
             neg ball_yspeed
             mov brick_x, 260
             mov brick_y, 93
             call clear_brick
             add score, 15
              mov six_, 1
              call beep
        .endif
    .endif
    
     .if (seven_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>72 && cx<92)
             neg ball_yspeed
             mov brick_x, 30
             mov brick_y, 72
             call clear_brick
             add score, 15
              mov seven_, 1
              call beep
        .endif
    .endif
    
    .if (eight_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>72 && cx<92)
             neg ball_yspeed
             mov brick_x, 81
             mov brick_y, 72
             call clear_brick
             add score, 5
              mov eight_, 1
              call beep
        .endif
    .endif
    
    .if (nine_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>72 && cx<92)
             neg ball_yspeed
             mov brick_x, 132
             mov brick_y, 72
             call clear_brick
             add score, 10
              mov nine_, 1
              call beep
        .endif
    .endif
    
    .if (ten_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>72 && cx<92)
             neg ball_yspeed
             mov brick_x, 183
             mov brick_y, 72
             call clear_brick
             add score, 15
              mov ten_, 1
              call beep
        .endif
    .endif
    
    .if (eleven_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>72 && cx<92)
             neg ball_yspeed
             mov brick_x, 234
             mov brick_y, 72
             call clear_brick
             add score, 5
              mov eleven_, 1
              call beep
        .endif
    .endif
    
    .if (twelve_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 51
             call clear_brick
             add score, 10
              mov twelve_, 1
              call beep
        .endif
    .endif
    
    .if (thirteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 56
             mov brick_y, 51
             call clear_brick
             add score, 5
              mov thirteen_, 1
              call beep
        .endif
    .endif
    
    .if (fourteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 107 && ax < 157 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 107
             mov brick_y, 51
             call clear_brick
             add score, 15
              mov fourteen_, 1
              call beep
        .endif
    .endif
    
    .if (fifteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 158
             mov brick_y, 51
             call clear_brick
             add score, 5
              mov fifteen_, 1
              call beep
        .endif
    .endif
    
    .if (sixteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 209
             mov brick_y, 51
             call clear_brick
             add score, 10
              mov sixteen_, 1
              call beep
        .endif
    .endif
    
    .if (seventeen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>51 && cx<71)
             neg ball_yspeed
             mov brick_x, 260
             mov brick_y, 51
             call clear_brick
             add score, 15
              mov seventeen_, 1
              call beep
        .endif
    .endif
    
    .if (eighteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>30 && cx<50)
             neg ball_yspeed
             mov brick_x, 30
             mov brick_y, 30
             call clear_brick
             add score, 20
              mov eighteen_, 1
              call beep
        .endif
    .endif
    
    .if (nineteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>30 && cx<50)
             neg ball_yspeed
             mov brick_x, 81
             mov brick_y, 30
             call clear_brick
             add score, 10
              mov nineteen_, 1
              call beep
        .endif
    .endif
    
    .if (twenty_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>30 && cx<50)
             neg ball_yspeed
             mov brick_x, 132
             mov brick_y, 30
             call clear_brick
             add score, 15
              mov twenty_, 1
              call beep
        .endif
    .endif
    
    
    .if (twentyone_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>30 && cx<50)
             neg ball_yspeed
             mov brick_x, 183
             mov brick_y, 30
             call clear_brick
             add score, 5
              mov twentyone_, 1
              call beep
        .endif
    .endif
    
    .if (twentytwo_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>30 && cx<50)
             neg ball_yspeed
             mov brick_x, 234
             mov brick_y, 30
             call clear_brick
             add score, 10
              mov twentytwo_, 1
              call beep
        .endif
    .endif
    
ret
collisions endp

collision_l2 proc
    .if (one_ != 2)    ;-----> blue 
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>93 && cx<116 )
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 93
             inc one_
             .if(one_==2)
                call clear_brick
                 add score, 5
             .else
                call color_brick
            .endif
              call beep
        .endif
    .endif
    
     .if (two_!=2)            ;-----> orange
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>93 && cx<116)
             neg ball_yspeed
             inc two_
             mov brick_x, 56
             mov brick_y, 93
             .if(two_==2)
                call clear_brick
                add score, 10
            .else
                call color_brick
            .endif
              call beep
        .endif
    .endif
    
    .if (three_ !=2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 107 && ax < 157 && dx> 93  && cx<116)
             neg ball_yspeed
             inc three_
             mov brick_x, 107
             mov brick_y, 93
             .if(three_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
     .if (four_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>93 && cx<116)
             neg ball_yspeed
             inc four_
             mov brick_x, 158
             mov brick_y, 93
              .if(four_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (five_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>93 && cx<116)
             neg ball_yspeed
             inc five_
             mov brick_x, 209
             mov brick_y, 93
             .if(five_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
        
    .endif
    
     .if (six_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>93 && cx<116)
             neg ball_yspeed
             inc six_
             mov brick_x, 260
             mov brick_y, 93
             .if(six_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
     .if (seven_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>72 && cx<95)
             neg ball_yspeed
             inc seven_
             mov brick_x, 30
             mov brick_y, 72
             .if(seven_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eight_!= 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>72 && cx<95)
             neg ball_yspeed
             inc eight_
             mov brick_x, 81
             mov brick_y, 72
             .if(eight_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (nine_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>72 && cx<95)
             neg ball_yspeed
             inc nine_
             mov brick_x, 132
             mov brick_y, 72
             .if(nine_==2)
                call clear_brick
                add score, 10
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (ten_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>72 && cx<95)
             neg ball_yspeed
             inc ten_
             mov brick_x, 183
             mov brick_y, 72
             .if(ten_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eleven_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>72 && cx<95)
            inc eleven_
             neg ball_yspeed
             mov brick_x, 234
             mov brick_y, 72
             .if(eleven_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twelve_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>51 && cx<74)
            inc twelve_
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 51
             .if(twelve_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (thirteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>51 && cx<74)
             neg ball_yspeed
             inc thirteen_
             mov brick_x, 56
             mov brick_y, 51
             .if(thirteen_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (fourteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 107 && ax < 157 && dx>51 && cx<74)
             neg ball_yspeed
             inc fourteen_
             mov brick_x, 107
             mov brick_y, 51
             .if(fourteen_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (fifteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>51 && cx<74)
             neg ball_yspeed
             inc fifteen_
             mov brick_x, 158
             mov brick_y, 51
             .if(fifteen_==2)
                call clear_brick
                add score, 10
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (sixteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>51 && cx<74)
             neg ball_yspeed
             inc sixteen_
             mov brick_x, 209
             mov brick_y, 51
             .if(sixteen_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (seventeen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>51 && cx<74)
             neg ball_yspeed
             inc seventeen_
             mov brick_x, 260
             mov brick_y, 51
             .if(seventeen_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eighteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>30 && cx<53)
             neg ball_yspeed
             inc eighteen_
             mov brick_x, 30
             mov brick_y, 30
             .if(eighteen_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (nineteen_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>30 && cx<53)
             neg ball_yspeed
             inc nineteen_
             mov brick_x, 81
             mov brick_y, 30
             .if(nineteen_==2)
                call clear_brick
                add score, 15
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twenty_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>30 && cx<53)
             neg ball_yspeed
             inc twenty_
             mov brick_x, 132
             mov brick_y, 30
             .if(twenty_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    
    .if (twentyone_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>30 && cx<53)
             neg ball_yspeed
             inc twentyone_
             mov brick_x, 183
             mov brick_y, 30
             .if(twentyone_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twentytwo_ != 2)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>30 && cx<53)
             neg ball_yspeed
             inc twentytwo_
             mov brick_x, 234
             mov brick_y, 30
             .if(twentytwo_==2)
                call clear_brick
                add score, 5
                call beep
            .else
                call color_brick
            .endif
        .endif
    .endif
    
ret

collision_l2 endp


collision_l3 proc

  mov bx, 0
    mov _s2_, 51
    mov stx, 56
l010:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l110:
    mov ah, 0Ch
    mov al, 0h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l210
    jne l110
    
l210:
    inc _s2_
    cmp _s2_, 71
    je s10
    jne l010
    
    s10:
      
  
    .if (one_ != 3)    ;-----> blue 
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>93 && cx<116)
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 93
             inc one_
             .if(one_==3)
                call clear_brick
                add score, 5
				 call beep
             .elseif(one_ < 3)
				call color_brick
            .endif
             call beep
        .endif
    .endif
    
     .if (two_!=3)            ;-----> orange
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>93 && cx<119)
             neg ball_yspeed
             inc two_
             mov brick_x, 56
             mov brick_y, 93
             .if(two_==3)
                call clear_brick
                add score, 10
				call beep
				
            .elseif(two_ < 3)	
                call color_brick
							;	call color_brick
            .endif
              call beep
        .endif
    .endif
    
    .if (three_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 107 && ax < 157 && dx> 93  && cx<119)
             neg ball_yspeed
             inc three_
             mov brick_x, 107
             mov brick_y, 93
             .if(three_==3)
                call clear_brick
                add score, 15
                call beep
			
            .elseif (three_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
     .if (four_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>93 && cx<119)
             neg ball_yspeed
             inc four_
             mov brick_x, 158
             mov brick_y, 93
              .if(four_==3)
                call clear_brick
                add score, 5
                call beep
			
            .elseif( four_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (five_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>93 && cx<119)
             neg ball_yspeed
             inc five_
             mov brick_x, 209
             mov brick_y, 93
             .if(five_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif(five_ < 3)
                call color_brick
            .endif
        .endif
        
    .endif
    
     .if (six_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>93 && cx<119)
             neg ball_yspeed
             inc six_
             mov brick_x, 260
             mov brick_y, 93
             .if(six_== 3)
                call clear_brick
                add score, 15
                call beep
	
            .elseif(six_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
     .if (seven_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>72 && cx<98)
             neg ball_yspeed
             inc seven_
             mov brick_x, 30
             mov brick_y, 72
             .if(seven_== 3)
                call clear_brick
                add score, 15
                call beep
			
            .elseif(seven_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eight_!= 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>72 && cx<98)
             neg ball_yspeed
             inc eight_
             mov brick_x, 81
             mov brick_y, 72
             .if(eight_== 3)
                call clear_brick
                add score, 5
                call beep
            .elseif (eight_ <3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (nine_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>72 && cx<98)
             neg ball_yspeed
             inc nine_
             mov brick_x, 132
             mov brick_y, 72
             .if(nine_==3)
                call clear_brick
                add score, 10
                call beep
				
            .elseif(nine_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (ten_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>72 && cx<98)
             neg ball_yspeed
             inc ten_
             mov brick_x, 183
             mov brick_y, 72
             .if(ten_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif(ten_ < 3 )
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eleven_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>72 && cx<98)
            inc eleven_
             neg ball_yspeed
             mov brick_x, 234
             mov brick_y, 72
             .if(eleven_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif (eleven_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twelve_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 55 && dx>51 && cx<77)
            inc twelve_
             neg ball_yspeed
             mov brick_x, 5
             mov brick_y, 51
             .if(twelve_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif(twelve_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (thirteen_ == 0)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 56 && ax < 106 && dx>51 && cx< 77)
             neg ball_yspeed
           ;  inc thirteen_
             mov brick_x, 56
             mov brick_y, 51
             ; .if(thirteen_==3)
                ; call clear_brick
                ; add score, 5
                ; call beep
				
            ; .elseif(thirteen_<3)
                ; call color_brick
            ; .endif
        .endif
    .endif
    
    .if (fourteen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 107 && ax < 157 && dx>51 && cx<77)
             neg ball_yspeed
             inc fourteen_
             mov brick_x, 107
             mov brick_y, 51
             .if(fourteen_== 3)
                call clear_brick
                add score, 15
                call beep
				
            .elseif(fourteen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (fifteen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 158 && ax < 208 && dx>51 && cx<77)
             neg ball_yspeed
             inc fifteen_
             mov brick_x, 158
             mov brick_y, 51
             .if(fifteen_==3)
                call clear_brick
                add score, 10
                call beep
				
            .elseif(fifteen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (sixteen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 209 && ax < 259 && dx>51 && cx<77)
             neg ball_yspeed
             inc sixteen_
             mov brick_x, 209
             mov brick_y, 51
             .if(sixteen_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif (sixteen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (seventeen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 260 && ax < 274 && dx>51 && cx<77)
             neg ball_yspeed
             inc seventeen_
             mov brick_x, 260
             mov brick_y, 51
             .if(seventeen_==3)
                call clear_brick
                add score, 15
                call beep
				
            .elseif(seventeen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (eighteen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 30 && ax < 80 && dx>30 && cx<56)
             neg ball_yspeed
             inc eighteen_
             mov brick_x, 30
             mov brick_y, 30
             .if(eighteen_== 3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif(eighteen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (nineteen_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 81 && ax < 131 && dx>30 && cx<56)
             neg ball_yspeed
             inc nineteen_
             mov brick_x, 81
             mov brick_y, 30
             .if(nineteen_==3)
                call clear_brick
                add score, 15
                call beep
				
            .elseif(nineteen_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twenty_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 132 && ax < 182 && dx>30 && cx<56)
             neg ball_yspeed
             inc twenty_
             mov brick_x, 132
             mov brick_y, 30
             .if(twenty_==3)
               call clear_brick
               add score, 5
                call beep
				
           .elseif(twenty_<3)
               call color_brick
            .endif
        .endif
    .endif
    
    
    .if (twentyone_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 183 && ax < 233 && dx>30 && cx<56)
             neg ball_yspeed
             inc twentyone_
             mov brick_x, 183
             mov brick_y, 30
             .if(twentyone_==3)
                call clear_brick
                add score, 5
                call beep
				
            .elseif(twentyone_<3)
                call color_brick
            .endif
        .endif
    .endif
    
    .if (twentytwo_ != 3)
        mov ax, ball_x      ; ax = ball_x
        mov bx, ax          ; bx= ball_x + ball_size
        add bx, ball_size   ; cx = ball_y
        mov cx, ball_y      ; dx = ball_y+ ball_size
        mov dx, cx
        add dx, ball_size
        .if ( bx > 234 && ax < 284 && dx>30 && cx<56)
             neg ball_yspeed
             inc twentytwo_
             mov brick_x, 234
             mov brick_y, 30
             .if(twentytwo_==3)
                call clear_brick
                add score, 5
                call beep
            .elseif(twentyone_ < 3)
                call color_brick
            .endif
        .endif
    .endif
    
ret

collision_l3 endp



beep proc
        push ax
        push bx
        push cx
        push dx
        mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, 400        ; Frequency number (in decimal)
                                ;  for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        in      al, 61h         ; Turn on note (get value from
                                ;  port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        mov     bx, 2          ; Pause for duration of note.
pause1:
        mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h         ; Turn off note (get value from
                                ;  port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.

        pop dx
        pop cx
        pop bx
        pop ax
        ret
beep endp


background proc

    mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 52h     ;   color
    int 10h
    
                    ; upper most border
    mov bx, 0
    mov a, 0
    mov _s2_, 0
    mov stx, 0
l0:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l1:
    mov ah, 0Ch
    mov al, 05h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,320
    je l2
    jne l1
    
l2:
    inc _s2_
    cmp _s2_, 25
    je s
    jne l0
s:
ret

background endp

playersname proc
    ;---------------------------------- Players name  
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,0   ; y-axis
    mov dl, 30   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    lea dx, pname        ;string output
    mov ah, 09h
    int 21h    

ret
playersname endp


heart proc
    ;--------------------------hearts/heart
    cmp lives, 1
    je one
    cmp lives, 2
    je two
    jne three
    
    
    three:
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,1   ; y-axis
    mov dl, 5   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov al, 03
    mov ah, 02h    
    mov dl,al    ;number output
    int 21h   
    
    
    two:
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,1   ; y-axis
    mov dl, 3   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov al, 03
    mov ah, 02h    
    mov dl,al    ;number output
    int 21h   
    
    one:
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,1   ; y-axis
    mov dl, 1   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov al, 03
    mov ah, 02h    
    mov dl,al    ;number output
    int 21h   

ret
heart endp

levelone proc
     ;--------------------------------- level 1 
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,2   ; y-axis
    mov dl, 30   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    lea dx, __var__        ;string output
    mov ah, 09h
    int 21h    


ret
levelone endp


leveltwo proc
     ;--------------------------------- level 2 
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,2   ; y-axis
    mov dl, 30   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    lea dx, __var__2        ;string output
    mov ah, 09h
    int 21h    


ret
leveltwo endp

levelthree proc
     ;--------------------------------- level 3
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,2   ; y-axis
    mov dl, 30   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    lea dx, __var____        ;string output
    mov ah, 09h
    int 21h    


ret
levelthree endp

saveScoreInFile proc

; ;FILE HANDLING
open:
mov ah, 3dh
mov al,  2
lea dx, name_
int 21h
mov handle, ax

mov ax, score
mov bl, 10
div bl

mov quo, al
add quo, 48

mov rem, ah
add rem, 48




write:
mov cx, 0
mov dx, 0
mov bx, handle
mov ah, 42h
mov al, 2 
int 21h


mov bx, handle
mov cx, lengthof quo
lea dx, quo
mov ah, 40h
int 21h


mov cx, 0
mov dx, 0
mov bx, handle
mov ah, 42h
mov al, 2 
int 21h


mov bx, handle
mov cx, lengthof rem
lea dx, quo
mov ah, 40h
int 21h


mov ah, 3eh
mov bx, handle
int 21h

mov ah, 3dh
mov al,  2
lea dx, name_
int 21h
mov handle, ax

close:
mov ah, 3eh
mov bx, handle
int 21h


ret
saveScoreInFile endp

score_ proc
     ;----------------------------------score
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ah,02h   ; for cursor 
    mov bx,0
    mov dh,2   ; y-axis
    mov dl, 16   ; x - axis
    int 10h
    
    mov bx, 0
    mov cx, 0
    mov ax, 0
    mov dx, 0
    
    mov ax, score
   
    call display
    

ret
score_ endp




; -----------------------------------proc to display digits 

   display   proc       ;Beginning of procedure 
   MOV BX, 10     ;Initializes divisor
   MOV DX, 0000H    ;Clears DX
   MOV CX, 0000H    ;Clears CX
    
          ;Splitting process starts here
Dloop1: 
   MOV DX, 0000H    ;Clears DX during jump
   div BX      ;Divides AX by BX
   PUSH DX     ;Pushes DX(remainder) to stack
   INC CX      ;Increments counter to track the number of digits
   CMP AX, 0     ;Checks if there is still something in AX to divide
   JNE Dloop1     ;Jumps if AX is not zero
    
Dloop2: 
   POP DX      ;Pops from stack to DX
   ADD DX, 30H     ;Converts to it's ASCII equivalent
   MOV AH, 02H     
   INT 21H      ;calls DOS to display character
   LOOP Dloop2    ;Loops till CX equals zero
   RET       ;returns control
display  ENDP


;;;////////////////////////////////////////////score box//////////////////////////////////////
scorebox proc
mov bx,0
mov si,0
mov dx, 50
sc1:                     ;
  cmp bx,100              ;;100
  je jcr
  mov cx, 100             ;;100
  mov si,0
  sc2:
   cmp si, 100
   je sc3
   mov al, 01h
   mov ah, 0ch
   int 10h
   inc si
   inc cx
   jmp sc2
sc3:
   inc bx
   inc dx
jmp sc1
jcr:
ret
scorebox endp

    ;-----------------------------------------------------bricksss
brick proc
     
    
    ;//////////////////////////First row brickss
    ; +++++++++++++++++++++++++ 1 1 brick        starting x 30     starting y 30            RED  ------> eighteen 
    ;                                             ending x  80     ending y   50
    mov bx, 0
    mov _s2_, 30
    mov stx, 30
l04:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l14:
    mov ah, 0Ch
    mov al, 4h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l24
    jne l14
    
l24:
    inc _s2_
    cmp _s2_, 50
    je s4
    jne l04
    
    s4:
    
    ; +++++++++++++++++++++++++ 1 2 brick        starting x 81     starting y 30            orange ----> nineteen 
    ;                                             ending x  131     ending y   50
    
    mov bx, 0
    mov _s2_, 30
    mov stx, 81
l05:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l15:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l25
    jne l15
    
l25:
    inc _s2_
    cmp _s2_, 50
    je s5
    jne l05
    
    s5:
    
    
    ; +++++++++++++++++++++++++ 1 3 brick        starting x 132     starting y 30           PINK-------> twenty
    ;                                             ending x  182     ending y   50
    
    mov bx, 0
    mov _s2_, 30
    mov stx, 132
l06:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l16:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l26
    jne l16
    
l26:
    inc _s2_
    cmp _s2_, 50
    je s6
    jne l06
    
    s6:
    
     ; +++++++++++++++++++++++++ 1 4 brick        starting x 183     starting y 30     blue-------->twentyone
    ;                                             ending x  233     ending y   50
    
    mov bx, 0
    mov _s2_, 30
    mov stx, 183
l07:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l17:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l27
    jne l17
    
l27:
    inc _s2_
    cmp _s2_, 50
    je s7
    jne l07
    
    s7:
    
      ; +++++++++++++++++++++++++ 1 5 brick        starting x 234     starting y 30         orange------->twentytwo
    ;                                             ending x  284     ending y   50
    
    mov bx, 0
    mov _s2_, 30
    mov stx, 234
l08:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l18:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l28
    jne l18
    
l28:
    inc _s2_
    cmp _s2_, 50
    je s8
    jne l08
    
    s8:
    
     ;//////////////////////////Second row brickss
    ; +++++++++++++++++++++++++ 2 1 brick        starting x 30     starting y 51            orange ------> twelve
    ;                                             ending x  55     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 30
l09:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l19:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,25
    je l29
    jne l19
    
l29:
    inc _s2_
    cmp _s2_, 71
    je s9
    jne l09
    
    s9:
    
    ; +++++++++++++++++++++++++ 2 2 brick        starting x 56     starting y 51            blue -------> thirteen
    ;                                             ending x  106     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 56
l010:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l110:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l210
    jne l110
    
l210:
    inc _s2_
    cmp _s2_, 71
    je s10
    jne l010
    
    s10:
    
     ; +++++++++++++++++++++++++ 2 3 brick        starting x 107     starting y 51          pink ------> fourteen 
    ;                                             ending x  157     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 107
l011:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l111:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l211
    jne l111
    
l211:
    inc _s2_
    cmp _s2_, 71
    je s11
    jne l011
    
    s11:
    
    
    ; +++++++++++++++++++++++++ 2 4 brick        starting x 158     starting y 51                  blue------> fifteen 
    ;                                             ending x  208     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 158
l012:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l112:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l212
    jne l112
    
l212:
    inc _s2_
    cmp _s2_, 71
    je s12
    jne l012
    
    s12:
    
     ; +++++++++++++++++++++++++ 2 4 brick        starting x 209     starting y 51              orange -------> sixteen 
    ;                                             ending x  259     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 209
l013:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l113:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l213
    jne l113
    
l213:
    inc _s2_
    cmp _s2_, 71
    je s13
    jne l013
    
    s13:
    
     ; +++++++++++++++++++++++++ 2 6 brick        starting x 260     starting y 51              pink  --------> seventeen 
    ;                                             ending x  274     ending y   71
    mov bx, 0
    mov _s2_, 51
    mov stx, 260
l014:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l114:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,24
    je l214
    jne l114
    
l214:
    inc _s2_
    cmp _s2_, 71
    je s14
    jne l014
    
    s14:
    
    
    ;////////////////////////////third row brickss
    ; +++++++++++++++++++++++++ 3 1 brick        starting x 30     starting y 72
    ;                                             ending x  80     ending y   92            pink -----> seven
    mov bx, 0
    mov _s2_, 72
    mov stx, 30
l015:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l115:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l215
    jne l115
    
l215:
    inc _s2_
    cmp _s2_, 92
    je s15
    jne l015
    
    s15:
    
    ; +++++++++++++++++++++++++ 3 2 brick        starting x 81     starting y 72                blue------> eight
    ;                                             ending x  131     ending y   92
    
    mov bx, 0
    mov _s2_, 72
    mov stx, 81
l016:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l116:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l216
    jne l116
    
l216:
    inc _s2_
    cmp _s2_, 92
    je s16
    jne l016
    
    s16:
    
    
    ; +++++++++++++++++++++++++ 3 3 brick        starting x 132     starting y 72               orange------>nine
    ;                                             ending x  182     ending y   92
    
    mov bx, 0
    mov _s2_, 72
    mov stx, 132
l017:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l117:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l217
    jne l117
    
l217:
    inc _s2_
    cmp _s2_, 92
    je s17
    jne l017
    
    s17:
    
     ; +++++++++++++++++++++++++ 4 4 brick        starting x 183     starting y 72              pink ------>ten
    ;                                             ending x  233     ending y   92
    
    mov bx, 0
    mov _s2_, 72
    mov stx, 183
l018:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l118:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l218
    jne l118
    
l218:
    inc _s2_
    cmp _s2_, 92
    je s18
    jne l018
    
    s18:
    
      ; +++++++++++++++++++++++++ 5 5 brick        starting x 234     starting y 72             blue------->eleven
    ;                                             ending x  284     ending y   92
    
    mov bx, 0
    mov _s2_, 72
    mov stx, 234
l019:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l119:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l219
    jne l119
    
l219:
    inc _s2_
    cmp _s2_, 92
    je s19
    jne l019
    
    s19:
    
     ;//////////////////////////forth row brickss
    ; +++++++++++++++++++++++++ 4 1 brick        starting x 30     starting y 93                blue    ----> one 
    ;                                             ending x  55     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 30
l020:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l120:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,25
    je l220
    jne l120
    
l220:
    inc _s2_
    cmp _s2_, 113
    je _s2_0
    jne l020
    
    _s2_0:
    
    ; +++++++++++++++++++++++++ 4 2 brick        starting x 56     starting y 93                orange ------> two
    ;                                             ending x  106     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 56
l021:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l121:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l221
    jne l121
    
l221:
    inc _s2_
    cmp _s2_, 113
    je _s2_1
    jne l021
    
    _s2_1:
    
     ; +++++++++++++++++++++++++ 4 3 brick        starting x 107     starting y 93              pink----three
    ;                                             ending x  157     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 107
l022:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l122:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l222
    jne l122
    
l222:
    inc _s2_
    cmp _s2_, 113
    je _s2_2
    jne l022
    
    _s2_2:
    
    
     ; +++++++++++++++++++++++++ 4 4 brick        starting x 158     starting y 93          blue ----> four
    ;                                             ending x  208     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 158
l023:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l123:
    mov ah, 0Ch
    mov al, 9h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l223
    jne l123
    
l223:
    inc _s2_
    cmp _s2_, 113
    je _s2_3
    jne l023
    
    _s2_3:
    
     ; +++++++++++++++++++++++++ 4 5 brick        starting x 209     starting y 93              orange -----> five
    ;                                             ending x  259     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 209
l024:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l124:
    mov ah, 0Ch
    mov al, 6h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,50
    je l224
    jne l124
    
l224:
    inc _s2_
    cmp _s2_, 113
    je _s2_4
    jne l024
    
    _s2_4:
    
     ; +++++++++++++++++++++++++ 4 6 brick        starting x 260     starting y 93              pink ---> six
    ;                                             ending x  274     ending y   113
    mov bx, 0
    mov _s2_, 93
    mov stx, 260
l025:
    mov bx, stx  
    mov a, bx         ; stx = a 
    mov bx, 0
    
l125:
    mov ah, 0Ch
    mov al, 8h
    mov cx, a         ; x axis 
    mov dx, _s2_        ; y axis  
    int 10h
    
    inc a
    inc bx
    cmp bx,24
    je l225
    jne l125
    
l225:
    inc _s2_
    cmp _s2_, 113
    je _s2_5
    jne l025
    
    _s2_5:
ret
brick endp


level1complete proc
    mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 9h     ;   color
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof cong
    mov dh, 8   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset cong
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof one_complete
    mov dh, 10   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset one_complete
    int 10h

    ;;                                            for "please enter to move next"
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001111b
    mov cx, lengthof pressm
    mov dh, 20;;col
    mov dl, 6
    mov es,si
    mov bp, offset pressm
    int 10h
presskro1_:
    mov al, 0
    mov ah, 00
    int 16h
    mov ah, 02
    cmp al, 13
    je bahir1_
    jmp presskro1_
bahir1_:
    call clrscreen
    ret
ret

level1complete endp


level2complete proc
    mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 9h     ;   color
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof cong
    mov dh, 8   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset cong
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof two_complete
    mov dh, 10   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset two_complete
    int 10h

    ;;                                            for "please enter to move next"
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001111b
    mov cx, lengthof pressm1
    mov dh, 20;;col
    mov dl, 6
    mov es,si
    mov bp, offset pressm1
    int 10h
presskro1__:
    mov al, 0
    mov ah, 00
    int 16h
    mov ah, 02
    cmp al, 13
    je bahir1__
    jmp presskro1__
bahir1__:
    call clrscreen
    ret
ret

level2complete endp


level3complete proc
    mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 9h     ;   color
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof cong
    mov dh, 8   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset cong
    int 10h
    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof three_complete
    mov dh, 10   ; y axis 
    mov dl, 6   ; x axis 
    mov es,si
    mov bp, offset three_complete
    int 10h

    ;;                                            for "please enter to move next"
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001111b
    mov cx, lengthof pressm2
    mov dh, 20;;col
    mov dl, 6
    mov es,si
    mov bp, offset pressm2
    int 10h
presskro1___:
    mov al, 0
    mov ah, 00
    int 16h
    mov ah, 02
    cmp al, 13
    je bahir1___
    jmp presskro1___
bahir1___:
    call menu_
    ret
ret
level3complete endp


gameOver proc
    mov ah, 06h
    mov al,0         ;  background 
    mov cx, 0
    mov dx,50000
    mov bh, 9h     ;   color
    int 10h
    
    

    
    
    mov si, @data
    mov ah, 13h
    mov al, 0
    mov bh, 0
    mov bl, 001011b
    mov cx, lengthof game_over
    mov dh, 8   ; y axis 
    mov dl, 2   ; x axis 
    mov es,si
    mov bp, offset game_over
    int 10h

;if the user enters backspace, it goes back to main menu 
mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,08h
je newLabel
    ;;                                            for "please enter to move next"
    ; mov si, @data
    ; mov ah, 13h
    ; mov al, 0
    ; mov bh, 0
    ; mov bl, 001111b
    ; mov cx, lengthof pressm2
    ; mov dh, 20;;col
    ; mov dl, 6
    ; mov es,si
    ; mov bp, offset pressm2
    ; int 10h
; presskro1___:
    ; mov al, 0
    ; mov ah, 00
    ; int 16h
    ; mov ah, 02
    ; cmp al, 13
    ; je bahir1___
    ; jmp presskro1___
; bahir1___:
    ; call clrscreen
    ; ret
ret

gameover endp
reset proc

mov one_, 0
mov two_,0 
mov three_,0 
mov four_ , 0 
mov five_ ,0 
mov six_ ,0
mov seven_, 0
mov eight_,0
mov nine_ ,0
mov ten_, 0
mov eleven_, 0
mov twelve_, 0 
mov thirteen_, 0
mov fourteen_ ,0
mov fifteen_ , 0
mov sixteen_ , 0
mov seventeen_ , 0
mov eighteen_ , 0
mov nineteen_ , 0
mov twenty_ , 0 
mov twentyone_ ,0
mov  twentytwo_ , 0
mov lives, 3
ret
reset endp




main proc
mov ax, @data
mov ds, ax

;VIDEO MODE
mov ax, 0
mov al, 13h
int 10h
call startscreen
main endp
;-------------------------MENU SCREEN---------------------------------

Menu_ ProC
;--------------------DRAWING OUTLINE SQUARE---------------------------
mov ax, 0
mov al, 13h
int 10h

	mov ah, 0ch
	mov al, 5h
	mov cx, 305	;colss
	mov dx, 10	;rowss
	int 10h 

		.while (cx != 14)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


	IBRAHIM:
		mov ah, 0ch
		mov al, 5h
		mov cx, s1
		mov dx, 190
		int 10h
		inc s1
		inc bx
		cmp bx, 293
		je exitibi
	
	jne ibrahim
exitibi:
		mov s1, 14
		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


;Vertical line
	mov bx, 0

k2:

	mov ah, 0ch  
	mov al, 5h  ;colour
	mov cx, 15  ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h		;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je end1
	jne k2

end1:
	mov s2, 10		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	
;Vertical line
k3:

	mov ah, 0ch  
	mov al, 5h 	;colour
	mov cx, 305 ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h 	;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je end2
	jne k3

end2:
	mov s2,10



;CURSOR CHANGE
mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 001011b
mov cx, lengthof menu
mov dh, 2
mov dl, 9
mov es,si
mov bp, offset menu
int 10h


mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 14
mov cx, sizeof line1
mov dh, 6
mov dl, 12
mov es,si
mov bp, offset line1
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0dh
mov cx, sizeof line2
mov dh, 8
mov dl, 11
mov es,si
mov bp, offset line2
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 56
mov cx, sizeof line3
mov dh, 10
mov dl, 11
mov es,si
mov bp, offset line3
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0ah
mov cx, sizeof line4
mov dh, 12
mov dl, 12
mov es,si
mov bp, offset line4
int 10h

 mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 9h
mov cx, sizeof line5
mov dh, 18
mov dl, 11
mov es,si
mov bp, offset line5
int 10h


mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0ch
mov cx, sizeof line6
mov dh, 20
mov dl, 10
mov es,si
mov bp, offset line6
int 10h


menu_ endp

;----------------------DISPLAY ARROW IN MENU SCREEN--------------------------
ARROW:
mov ah, 02h
mov bx, 0
mov dh, x_	;(X) ;rows 
mov dl, y_	;(Y) ;columns
int 10h

mov dl, 16
mov ah, 2h
int 21h
;--------------------------WHAN KEY IS PRESSED--------------------------
	mov AH,1
	INT 16h

	mov ah,0
	int 16h

;-------------------------------MOVE UP------------------------------------
cmp ah,48h
je moveUP

;------------------------------MOVE DOWN-----------------------------------
cmp ah,50h
je moveDOWN

;------------------------------ESC KEY--------------------------------------
mov ah, 27
je exit
;-------------------------ENTER TO GO TO RELEVANT PAGE---------------------
cmp al,13
je enterKey


	moveUP:
		cmp x_,6
		jle menu_
		sub x_,2
		jmp menu_
				
	moveDOWN:
		cmp x_,12
		jge menu_
		add x_,2
		jmp menu_


enterKey:

		cmp x_,6
		je newgame

		cmp x_,10
		je instructions

		cmp x_,8
		je highscore

		cmp x_,12
		je exitpage

;----------------------------NEW GAME DISPLAY-----------------------------
newgame:
mov ah,06h
mov al,0           
mov cx,0         
mov dx,8000         
mov bh,04h
int 10h
           
call level1 
    cmp out_, 1   ; check if the lives are finished 
    je overLabel
	mov lev_2, 1
call level1complete


call reset  
  
call level2
	cmp out_, 1   ; check if the lives are finished 
	je overLabel
	call saveScoreInFile
     mov lev_2, 2
call level2complete

call reset

call level3
	cmp out_, 1
	je overLabel
call level3complete


overLabel:
call gameover




;if the user enters backspace, it goes back to main menu 
mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,08h
je newLabel
jmp exit

;-----------------------------HIGHSCORE DISPLAY-----------------------------
highscore:

mov ax, 0
mov al, 13h
int 10h

	mov ah, 0ch
	mov al, 5h
	mov cx, 305	;colss
	mov dx, 10	;rowss
	int 10h 

		.while (cx != 14)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


	ib_high:
		mov ah, 0ch
		mov al, 5h
		mov cx, s1
		mov dx, 190
		int 10h
		inc s1
		inc bx
		cmp bx, 293
		je ex_high
	
	jne ib_high
ex_high:
		mov s1, 14
		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


;Vertical line
	mov bx, 0

h2:

	mov ah, 0ch  
	mov al, 5h  ;colour
	mov cx, 15  ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h		;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je h_end1
	jne h2

h_end1:
	mov s2, 10		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	
;Vertical line
h3:

	mov ah, 0ch  
	mov al, 5h 	;colour
	mov cx, 305 ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h 	;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je h_end2
	jne h3

h_end2:
	mov s2,10




mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0dh
mov cx, lengthof score1
mov dh, 2
mov dl, 12
mov es,si
mov bp, offset score1
int 10h

;-------------------file handling------------
open:
mov ah, 3dh
mov al,  2
lea dx, name_
int 21h
mov handle, ax

read:
mov ah, 03fh
mov bx, handle
mov cx, 50
lea dx, buffer ;buffer db 10 dup(0), '$' reads all the data we read from file.
int 21h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0eh
mov cx, lengthof buffer
mov dh, 6
mov dl, 12
mov es,si
mov bp, offset buffer
int 10h

close:
mov ah, 3eh
mov bx, handle
int 21h

;if the user enters backspace, it goes back to main menu 
mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,08h
je newLabel
jmp exit

;----------------------------INSTRUCTIONS DISPLAY-------------------------------
;background color change
instructions:

;---------------------------DRAWING OUTLINE SQUARE------------------------------	
mov ax, 0
mov al, 13h
int 10h

	mov ah, 0ch
	mov al, 5h
	mov cx, 305	;colss
	mov dx, 10	;rowss
	int 10h 

		.while (cx != 14)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


	za:
		mov ah, 0ch
		mov al, 5h
		mov cx, s1
		mov dx, 190
		int 10h
		inc s1
		inc bx
		cmp bx, 293
		je ex_za
	
	jne za
ex_za:
		mov s1, 14
		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


;Vertical line
	mov bx, 0

z2:

	mov ah, 0ch  
	mov al, 5h  ;colour
	mov cx, 15  ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h		;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je z_end1
	jne z2

z_end1:
	mov s2, 10		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	
;Vertical line
z3:

	mov ah, 0ch  
	mov al, 5h 	;colour
	mov cx, 305 ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h 	;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je z_end2
	jne z3

z_end2:
	mov s2,10
;-----------------------------------------DISPLAYING STRINGS------------------------------
mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 56
mov cx, lengthof instl1
mov dh, 2
mov dl, 12
mov es,si
mov bp, offset instl1
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 58
mov cx, lengthof instl2
mov dh, 6
mov dl, 2
mov es,si
mov bp, offset instl2
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 61
mov cx, lengthof instl3
mov dh, 8
mov dl, 2
mov es,si
mov bp, offset instl3
int 10h


mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 58
mov cx, lengthof instl4
mov dh, 10
mov dl, 2
mov es,si
mov bp, offset instl4
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 61
mov cx, lengthof instl5
mov dh, 12
mov dl, 2
mov es,si
mov bp, offset instl5
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 4h
mov cx, lengthof instl6
mov dh, 14
mov dl, 2
mov es,si
mov bp, offset instl6
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0dh
mov cx, lengthof instl7
mov dh, 16
mov dl, 2
mov es,si
mov bp, offset instl7
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 02h
mov cx, lengthof instl8
mov dh, 18
mov dl, 2
mov es,si
mov bp, offset instl8
int 10h


mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 03h
mov cx, lengthof instl9
mov dh, 20
mov dl, 2
mov es,si
mov bp, offset instl9
int 10h

;if the user enters backspace, it goes back to main menu 
mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,08h
je newLabel
jmp exit

;-------------------------------EXIT PAGE DISPLAY----------------------------------
exitpage:

;---------------------------DRAWING OUTLINE SQUARE---------------------------------
mov ax, 0
mov al, 13h
int 10h

	mov ah, 0ch
	mov al, 5h
	mov cx, 305	;colss
	mov dx, 10	;rowss
	int 10h 

		.while (cx != 14)
		dec cx
		int 10h
		.endw

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


	ib_in:
		mov ah, 0ch
		mov al, 5h
		mov cx, s1
		mov dx, 190
		int 10h
		inc s1
		inc bx
		cmp bx, 293
		je ex_ex
	
	jne ib_in
ex_ex:
		mov s1, 14
		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0


;Vertical line
	mov bx, 0

e2:

	mov ah, 0ch  
	mov al, 5h  ;colour
	mov cx, 15  ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h		;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je e_end1
	jne e2

e_end1:
	mov s2, 10		
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	
;Vertical line
e3:

	mov ah, 0ch  
	mov al, 5h 	;colour
	mov cx, 305 ;increments x axis ; cx is x-axis
	mov dx, s2  ;dx is y-axis
	int 10h 	;interrup for graphics
	inc s2
	inc bx
	cmp bx, 180 ;a simple counter which determines the length of the line
	je e_end2
	jne e3

e_end2:
	mov s2,10

;---------------------------------------DISPLAY STRINGS-------------------------------
mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0ch
mov cx, lengthof exitl1
mov dh, 2
mov dl, 12
mov es,si
mov bp, offset exitl1
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0dh
mov cx, lengthof exitl2
mov dh, 8
mov dl, 8
mov es,si
mov bp, offset exitl2
int 10h

mov si, @data
mov ah, 13h
mov al, 0
mov bh, 0
mov bl, 0dh
mov cx, lengthof exitl3
mov dh, 10
mov dl, 11
mov es,si
mov bp, offset exitl3
int 10h

;if the user enters backspace, it goes back to main menu 
mov ah,01h
int 16h
mov ah,00h
int 16h
cmp al,08h
je newLabel
jmp exit

;-----------------------------------LABEL TO CALL MENU-------------------------------

newLabel:
	call menu_

;------------------------------------PROGRAM EXIT CODE ---------------------------------
exit:
mov ah, 4ch
int 21h
;main endp
end main
