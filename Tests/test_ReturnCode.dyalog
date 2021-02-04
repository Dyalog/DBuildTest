 r←test_ReturnCode dummy;myapl;rc
⍝ test if DBuild ends with correct return-code!
⍝ We test this by launching another interpreter
⍝ and testing its returncode. Unfortunately atm (July 2020)
⍝ this is only possible on Windows (APLProcess.GetExitCode only usable on Win)
 r←''
 :If ##._isWin

     ⎕SE.SALT.Load'aplprocess -target=#'

     ⍝myapl←⎕NEW #.APLProcess(''('ok=1 load=exec keypress="'']dtest ',##.TESTSOURCE,'test_retcode.dyalog'',⊂''ER''"'))
     myapl←⎕NEW #.APLProcess(''('ok=0 LX="{2 ⎕nq ⎕se ''KeyPress'' ⍵}¨'']dtest ',##.TESTSOURCE,'test_retcode.dyalog -off',(##.halt/' -halt'),(##.verbose/' -verbose'),''',⊂''ER''"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If 21 Check rc←myapl.GetExitCode
         →0 Because'Failing test did not end with code 21 (returned ',(⍕rc),')' ⋄ :EndIf

     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'test_retcode.log'  ⍝ was a log-file written?
         →0 Because'Failing test did not produce log-file' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.log'  ⍝ wipe out that expected log-file

     myapl←⎕NEW #.APLProcess(''('ok=1 LX="{2 ⎕nq ⎕se ''KeyPress'' ⍵}¨'']dtest ',##.TESTSOURCE,'test_retcode.dyalog -off',(##.halt/' -halt'),(##.verbose/' -verbose'),''',⊂''ER''"'))
     :While ~myapl.HasExited ⋄ :EndWhile ⍝ let it run...
     :If 20 Check rc←myapl.GetExitCode
         →0 Because'Succeeding test did not end with code 20 (returned ',(⍕cr),')' ⋄ :EndIf
     :If 0 Check ⎕NEXISTS ##.TESTSOURCE,'test_ok.log'  ⍝ was a log-file written?
         →0 Because'Succeeding test produced log-file' ⋄ :EndIf

 :EndIf
