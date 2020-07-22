 r←test_DBuild_1 dummy
 r←''

 ⎕CMD'set DBuild1_EnvVar=testingDBuild'  ⍝ create envvar

 :If 0
     :If ##._DotNet>0
         dbval←'ThisIsTheDBulldEnvVar!'
         :Select ##._DotNet
         :Case 1 ⋄ ⎕USING←'System'
             Environment.SetEnvironmentVariable'DB_EnvVar'dbval
         :Case 2 ⋄ ⎕USING←'System,System.Runtime.Extensions'
             Environment.SetEnvironmentVariable'DB_EnvVar'dbval
         :EndSelect
         ⎕←'DB_EnvVar←',dbval

     :EndIf
 :EndIf



⍝ run build-script
 ⎕SE.UCMD'DBuild ',##.TESTSOURCE,⎕SE.SALTUtils.FS,'DBuild_1.dyalogbuild -c',##.halt/' -h'

 :If 'Test'Check #.ProdFlag
     →0 Because'ProdFlag did not have expected value "Test", but rather "',#.ProdFlag,'"' ⋄ :EndIf

 :If 0×dbval Check #.MyEnvVar
     →0 Because'EnvironmentVariable was not retrieved with correct value' ⋄ :EndIf


 'ic'#.⎕NS''
 larg←⎕NS''
 larg.target←'#.ic'
 larg ⎕SE.UCMD'LOAD initconga'

 :If (¯1↓#.ic.⎕CR'InitConga')Check ¯1↓#.conga.⎕CR'InitConga'
     →0 Because'InitConga not loaded identically to ]LOAD' ⋄ :EndIf

 :If 2 Check #.⎕ML
     →0 Because'DEFAULTS did not correctly process ⎕ML' ⋄ :EndIf
 :If 0 Check #.⎕IO
     →0 Because'DEFAULTS did not correctly process ⎕IO' ⋄ :EndIf
 :If 1E¯11 Check #.⎕CT
     →0 Because'DEFAULTS did not correctly process ⎕CT' ⋄ :EndIf
 :If 11 Check #.⎕PP
     →0 Because'DEFAULTS did not correctly process ⎕PP' ⋄ :EndIf

 :If 'conga' 'httpcommand'Check #.⎕NL-9
     →0 Because'Did not find exactly two namespace in #' ⋄ :EndIf

 :If 'MyEnvVar' 'ProdFlag'Check #.⎕NL-2
     →0 Because'Did not find exactly two variables in #' ⋄ :EndIf

 :If ⍬ Check #.⎕NL-3
     →0 Because'List of functions in # not empty as expected!' ⋄ :EndIf
