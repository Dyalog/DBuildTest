 r←test_DBuild_4 dummy;l;suff
 r←''
 :If 17.1≤##.DyaVersion  ⍝ this test requires v17.1 or better
 ⍝ we attempt to run Builds with save=1 to ensure that this functionality also works.
     logfile←##.TESTSOURCE,'DBuild4.log'
     1 ⎕NDELETE'/tmp/DBuild_TEST_4.dws'
     1 ⎕NDELETE'/tmp/DBuild_TEST_4.exe'

     suff←''
     :If 9=##.⎕NC'CoCo'   ⍝ if CodeCoverage has been enabled, ensure we're adding this run to the log by passing along the filename...
         suff←'-coco=',##.CoCo.filename
     :EndIf
     ret←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_4.dyalogbuild -save=1 -p -q -off ',suff,(##.halt/' -halt'),'"  CITA_Log="',logfile,'"')

     ⍝sink←##.Build ##.TESTSOURCE,'DBuild_4.dyalogbuild -save=1 -p -c -q=2'

     :If ~##.qNEXISTS'/tmp/DBuild_TEST_4.dws'
         →0 Because'DBuild_4.dyalogbuild did not create /tmp/DBuild_TEST_4.dws'
     :EndIf

     :If ##.isWin
         :If ~##.qNEXISTS'/tmp/DBuild_TEST_4.exe'
             →0 Because'DBuild_4.dyalogbuild did not create /tmp/DBuild_TEST_4.exe'
         :EndIf
     :EndIf
     1 ⎕NDELETE logfile
     1 ⎕NDELETE'/tmp/DBuild_TEST_4.dws'
     1 ⎕NDELETE'/tmp/DBuild_TEST_4.exe'

 :EndIf
