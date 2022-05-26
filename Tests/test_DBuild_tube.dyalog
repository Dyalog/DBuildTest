 r←test_DBuild_tube sink;diff;compare;xp;bd
⍝ tests DBuild by building the tube ws and comparing it to the shipped version
 r←''
 rc←(0.001×⌊/⍬)sub_RunAPLProcess(('')('LX="⎕se.UCMD''DBuild /git/dyalog-tube-ws/dyalog-tube-ws.dyalogbuild -quiet -prod -save=1 ',(##.verbose/' -verbose'),''' ⋄ {+2 ⎕NQ''⎕se'' ''keypress''⍵}¨('')OFF'',⊂''ER'') "'))

 'Depth'⎕CY'dfns'
 'xp'⎕NS''  ⍝ what we expect to see
 xp.⎕CY'tube'  ⍝ is the original version that is shipped with the product

 'bd'⎕NS''
 bd.⎕CY'/git/dyalog-tube-ws/tube' ⍝ compare to the ws that was just build

 compare←{
     0=≢⍵:''
     n1←(1⊃⍺).⎕NC ⍵
     n1=9:(⊂⍺⍎¨⊂⍵)∇¨↓(1⊃⍺).(⍎⍵).⎕NL 2 3 9
     n1=3:(≢/¯3↓¨⍺.⎕nR⊂⍵)/'⎕VR of functions does not match'   ⍝ remove the last 3 lines of NR to get rid of SALT Info...
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
