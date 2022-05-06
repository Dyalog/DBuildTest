 r←test_SuccessIndicator dummy;myapl;rc
⍝ test correct handling of new optional SuccessIndicator in .dyalogtest files
⍝ We test this by launching another interpreter
⍝ and running test

 r←''
 WeHaveAlog←{⎕NEXISTS f←##.TESTSOURCE,'SuccessIndicatorEnvVar.log.json'}   ⍝ was a log file written?
 GetJSONlog←{
     a←(∊2↑⎕NPARTS ⍵),'.log.json'
     0::(cleanExit Because'Caught error processing ',a,':',(⎕UCS 13),(⎕JSON⍠'Compact' 0)⎕DMX)⍬
     ⍬(⎕JSON 1⊃⎕NGET a)
 }

⍝ First do 2 runs where are thoroughly check everything
 {}300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',(f←##.TESTSOURCE,'SuccessIndicatorEnvVar0.dyalogtest'),' SucIntVal=32768 mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
 :If 1 Check WeHaveAlog ⍬⍝ was a log-file written?
     →cleanExit Because'Test did not produce json-file' ⋄ :EndIf

 →⊃res←GetJSONlog f
 res←2⊃res

 :If 21 Check res.rc
     →cleanExit Because'Failing test did not end with code 21 (returned ',(⍕res.rc),')' ⋄ :EndIf

 1 ⎕NDELETE ##.TESTSOURCE,'test_SuccessIndicator.log'  ⍝ wipe out that expected log-file
 1 ⎕NDELETE ##.TESTSOURCE,'test_SuccessIndicator.log.json'

 {}300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',(f←##.TESTSOURCE,'SuccessIndicatorEnvVar0.dyalogtest'),' SucIntVal=0 mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
 :If 1 Check WeHaveAlog ⍬⍝ was a log-file written?
     →cleanExit Because'Test did not produce json-file' ⋄ :EndIf

 →⊃res←GetJSONlog f
 res←2⊃res

 :If 20 Check res.rc
     →cleanExit Because'Test did not end with code 20 (returned ',(⍕res.rc),')' ⋄ :EndIf

⍝ now relax and just check if we get the expected result

 {}300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',(f←##.TESTSOURCE,'SuccessIndicatorEnvVar42.dyalogtest'),' SucIntVal=42 mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
 →⊃res←GetJSONlog f
 res←2⊃res
 :If 20 Check res.rc
     →cleanExit Because'Test did not end with code 20 (returned ',(⍕res.rc),')' ⋄ :EndIf

 {}300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',(f←##.TESTSOURCE,'SuccessIndicatorEnvVarOK.dyalogtest'),' SucIntVal=42 mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
 →⊃res←GetJSONlog f
 res←2⊃res
 :If 21 Check res.rc
     →cleanExit Because'Test did not end with code 21 (returned ',(⍕res.rc),')' ⋄ :EndIf

 {}300 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')('CITATest=',(f←##.TESTSOURCE,'SuccessIndicatorEnvVar42.dyalogtest'),' SucIntVal=''abc'' mode=DTest ok=0 dtestmods="-off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
 →⊃res←GetJSONlog f
 res←2⊃res
 :If 21 Check res.rc
     →cleanExit Because'Test did not end with code 21 (returned ',(⍕res.rc),')' ⋄ :EndIf




cleanExit:
 1 ⎕NDELETE ##.TESTSOURCE,'test_SuccessIndicator.log'  ⍝ wipe out that expected log-file
 1 ⎕NDELETE ##.TESTSOURCE,'test_SuccessIndicator.session.log'
 1 ⎕NDELETE ##.TESTSOURCE,'test_SuccessIndicator.log.json'
