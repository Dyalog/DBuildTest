 r←test_ReturnCode dummy;myapl;rc
⍝ test if DBuild ends with correct return-code!
⍝ We test this by launching another interpreter
⍝ and testing its returncode. Unfortunately atm (July 2020)
⍝ this is only possible on Windows (APLProcess.GetExitCode only usable on Win)
⍝ needs the lx-Workspace (which is used to kick off ]DTest - best way to do this across all platforms/editions... )
⍝ that ws is borrowed from our CITA project, so its log-file is named *.CITA.log
 r←''
 :If ##._isWin
 :AndIf 18≤1⊃##._Version  ⍝ APLProcess was introduced with v16
     rc←300 sub_RunAPLProcess((##.TESTSOURCE,'lx')('CITATest=',##.TESTSOURCE,'test_retcode.dyalog mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.verbose/' -verbose'),'"'))
     :If 21 Check rc
         →cleanExit Because'Failing test did not end with code 21 (returned ',(⍕rc),')' ⋄ :EndIf
     :If 1 Check ⎕NEXISTS ##.TESTSOURCE,'test_retcode.CITA.log'  ⍝ was a log-file written?
         →cleanExit Because'Failing test did not produce log-file' ⋄ :EndIf
     :If 1 Check ⎕NEXISTS f←##.TESTSOURCE,'test_retcode.CITA.log.json'  ⍝ was a log-file written?
         →cleanExit Because'Failing test did not produce json-file' ⋄ :EndIf
     :If 21 Check(⎕JSON 1⊃⎕NGET f).rc
         →cleanExit Because'json-file "',f,'" did not contain expected rc 21' ⋄ :EndIf

     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.CITA.log'  ⍝ wipe out that expected log-file
     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.CITA.log.json'

     rc←300 sub_RunAPLProcess((##.TESTSOURCE,'lx')('CITATest=',##.TESTSOURCE,'test_retcode.dyalog mode=DTest ok=1 dtestmods="-off -loglvl=32',(##.verbose/' -verbose'),'"'))
     :If 20 Check rc
         →cleanExit Because'Succeeding test did not end with code 20 (returned ',(⍕cr),')' ⋄ :EndIf
     :If 0 Check ⎕NEXISTS ##.TESTSOURCE,'test_ok.log'  ⍝ was a log-file written?
         →cleanExit Because'Succeeding test produced log-file' ⋄ :EndIf
     :If 1 Check ⎕NEXISTS f←##.TESTSOURCE,'test_retcode.CITA.log.json'  ⍝ was a log-file written?
         →cleanExit Because'Succeeding test did not produce json-file' ⋄ :EndIf
     :If 20 Check(⎕JSON 1⊃⎕NGET f).rc
         →cleanExit Because'json-file "',f,'" did not contain expected rc 20' ⋄ :EndIf
     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.CITA.log.json'

cleanExit:
     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.CITA.log'  ⍝ wipe out that expected log-file
     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.session.log'
     1 ⎕NDELETE ##.TESTSOURCE,'test_retcode.CITA.log.json'
     1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'  ⍝ not interested in this file (forthis test)

 :EndIf
