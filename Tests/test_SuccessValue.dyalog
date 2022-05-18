 r←test_SuccessValue dummy;myapl;rc;theTest;cmdLineParams;sult
⍝ test correct handling of new optional SuccessValue in .dyalogtest files
⍝ We test this by launching another interpreter and running test that will indicate their success
⍝ as defined in the .dylogtest that is used. The result of the test is pre-determined using
⍝ param "SucVal" (which is specific to THIS test and not a generic thing)
⍝ and THE key function then is to check is the test succeeds or fails as expected (if it interprets the return value correctly)

⍝ =============   Init: set up vars a tools as needed
 r←''

 WeHaveAlog←{⎕NEXISTS ##.TESTSOURCE,(2⊃⎕nparts theTest),'.log.json'}   ⍝ was a log file written?
 GetJSONlog←{⍝ read the log file and return a → target in r[1] and the log in r[2]
     a←(∊2↑⎕NPARTS ##.TESTSOURCE),(2⊃⎕nparts theTest),'.log.json'
     0::(cleanExit Because'Caught error processing ',a,':',(⎕UCS 13),(⎕JSON⍠'Compact' 0)⎕DMX)⍬
     ⍬(⎕JSON 1⊃⎕NGET a)
 }

 ClearLogs←{⍝ delete logfiles
     0<≢⍵:sink←1(⎕NDELETE ⎕OPT'Wildcard'('*'∊⍵))##.TESTSOURCE,⍵  ⍝ wipe out that expected log-file
     sink←1 ⎕NDELETE ##.TESTSOURCE,'test_',(2⊃⎕nparts theTest),'.log'  ⍝ wipe out that expected log-file
     trash←1 ⎕NDELETE ##.TESTSOURCE,'test_',(2⊃⎕nparts theTest),'.log.json'
     ⍬
 }

 RunTest←{⍝ execute a test (passing cmdLineParams ⍵)
     sink←ClearLogs ⍬
     sink←##.verbose{
         ⍺:⎕←⍵
         ⍬
     }pars←'CITATest=',(f←##.TESTSOURCE,theTest,(~'.'∊theTest)/'.dyalogtest'),' mode=DTest ',(' dtestmods="'cmdLineParams ⍵),' -off -loglvl=32',(##.halt/' -halt'),(##.trace/' -trace'),(##.verbose/' -verbose'),'"'
     ((1+##.(halt∨trace))⊃30(0.001×⌊/⍬))sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')pars
     0
 }




 Execute←{
     ⍝ ⍺=expected Result: 0=success, 1=failure
     ⍝ ⍵= run test indicated by "theTest", passing cmdLineParams ⍵
     ⍝ uses these vars:
     ⍝ cmdLineParams: a fn to construct the commandlineparams for the DTest call.
     ⍝                uses ⍺ and ⍵. ⍺ is 'dtestmods="', so you may add DTestmodifiers (by appending to ⍺)
     ⍝                or pass general envVars (by prefixing ⍵ to ⍺). The closing quotes for ⍺ will be added by RunTest
     ⍝ theTest      : name of test to execute
     msgTheTest←theTest,' with cmdLineParams "',(''cmdLineParams ⍵),'"'
     sink←⍺{
         ##.verbose:⎕←'Running ',msgTheTest,', expecting it to ',(1+⍺)⊃'succeed' 'fail'
         ⍬
     }⍵
     sink←RunTest ⍵
 ⍝ was a log-file written?
     1 Check WeHaveAlog⍕⍵:(cleanExit Because'Test ',msgTheTest,' did not produce json-file') ⍝ could also be an indication of a crash....!

     res←GetJSONlog⍕⍵
     ⍬≢⊃res:res

     res←2⊃res
⍝sink←(⎕lc[1]+1)⎕stop 1⊃⎕si
     sink←##.verbose{⍺::⎕←'rc=',⍕ ⋄ ⍬}res.rc
     exp←20+⍺
     exp Check res.rc:cleanExit Because(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',((⎕IO+2⊃⎕LC)⊃⎕NR 2⊃⎕SI),' did not end with expected indicator ',(⍕exp),' but returned ',{' '=⍥⎕DR ⍵:'"',⍵,'"' ⋄ ⍕⍵}res.rc
     ⍬
 }

 ⎕SE.UCMD'GetTools4CITA'   ⍝ populate ⎕se._cita


⍝=========================== The tests   ==================================================
 cmdLineParams←{'SucVal=',('b64!',#.base64enc'json!',1 ⎕JSON ⍵),' ',⍺,' -SuccessValue=json!0'}  ⍝ pass an environment variable SucVal
theTest←'test_assert.aplf'
→0 Execute 0

 cmdLineParams←{'SucVal=',('b64!',#.base64enc'json!',1 ⎕JSON ⍵),' ',⍕⍺}  ⍝ pass an environment variable SucVal
 theTest←'SuccessValueEnvVar0'
 →0 Execute 0
 →1 Execute'0'
 →1 Execute ,0
 →1 Execute 32768


 theTest←'SuccessValueEnvVar42'
 →0 Execute 42
 →1 Execute'json![42]'
 →1 Execute'OK'

 theTest←'SuccessValueEnvVarOK'
 →0 Execute'OK'
 →1 Execute'APL'
 →1 Execute'ok'
 →1 Execute 0

 theTest←'SuccessValueOK'
 cmdLineParams←{⍺,' -SuccessValue=',(⍕⍵),' '}  ⍝ pass value as modifier for DTest command
 →1 Execute 0

 theTest←'SuccessValueLongString'
 cmdLineParams←{⍺,' -SuccessValue=b64!',(⍕⍵),' '}  ⍝ pass value as modifier for DTest command
 →0 Execute #.base64enc'apl!''<The test executed on >,ZI4,<->,ZI2,<->,ZI2,< found no problems!>''⎕fmt 1 3⍴⎕TS'

 cmdLineParams←{⍺,' -SuccessValue=b64!',(⍕⍵),' '}  ⍝ pass value as modifier for DTest command
 →1 Execute #.base64enc'apl!,''<The test executed on >,ZI4,<->,ZI2,<->,ZI2,< found no problems!>''⎕fmt 1 3⍴⎕TS'




cleanExit:
 sink←ClearLogs'SuccessValue*.lo*'
 1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'
