 r←test_Quiet
   ⍝ Test quiet modifier to check that it really doesn't produce output (in case of successfull operation)
 r←⍬

   ⍝ 1. For DTest
 rc←300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',##.TESTSOURCE,'test_retcode.dyalog mode=DTest ok=1 dtestmods="-off -q -loglvl=40',(##.halt/' -halt'),' -testlog=',##.TESTSOURCE,'test_retcodeq"'))
 :If 0 Check 2 ⎕NINFO ##.TESTSOURCE,'test_retcode.session.log'
     →0 Because'Running DTest with -q (="quiet") modifier produced output!' ⋄ :EndIf

    ⍝ 2. for DBuild
 rc←300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_1.dyalogbuild -q" -RunCITAlog="',##.TESTSOURCE,'test_dbuilq"'))
 :If 0 Check 2 ⎕NINFO ##.TESTSOURCE,'test_retcode.session.log'
     →0 Because'Running DTest with -q (="quiet") modifier produced output!' ⋄ :EndIf

cleanExit:
 1 ⎕NDELETE ##.TESTSOURCE,'test_retcodeq.log'  ⍝ wipe out that expected log-file
 1 ⎕NDELETE ##.TESTSOURCE,'test_retcodeq.session.log'
 1 ⎕NDELETE ##.TESTSOURCE,'test_retcodeq.log'  ⍝ wipe out that expected log-file
 1 ⎕NDELETE ##.TESTSOURCE,'test_dbuildq.session.log'
 1 ⎕NDELETE ##.TESTSOURCE,'test_dbuildq.log.json'
 1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'  ⍝ not interested in this file (forthis test)
