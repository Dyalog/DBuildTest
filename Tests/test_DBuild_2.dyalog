 r←test_DBuild_2 dummy;sink;exp;got
 r←''
 ⎕SE.SALT.Load ##.TESTSOURCE,'sub_RunAPLProcess.aplf'
 wsid←(739⌶0),'/DBuild2_TEST.dws'  ⍝ intentionally named differently to make test that the -target-modified is effective
 logfile←(739⌶0),'/DBuild2_TEST.log'
 1 ⎕NDELETE wsid
 1 ⎕NDELETE logfile

 sink←180 sub_RunAPLProcess(##.TESTSOURCE,'lx')('RunUCMD="DBuild ',##.TESTSOURCE,'DBuild_2.dyalogbuild -save=1 -c -p -off=1 -target=',wsid,'" TESTLOG=',##.TESTSOURCE,'DBuild_2')⍝(0)''(∊2↑⎕NPARTS logfile)(1⊃⎕NPARTS logfile)

 :If 1 Check ##.⎕NEXISTS wsid
     →0 Because'DBuild did not save workspace "',wsid,'"' ⋄ :EndIf

 #.⎕EX'test2'
 '#.test2'⎕NS''
 #.test2.⎕CY wsid

⍝ .dyalogbuild defines  
exp←'MyArray' 'array' 'london1' 'london2' 'var'
 :If 5 Check ≢got←#.test2.⎕NL ¯2
     →0 Because'Build ws contains more variables than the expected ones: ',∊¯3↓'"',¨(got~exp),¨⊂'", "' ⋄ :EndIf

 :If 2 Check≡#.test2.london1
 :OrIf (,577)Check⍴#.test2.london1   ⍝ hmm, should we read the file here so that have a more reliable idea of what to expect?
 :OrIf (⎕DR'─')Check ⎕DR∊#.test2.london1
     →0 Because'Format error with variable "london" (not a VTV)' ⋄ :EndIf
 :If #.test2.london2 Check∊#.test2.london1,¨⎕UCS 12
     →0 Because'Format error with variable "london2"' ⋄ :EndIf

 :If 2 Check≡#.test2.array
     →0 Because'Format error with variable "array"' ⋄ :EndIf

 :If 1 Check tally #.test2.⎕NL-1 3 4 5 6 7 8 9
     →0 Because'Build process left behind more than just 5 variables and a namespace' ⋄ :EndIf


 1 ⎕NDELETE ##.TESTSOURCE,'MemRep.dcf'  ⍝ not interested in this file (forthis test)
