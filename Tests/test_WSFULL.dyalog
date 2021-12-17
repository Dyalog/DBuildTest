 r←test_WSFULL dummy;myapl;res;ret;f
⍝ test that DBuild and DTest behave as expected when dealing with a WS FULL in a test/build
⍝ We test this by launching another interpreter to run the test
⍝ and we then examine the log-file.
⍝ Requires Windows & Version 16+
⍝ Windows is needed because as of May 2021 we don't get a returncode from APLProcess on the other platforms.
 r←''
 :If 17≤##.DyaVersion  ⍝ needs APLProcess and ⎕JSON
     logfile←##.TESTSOURCE,'testWSFULL'

     ret←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DTest ',##.TESTSOURCE,'test_wsfull1.dyalog -loglvl=32 -off',(##.verbose/' -verbose'),' -testlog=',logfile,'" CITA_Log="',logfile,'"')
     :If ##._isWin
         :If 22 Check ret
             →0 Because'Failing test did not end with code 22 (returned ',(⍕ret),')' ⋄ :EndIf
     :EndIf

     :If 1 Check ⎕NEXISTS f←logfile,'.log.json'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce JSON file with .log.json extension' ⋄ :EndIf

     :If ⎕NEXISTS f
     :AndIf 22 Check(⎕JSON 1⊃⎕NGET f).rc
         →0 Because'Logfile "',f,'" did not contain rc=22 for test with WS FULL' ⋄ :EndIf



⍝ add a test for a DBuild-Process that will crash with WS FULL

     res←##.Build ##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -quiet=2'
     :If 1 Check∨/'WS FULL'⍷∊res
         →0 Because∊(⊂'Log of DBuild_WSFULL did not indicate errors:'),##.NL,'  > '∘,¨res,¨⊂##.NL ⋄ :EndIf

     logfile←##.TESTSOURCE,'DBuildWSFULL'
     ret←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -off" CITA_Log="',logfile,'"')

     :If ##.isWin
     :AndIf 1 Check ret
         →0 Because'DBuild WSFULL did not end with returncode 1 (indicating errors during process).' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'DBuild_WSFULL.log'  ⍝ was a log-file written?
         →0 Because'Failing build not produce log-file.' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'testWSFULL.log'
     1 ⎕NDELETE ##.TESTSOURCE,'testWSFULL.log.json'
     1 ⎕NDELETE ##.TESTSOURCE,'DBuild_WSFULL.log'
     1 ⎕NDELETE ##.TESTSOURCE,'DBuild_WSFULL.err'
 :EndIf
