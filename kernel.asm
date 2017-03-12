[org 0]
[bits 16]

start:
  mov ax, cs
  mov ds, ax
  xor ax, ax            ; axに1を設定
  mov ss, ax

  lea   esi, [msgkernel]  ; 文字列があるところのアドレスにesiを代入
  mov   ax, 0xB800
  mov   es, ax
  mov   edi, 0
  call  printf
  jmp   $

printf:
  push  eax             ; eax値をスタックに保存

printf_loop:
  mov al, byte [esi]      ; esiがさしているアドレスから文字を１つ持ってくる
  mov byte [es:edi], al   ; 文字を画面に表示する
  or  al, al              ; alは0か？
  jz  printf_end          ; 0であればprintf_endにジャンプ
  inc edi                 ; 0でなければediを1つ増やす
  mov byte [es:edi], 0x07 ; 文字の色と背景色の値を入れる。
  inc esi                 ; 次の文字を取り出すためにesiを1つ増やす
  inc edi                 ; 画面に次の文字を表示するためにediを増やす
  jmp printf_loop

printf_end:
  pop eax
  ret                     ; 呼び出し元に戻る

msgkernel db  "Kernel loaded...", 0

; cat 512byteないと正常にReadできない
times 512-($-$$)  db 0
