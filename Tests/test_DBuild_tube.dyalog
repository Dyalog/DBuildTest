 r←test_DBuild_tube sink;diff;compare;xp;bd;cnt;dir;t;rc;cfgFile
⍝ tests DBuild by building the tube ws and comparing it to the shipped version
 r←''
 ⎕TRAP←0 'S'
 
 
 rc←(0.001×⌊/⍬)sub_RunAPLProcess(##.TESTSOURCE,'lx.dws')('RunUCMD="DBuild /git/dyalog-tube-ws/dyalog-tube-ws.dyalogbuild -quiet -prod -off -save=1" CITA_LOG=tube.log')

 ⍝ 'Depth'⎕CY'dfns' ⍝ is missing in 190c32. This (updated) version taken from https://github.com/abrudz/primitives/blob/main/depth.aplo
 Depth←{ ⍝ ⍥
     0::⎕SIGNAL⊂⎕DMX.(('EN'EN)('EM'EM)('Message'(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺,⊂'')/'") ("',⊃⍬⍴2⌽⍺}Message)))
     ncs←⎕NC↑'⍺' '⍵⍵'
     0 3≡ncs:⍺⍺ ⍵⍵ ⍵       ⍝   f⍥g Y
     2 3≡ncs:⍺ ⍺⍺⍥⍵⍵ ⍵     ⍝ X f⍥g Y

     1<≢⍴⍵⍵:⎕SIGNAL 4      ⍝ non-vec/scal: RANK
     1≠1 4⍸≢⍵⍵:⎕SIGNAL 5   ⍝ not 1...3 elements: LENGTH
     (c←⎕NS ⍬).⎕CT←1E¯14   ⍝ tolerant space
     c.≢∘⌊⍨⍵⍵:⎕SIGNAL 11   ⍝ not ints: DOMAIN

     0∊⎕NC'⍺':0⊢∘⍺⍺∇∇⍵⍵⊢⍵  ⍝ monadic: placeholder left arg

     ⍺←{⍵ ⋄ ⍺⍺}            ⍝ monadic: pass-thorugh
     k←⌽3⍴⌽⍵⍵              ⍝ r → r r r    q r → r q r    p q r → p q r
     n←k c.<0
     d←|≡¨3⍴⍵ ⍺ ⍵ ⍵
     (n/k)+←n/d
     k⌊←d

     b←1↓k<d
     b∧←0≠1↓d  ⍝ bottomed out
     r←⍵⍵<0
     ww←r+⍵⍵
     ww+←(⌈/d)×r∧0=ww
     S←⍺⍺ ∇∇ ww
     c.⍱/b:⍺ ⍺⍺ ⍵
     c.</b:⍺∘S¨⍵
     c.>/b:S∘⍵¨⍺
     c.∧/b:⍺ S¨⍵
 }

 'xp'⎕NS''     ⍝ what we expect to see
 xp.⎕CY'tube'  ⍝ is the original version that is shipped with the product

 'bd'⎕NS''
 bd.⎕CY'/git/dyalog-tube-ws/tube' ⍝ compare to the ws that was just build

 compare←{
     0=≢⍵:''
     n1←(1⊃⍺).⎕NC ⍵
     n1=9:(⊂⍺⍎¨⊂⍵)∇¨↓(1⊃⍺).(⍎⍵).⎕NL 2 3 9
     n1=3:(≢/¯3↓¨⍺.⎕NR⊂⍵)/'⎕VR of functions does not match'   ⍝ remove the last 3 lines of NR to get rid of SALT Info...
     0::'Error comparing ',(1⊃⍺).⍵,': ',⎕JSON ⎕DMX
     (n1>0)∧n1≠(2⊃⍺).⎕NC ⍵:'nameclass of ',(⍕1⊃⍺),'.',⍵,' did not match with obj in new ws (nc=',(⍕(2⊃⍺).⎕NC ⍵),')'
     (⍴(1⊃⍺)⍎⍵)≢⍴(2⊃⍺)⍎⍵:'shape of ',(⍕1⊃⍺),'.',⍵,' did not match with obj in new ws'
     ((1⊃⍺)⍎⍵)≢(2⊃⍺)⍎⍵:'content of ',(⍕1⊃⍺),'.',⍵,' did not match with obj in new ws'
     ''
 }

 diff←2 3 9{
     (⊂⍵)compare¨↓(1⊃⍵).⎕NL ⍺
 }¨⊂xp bd

 :If 0<≢' '~⍨∊diff
     r←∊({0<≢⍵:⍵,⎕UCS 13 ⋄ ''}Depth 1)diff
 :EndIf