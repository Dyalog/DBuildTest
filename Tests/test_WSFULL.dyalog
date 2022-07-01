 r←test_WSFULL dummy;myapl;res;ret;f
⍝ test that DBuild and DTest behave as expected when dealing with a WS FULL in a test/build
⍝ We test this by launching another interpreter to run the test
⍝ and we then examine the log-file.
⍝ Requires Windows & Version 18+
⍝ Windows is needed because as of May 2021 we don't get a returncode from APLProcess on the other platforms.
 ⎕SE.SALT.Load ##.TESTSOURCE,'sub_RunAPLProcess.aplf'
 r←''
 logfile←##.TESTSOURCE,'testWSFULL'

 ret←300 sub_RunAPLProcess(##.TESTSOURCE,'Executor')('RunUCMD="DTest ',##.TESTSOURCE,'test_wsfull1.dyalog -loglvl=32 -off',(##.verbose/' -verbose'),' -testlog=',logfile,'" CITA_Log="',logfile,'"')
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
     →0 Because∊(⊂'Log of DBuild_WSFULL did not indicate errors:'),##.NL,,(⊂'  > ')∘,¨res,¨⊂##.NL ⋄ :EndIf

 logfile←##.TESTSOURCE,'DBuildWSFULL'
 ret←300 sub_RunAPLProcess(##.TESTSOURCE,'Executor')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -q" CITA_Log="',logfile,'" CITAnqOFF=1')

 :If 1 Check ⎕NEXISTS f←logfile,'.RunUCMD.log'  ⍝ was a log-file written?
     →0 Because'Failing build not produce log-file "',f,'"' ⋄ :EndIf

 t←1⊃⎕NGET f
 :If 1 Check 0<≢('big.←'⎕S'&')t
     →0 Because'Log-file "',f,'" does not seem to contain error msgs related to ← assignment of "big" variables' ⋄ :EndIf

 1(⎕NDELETE ⎕OPT'Wildcard' 1)logfile,'.*'  ⍝ can do because LogFile has no "_", so we won't delete production files
 1 ⎕NDELETE ##.TESTSOURCE,'testWSFULL.log'
 1 ⎕NDELETE ##.TESTSOURCE,'DBuildWSFULL.RunUCMD.log'
 1 ⎕NDELETE ##.TESTSOURCE,'testWSFULL.log.json'
 1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'
