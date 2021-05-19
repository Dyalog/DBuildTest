 r←test_WSFULL dummy;myapl;rc
⍝ test that DBuild and DTest behave as expected when dealing with a WS FULL in a test/build
⍝ We test this by launching another interpreter to run the test
⍝ and we then examine the log-file.
⍝ Requires Windows & Version 16+
⍝ Windows is needed because as of May 2021 we don't get a returncode from APLProcess on the other platforms.
 r←''
 :If ##._isWin  
 :AndIf 15<##.DyaVersion  ⍝ APLProcess was introduced with v16
     logfile←##.TESTSOURCE,'test_WSFULL'

    ret←300 sub_RunAPLProcess ((##.TESTSOURCE,'RunCITA')('CITATest=',##.TESTSOURCE,'test_wsfull1.dyalog testlog="',logfile,'"  CITA_Log="',##.TESTSOURCE,'DBuild_WSFULL" mode=DTest dtestmods="',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
         :If 21 Check ret
             →0 Because'Failing test did not end with code 21 (returned ',(⍕ret),')' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS logfile,'.wsfull'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce log file with .wsfull extension' ⋄ :EndIf

⍝ add a test for a DBuild-Process that will crash with WS FULL

       r←##.Build ##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild'
       :if 1 Check ∨/'errors encountered.'⍷r
       →0 Because 'Log of WSFULL DBuild did not indicate errors'⋄:endif

     ret←300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_WSFULL.dyalogbuild -off" CITA_Log="',##.TESTSOURCE,'DBuild_WSFULL"')
         :If 21 Check ret
             →0 Because'Failing build  did not end with code 21 (returned ',(⍕ret),')' ⋄ :EndIf

logfile←##.TESTSOURCE,'DBuild_WSFULL'
     :If 1 Check ⎕NEXISTS logfile,'.log'  ⍝ was a log-file written?
         →0 Because'Failing test build not produce log-file' ⋄ :EndIf


1 ⎕ndelete 'test_WSFULL.wsfull'
 1⎕ndelete 'DBuild_WSFULL.log'
 :EndIf
