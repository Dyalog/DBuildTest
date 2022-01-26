 r←test_DBuild_2 dummy;sink
 r←''
 ⎕SE.SALT.Load ##.TESTSOURCE,'sub_RunAPLProcess.aplf'
 wsid←(739⌶0),'/DBuild2_TEST.dws'  ⍝ intentionally named differently to make test that the -target-modified is effective
 logfile←(739⌶0),'/DBuild2_TEST.log'
 1 ⎕NDELETE wsid
 1 ⎕NDELETE logfile

 sink←180 sub_RunAPLProcess(##.TESTSOURCE,'RunCITA')('ExecCommand="]DBuild ',##.TESTSOURCE,'DBuild_2.dyalogbuild -save=1 -p -off=0 -target=',wsid,'"  UDEBUG=on CITA_Log="',logfile,'" CITAnqOFF=1')(0)''(∊2↑⎕NPARTS logfile)(1⊃⎕NPARTS logfile)

 :if 1 Check ##.⎕NEXISTS wsid
 →0 Because'DBuild did not save workspace "',wsid,'"'⋄:endif

 '#.test2'⎕NS''
 #.test2.⎕CY wsid

 :If ('foo' 'london1' 'london2')Check #.test2.⎕NL ¯2
     →0 Because'Build ws ',,' contains more variables than the expected ones' ⋄ :EndIf

 :If 2 Check≡#.test2.london1
 :OrIf (,577)Check⍴#.test2.london1   ⍝ hmm, should we read the file here so that have a more reliable idea of what to expect?
 :orif (⎕dr' ') Check ⎕dr∊#.test.london1
     →0 Because'Format error with variable "london" (not a VTV)' ⋄ :EndIf

 :If 2 Check≡#.test2.foo
     →0 Because'Format error with variable "foo"' ⋄ :EndIf

:if 0 Check tally #.test2.⎕nl¯1 3 4 5 6 7 8 9
→0 Because'Build process left behind more than just variables'⋄ :endif


