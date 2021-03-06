; 【Oneshot】 
;  -> Space
; 【Combination】 
; -> Shift

; SandSに求められること
; 1. 単体動作
; 2. ctrl(変換)との併用
; 3. 無変換キーとの併用
; 4. Ctrl Space，Alt Spceなどとの併用
; 5. 特に方向キー
; 6. キーコンビネーションのときの動作

;  SandSはCtrlと同時押しするため，ctrlup_ime.ahkとの兼ね合いを意識する必要があるか
; 現状は大丈夫そう
; Ctrl は~で定義されているため，常に押されていれば動く

#InstallKeybdHook
#UseHook
SpacePressedStartTime = 0
*Space::
  ; 以前はSendだったが、Sendだと`+キー`が発火しなかったので、 Sendに
  ; 2021-05-13 文字入力時に変換モードをオフにする
  conv_mode := IME_GetConverting()
  if (conv_mode == 2){
    Send, {Space}
    return
  }
  Send,  {LShift Down}
  if (SpacePressedStartTime = 0 ){
    SpacePressedStartTime := A_TickCount
}
Return

*Space Up:: 
  ;ToolTip, %A_PriorKey% 
  SendInput {LShift Up}
  KeyPressedUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-KeyPressedStartTime
  ; tooltip, %PressedTime%
  ;SpaceをPriorKeyで入力判定，Alt SpaceやCtrl Spaceの実装を考えたとき，Spaceは修飾キーより後に入力されるため，これで問題ない 
  ; tooltip, %A_PriorKey%
  If (KeyPressedUpTime - SpacePressedStartTime < 200 and A_PriorKey = "Space")
  {
    SendInput {Blind}{Space}
  }
  SpacePressedStartTime = 0
Return

