 r←test_DBuild_4 dummy;l;suff
 r←''
 ⍝ Attempt to run Builds with save=1 to ensure that this functionality also works.
 ⍝ Other functionality wrt data has been addressed in earlier tests.
 logfile←##.TESTSOURCE,'DBuild4.log'
 1 ⎕NDELETE'/tmp/DBuild_TEST_4.dws'
 1 ⎕NDELETE'/tmp/DBuild_TEST_4.exe'

 suff←''
 :If 9=##.⎕NC'CoCo'   ⍝ if CodeCoverage has been enabled, ensure we're adding this run to the log by passing along the filename...
     suff←'-coco=',##.CoCo.filename
 :EndIf
 sink←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_4.dyalogbuild -save=1 -p  -off=0 ',suff,'"  CITA_Log="',logfile,'" CITAnqOFF=1')

 :If ~⎕NEXISTS'/tmp/DBuild_TEST_4.dws'
     →0 Because'DBuild_4.dyalogbuild did not create /tmp/DBuild_TEST_4.dws'
 :EndIf

 :If ##.isWin
     :If ~⎕NEXISTS'/tmp/DBuild_TEST_4.exe'
         →0 Because'DBuild_4.dyalogbuild did not create /tmp/DBuild_TEST_4.exe'
     :EndIf
 :EndIf
 1 ⎕NDELETE logfile
 1(⎕NDELETE ⎕OPT'Wildcard' 1)logfile,'.*'
 1 ⎕NDELETE'/tmp/DBuild_TEST_4.dws'
 1 ⎕NDELETE'/tmp/DBuild_TEST_4.exe'
