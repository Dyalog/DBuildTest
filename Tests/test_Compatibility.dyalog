 r←test_Compatibility sink
 r←''

 ⎕SE.SALT.Load(∊1 ⎕NPARTS ##.TESTSOURCE,'../Tests/CompCheck/*.aplf'),' -target=#'  ⍝ load CompCheck utility

 :If 1 Check(18 #.Run ##.TESTSOURCE,'../DyalogBuild.dyalog')   ⍝ what could go wrong?
     →0 Because'Test for compatibility with v18.0 failed' ⋄ :EndIf

 :If 1 Check(1.1 #.Run ##.TESTSOURCE,'../DyalogBuild.dyalog')
     →0 Because'Test for compatibility with Classic failed' ⋄ :EndIf
