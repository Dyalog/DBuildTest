 r←test_ReturnCode dummy;myapl
⍝ test if DBuild ends with correct return-code!
⍝ We test this by launching another interpreter
⍝ and testing its returncode. Unfortunately atm (July 2020)
⍝ this is only possible on Windows (APLProcess.GetExitCode only usable on Win)
 r←''
 :If ##._isWin

     ⎕SE.SALT.Load'aplprocess -target=#'

     myapl←⎕NEW #.APLProcess('dfns'('LX="{2 ⎕nq ⎕se ''KeyPress'' ⍵}¨'']dtest ',##.TESTSOURCE,'test_failure.dyalog -off'',⊂''ER''"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If 21 Check myapl.GetExitCode
         →0 Because'Failing test did not end with code 21' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'test_failure.log'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce log-file' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'test_failure.log'  ⍝ wipe out that expected log-file
     1 ⎕NDELETE ##.TESTSOURCE,'test_ok.log'  ⍝ make sure next test doesn't have a log file before it starts

     myapl←⎕NEW #.APLProcess('dfns'('LX="{2 ⎕nq ⎕se ''KeyPress'' ⍵}¨'']dtest ',##.TESTSOURCE,'test_ok.dyalog -off'',⊂''ER''"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If 20 Check myapl.GetExitCode
         →0 Because'Succeeding test did not end with code 20' ⋄ :EndIf
     :If 0 Check ⎕NEXISTS ##.TESTSOURCE,'test_ok.log'  ⍝ was a log-file written?
         →0 Because'Succeeding test produced log-file' ⋄ :EndIf

 :EndIf
