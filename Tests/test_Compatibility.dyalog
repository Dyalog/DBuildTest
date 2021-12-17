 r←test_Compatibility
⍝ needs the repository https://github.com/mbaas2/CompCheck in a sibling-foder to this repo
 r←''

 ⎕SE.SALT.Load(∊1 ⎕NPARTS ##.TESTSOURCE,'../Tests/CompCheck/*.aplf'),' -target=#'

 :If 1 Check (12.1 #.Run ##.TESTSOURCE,'../DyalogBuild.dyalog')
     →0 Because'Test for compatibility with v12 failed' ⋄ :EndIf

 :If 1 Check (1 #.Run ##.TESTSOURCE,'../DyalogBuild.dyalog')
     →0 Because'Test for compatibility with Classic failed' ⋄ :EndIf
