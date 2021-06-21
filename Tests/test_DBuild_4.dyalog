 r←test_DBuild_4 dummy;ucmd_flags;l
 r←''
 :If 17.1≤##.DyaVersion  ⍝ this test requires v17.1 or better
 ⍝ we attempt to run Builds with save=1 to ensure that this functionality also works.

     ucmd_flags←(##.halt/' -h'),##.quiet/' -q'

     ##.Build ##.TESTSOURCE,'DBuild_4.dyalogbuild -save=1 -p -c',ucmd_flags

     :If ~##.qNEXISTS'/tmp/DBuild_Test_4.dws'
         →0 Because'DBuild 4.dyalogbuild did not create /tmp/DBuild_Test_4.dws'
     :EndIf

     :If ##.isWin
         :If ~##.qNEXISTS'/tmp/DBuild_TEST_4.exe'
             →0 Because'DBuild 4.dyalogbuild did not create /tmp/DBuild_Test_4.exe'
         :EndIf
     :EndIf
 :EndIf
