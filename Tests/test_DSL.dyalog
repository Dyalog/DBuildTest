 r←test_DSL dummy;v1;halt∆
 ⍝ some vary basic tests to make sure that the DSL works as expected
 r←''

 :If ⎕SE.SALTUtils.OS Check∊##.(_isMacOS,_isWin,_isLinux)/'Mac' 'Win' 'Lin'
     →0 Because'Flags for OS did not match SALT''s opinion' ⋄ :EndIf

 v1←⍳3
 v1+←1
 :If 2 3 4 Check v1
     →0 Because'1+⍳3 was found to not match 2 3 4!!!' ⋄ :EndIf

 :If ~32767 Check 32767 Because'updating variable R'
     :If 0=≢r ⋄ r←'fn "Because" did not update global "r"' ⋄ →0 ⋄ :EndIf
     r←''
 :Else
     ∘∘∘∘
     r←'fn "Because" did not return its ⍺' ⋄ →0
 :EndIf

 :If 3 IsNotElement v1
     →0 Because'"IsNotElement" reported incorrect result' ⋄ :EndIf


 halt∆←##.halt ⋄ ##.halt←0  ⍝ disable halt because the following is expected to fail!
 :If ~0 IsNotElement v1
     :If ##.halt←halt∆ ⍝ reset it
         (⎕LC[1]+1)⎕STOP 1⊃⎕SI ⋄ ⎕←'Interrupting in an usual way because IsNotElement failed in a surprising way!'
     :EndIf
     →0 Because'"IsNotElement" reported incorrect result' ⋄ :EndIf
 ##.halt←halt∆ ⍝ reset it
