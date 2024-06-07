 r←test_Coverage dummy;myapl;rc;dcfg_file;dcfg;files;cov;cnt;log
 r←''
 :If 18≤1⊃##._Version  
     dcfg_file←##.TESTSOURCE,'test_Coverage.dcfg'

     :For cov :In 10×⍳10
         dcfg←⊂'{settings:{'
         dcfg,←⊂' CITATest: "',##.TESTSOURCE,'test_Coverage.dyalogtest",'
         dcfg,←⊂' CITA_LOG: "',##.TESTSOURCE,'test_Coverage",'
         dcfg,←⊂' COVERAGE_TARGET: ',(⍕cov),','
         dcfg,←⊂' mode: "DTest",'
         dcfg,←⊂' dtestmods: "-off -coverage -loglvl=40',(##.verbose/' -verbose'),(##.halt/' -halt'),'"'
         dcfg,←⊂'}}'
         (⊂dcfg)⎕NPUT dcfg_file 1
         rc←3000 sub_RunAPLProcess(##.TESTSOURCE,'lx')('USERCONFIGFILE=',dcfg_file)
         :If ##._isWin  ⍝ rc is only available on Windows
             :If 20 Check rc  ⍝ did job end with expected rc?
                 →cleanExit Because'Suceeding test did not end with code 20 (returned ',(⍕rc),')' ⋄ :EndIf
         :EndIf
         :If 1 Check ⎕NEXISTS f←##.TESTSOURCE,'test_Coverage.log.json'  ⍝ was a log-file written?
             →cleanExit Because'Test did not produce json-file' ⋄ :EndIf

         log←⎕JSON 1⊃⎕NGET ##.TESTSOURCE,'test_Coverage.log.json'
         :If 20 Check log.rc                 ⍝ return code = ok?
             →cleanExit Because'Suceeding test did not end with code 20 (returned ',(⍕rc),')' ⋄ :EndIf
         :If cov Check log.CoveragePercent   ⍝ did we get the expected coverage?
             →cleanExit Because'Coverage was not =',(⍕cov),'as expected but ',(⍕log.CoveragePercent) ⋄ :EndIf
     :EndFor

cleanExit:
   ⍝ remove files that were created while running the test
     1 ⎕NDELETE ##.TESTSOURCE,'test_Coverage.log.json' 
     1 ⎕NDELETE ##.TESTSOURCE,'test_Coverage.session.log'  

     1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'  ⍝ not interested in this file (forthis test)
     1 ⎕NDELETE dcfg_file
 :EndIf
