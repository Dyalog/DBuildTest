 r←test_Compatibility
⍝ needs the repository https://github.com/mbaas2/CompCheck in a sibling-foder to this repo

 ⎕SE.Link.Import #(∊1 ⎕NPARTS ##.TESTSOURCE,'../CompCheck')

 :If 1 Check 12 #.Run ##.TESTSOURCE,'DyalogBuild.dyalog'
     →0 Because'Test for compatibility with v12 failed' ⋄ :EndIf

 :If 1 Check 1 #.Run ##.TESTSOURCE,'DyalogBuild.dyalog'
     →0 Because'Test for compatibility with Classic failed' ⋄ :EndIf
