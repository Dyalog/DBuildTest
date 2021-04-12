 r←test_ReturnCode dummy;myapl;rc
⍝ test if DBuild ends with correct return-code!
⍝ We test this by launching another interpreter
⍝ and testing its returncode. Unfortunately atm (July 2020)
⍝ this is only possible on Windows (APLProcess.GetExitCode only usable on Win)
⍝ needs the RunCITA-Workspace (which is used to kick off ]DTest - best way to do this across all platforms/editions... )
 r←''
 :If ##._isWin
 :AndIf 15<1⊃##._Version  ⍝ APLProcess was introduced with v16
     ⎕SE.SALT.Load'aplprocess -target=#'

     myapl←⎕NEW #.APLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',##.TESTSOURCE,'test_retcode.dyalog mode=DTest ok=0 dtestmods="-off',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If (⊂'GetExitCode')∊myapl.⎕NL-3
         :If 21 Check rc←myapl.GetExitCode
             →0 Because'Failing test did not end with code 21 (returned ',(⍕rc),')' ⋄ :EndIf
     :EndIf
     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'test_retcode.log'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce log-file' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.log'  ⍝ wipe out that expected log-file

     myapl←⎕NEW #.APLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',##.TESTSOURCE,'test_retcode.dyalog mode=DTest ok=1 dtestmods="-off',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If (⊂'GetExitCode')∊myapl.⎕NL ¯3
         :If 20 Check rc←myapl.GetExitCode
             →0 Because'Succeeding test did not end with code 20 (returned ',(⍕cr),')' ⋄ :EndIf
     :EndIf
     :If 0 Check ⎕NEXISTS ##.TESTSOURCE,'test_ok.log'  ⍝ was a log-file written?
         →0 Because'Succeeding test produced log-file' ⋄ :EndIf

 :EndIf
