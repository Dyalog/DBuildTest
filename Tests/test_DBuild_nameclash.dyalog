 r←test_DBuild_nameclash dummy;res;args
 r←''
 res←##.Build args←##.TESTSOURCE,'DBuild_nameclash.dyalogbuild -c -q=2'

 :If 1 Check∨/'4 errors encountered.'⍷∊res
     →0 Because'DBuild did not fail with 4 errors while executing...',(⎕UCS 13),']DBuild ',args ⋄ :EndIf
