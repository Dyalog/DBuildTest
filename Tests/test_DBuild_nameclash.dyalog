 r←test_DBuild_nameclash dummy;l;args
 r←''
 :If 17.1≤##.DyaVersion  ⍝ this test requires v17.1 or better

     res←##.Build args←##.TESTSOURCE,'DBuild_nameclash.dyalogbuild -c -q=2'

 :If 1 Check∨/'4 errors encountered.'⍷∊res
     →0 Because'DBuild did not fail with 4 errors (3 nameclashes + final msg) while executing...',(⎕UCS 13),']DBuild ',args ⋄ :EndIf

 :EndIf
