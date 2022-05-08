 r←test_SuccessIndicator dummy;myapl;rc;theTest;cmdLineParams;expectedResult
⍝ test correct handling of new optional SuccessIndicator in .dyalogtest files
⍝ We test this by launching another interpreter and running test that will indicate their success
⍝ as defined in the .dylogtest that is used. The result of the test is pre-determined using
⍝ param "SucIntVal" (which is specific to THIS test and not a generic thing)
⍝ and THE key function then is to check is the test succeeds or fails as expected (if it interprets the return value correctly)

⍝ =============   Init: set up vars a tools as needed
 r←''

 WeHaveAlog←{⎕NEXISTS ##.TESTSOURCE,theTest,'.log.json'}   ⍝ was a log file written?
 GetJSONlog←{⍝ read the log file and return a → target in r[1] and the log in r[2]
     a←(∊2↑⎕NPARTS ##.TESTSOURCE),theTest,'.log.json'
     0::(cleanExit Because'Caught error processing ',a,':',(⎕UCS 13),(⎕JSON⍠'Compact' 0)⎕DMX)⍬
     ⍬(⎕JSON 1⊃⎕NGET ⎕←a)
 }

 ClearLogs←{⍝ delete logfiles
     sink←1 ⎕NDELETE ##.TESTSOURCE,'test_',theTest,'.log'  ⍝ wipe out that expected log-file
     trash←1 ⎕NDELETE ##.TESTSOURCE,'test_',theTest,'.log.json'
     0
 }

 RunTest←{⍝ execute a test (SuccessIndicatorEnvVar⍵) and return result ⍺ (default is ⍵)
     ⍺←⍵
     a←{
    ⍝      ' '=⍥⎕DR ⍵:'''''',⍵,''''''
         ⍵  ⍝ always use ⍵
     }⍺
     w←⍕⍵
     sink←ClearLogs w
     30 sub_RunAPLProcess((##.TESTSOURCE,'RunCITA')(⎕←'CITATest=',(f←##.TESTSOURCE,theTest,'.dyalogtest'),' mode=DTest ',(' dtestmods="'cmdLineParams ⍺),' -off -loglvl=32',(##.halt/' -halt'),(##.verbose/' -verbose'),'"'))
     0
 }

 Execute←{
     sink←⍺{
         ##.verbose:⎕←'Running ',theTest,' with cmdLineParams "',(''cmdLineParams ⍵),'", returning ',⍺,', expecting it to ',(1+⍺{
             0=⎕NC'expectedResult':⍺≡⍵
             expectedResult
         }⍵)⊃'fail' 'succeed'
     }⍵
     ⍺←⍵
     sink←⍺ RunTest ⍵
 ⍝ was a log-file written?
     1 Check WeHaveAlog⍕⍵:(cleanExit Because'Test did not produce json-file') ⍝ could also be an indication of a crash....!

     res←GetJSONlog⍕⍵
     ⍬≢⊃res:res

     res←2⊃res
⍝sink←(⎕lc[1]+1)⎕stop 1⊃⎕si
     sink←##.verbose{⍺::⎕←'rc=',⍕ ⋄ ⍬}res.rc
     exp←⍺{
         0=⎕NC'expectedResult':20+⍺≢⍵
         20+⍵≢expectedResult ⍝ optional variable "expectedResult" allows us to define the expected value
     }⍵ ⍝ expected returncode (20=ok, 21:failure)
     exp Check res.rc:cleanExit Because'Test "',theTest,'" (⍺=',(⍕⍺),') did not end with expected indicator ',(⍕exp),' but returned ',{' '=⍥⎕DR ⍵:'"',⍵,'"' ⋄ ⍕⍵}res.rc
     ⍬
 }


⍝=========================== The tests   ==================================================
→goHere
 cmdLineParams←{'SucIntVal=',(⍕⍵),' ',⍕⍺}  ⍝ pass an environment variable SucIntVal
 theTest←'SuccessIndicatorEnvVar0'
 →0 Execute 0
 →32768 Execute 0
 theTest←'SuccessIndicatorEnvVar42'
 →42 Execute 42
 →'OK' Execute 42
 theTest←'SuccessIndicatorEnvVarOK'
 →'OK'Execute'OK'
 →'APL'Execute'OK'
 →37 Execute'OK'

goHere:
 theTest←'SuccessIndicator0'
 cmdLineParams←{q←(' '=⍥⎕dr ⍵)/'''' ⋄ ⍺,' -SuccessIndicator=',q,(⍕⍵),q}  ⍝ pass value as modifier for DTest command

⍝  →0 Execute 0
 expectedResult←1  ⍝ indicates failure

 →',0' Execute 0



cleanExit:
 ClearLogs ⍬
