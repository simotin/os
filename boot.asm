[org 0]
[bits 16]
  jmp 0x07C0:start

start:
  mov ax, cs  ; 0x07C0 を axにコピー
  mov ds, ax  ; ds を cs と同じに

  ; ビデオメモリのセグメントをesレジスタに設定
  ; 先頭部分から
  mov ax, 0xB800
  mov es, ax
  mov di, 0

  ; 画面全体に背景文字を出力
  mov ax, word [msgBack]
  mov cx, 0x07FF

paint:
  mov word [es:di], ax
  add di, 2
  dec cx
  jnz paint

  mov edi, 0

  mov byte [es:edi], 'b'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 'o'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 'o'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 't'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 'i'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 'n'
  inc edi
  mov byte [es:edi], 0x07

  inc edi
  mov byte [es:edi], 'g'
  inc edi
  mov byte [es:edi], 0x07

read:
  mov ax, 0x1000    ; ES:BX=1000:0000
  mov es, ax
  mov bx, 0         ;
  mov ah, 2         ; Read sector from Drive
  mov al, 1         ; read 1 esector
  mov ch, 0         ; cylinder  :0
  mov cl, 2         ; sector    :2
  mov dh, 0         ; head 0
  mov dl, 0x80      ; HDDドライブから読み込み
  int 0x13          ; read

  ; エラー時は再度リード
  jc  read

  ; 成功時は読み出し先へジャンプ
  jmp 0x1000:0000

msgBack db  ' ', 0x00

times 510-($-$$)  db 0
  dw  0xAA55
