 r←test_WSFULL dummy;myapl;res;ret
⍝ test that DBuild and DTest behave as expected when dealing with a WS FULL in a test/build
⍝ We test this by launching another interpreter to run the test
⍝ and we then examine the log-file.
⍝ Requires Windows & Version 16+
⍝ Windows is needed because as of May 2021 we don't get a returncode from APLProcess on the other platforms.
 r←''
 :If ##._isWin
 :AndIf 15<##.DyaVersion  ⍝ APLProcess was introduced with v16
     logfile←##.TESTSOURCE,'testWSFULL'

     ret←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DTest ',##.TESTSOURCE,'test_wsfull1.dyalog -off',(##.verbose/' -verbose'),' -testlog=',logfile,'"  CITA_Log="',logfile,'"')
     :If 21 Check ret
         →0 Because'Failing test did not end with code 21 (returned ',(⍕ret),')' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS logfile,'.wsfull'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce log file with .wsfull extension' ⋄ :EndIf

⍝ add a test for a DBuild-Process that will crash with WS FULL

     res←##.Build ##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -quiet=2'
     :If 1 Check∨/'errors encountered.'⍷res
         →0 Because'Log of DBuild_WSFULL did not indicate errors: ',,res ⋄ :EndIf

     logfile←##.TESTSOURCE,'DBuildWSFULL'
     ret←300 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -off" CITA_Log="',logfile,'"')

     :If ##.isWin
     :AndIf 1 Check ret
         →0 Because'DBuild WSFULL did not end with returncode 1 (indicating errors during process).' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'DBuild_WSFULL.log'  ⍝ was a log-file written?
         →0 Because'Failing build not produce log-file.' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'testWSFULL.wsfull'
     1 ⎕NDELETE ##.TESTSOURCE,'DBuild_WSFULL.log'
     1 ⎕NDELETE ##.TESTSOURCE,'DBuild_WSFULL.err'
 :EndIf
