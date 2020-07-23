 r←test_DBuild_1 dummy;ucmd_flags
 r←''
 :If ##.halt ⋄ ⎕SE.UCMD'sink←UDEBUG on' ⋄ :EndIf ⍝ otherwise halt won't propagate properly into the ]DBUild-Call...

 :If 0
 ⍝ can't do this because changes to EnvVars are not visible to dyalog⌈
     dbval←'ThisIsTheDBuildEnvVar!'
     :If ##._DotNet>0
         :Select ##._DotNet
         :Case 1 ⋄ ⎕USING←'System'
             Environment.SetEnvironmentVariable'DB_EnvVar'dbval
         :Case 2 ⋄ ⎕USING←'System,System.Runtime.Extensions'
             Environment.SetEnvironmentVariable'DB_EnvVar'dbval
         :EndSelect
         ⎕←'DB_EnvVar←',dbval

     :EndIf
 :EndIf

⍝ create some fns/vars to test if "-c" really clears them...
 #.⎕CY'dfns'
 #.foo←'goo'

ucmd_flags←(##.halt/' -h'),(##.verbose/' -v'),##.quiet/' -q'
⍝ run build-script (non-prod mode)
 ⎕SE.UCMD'DBuild ',##.TESTSOURCE,'DBuild_1.dyalogbuild -c',ucmd_flags

 :If 'conga' 'httpcommand'Check #.⎕NL-9
     →0 Because'Did not find exactly two namespace in #' ⋄ :EndIf

 :If 'Dollar' 'MyEnvVar' 'ProdFlag'Check #.⎕NL-2.1
     →0 Because'Did not find exactly 3 variables in #' ⋄ :EndIf

 :If (0/⊂'')Check #.⎕NL-3.1
     →0 Because'List of functions in # not empty as expected!' ⋄ :EndIf

 :If 'Test'Check #.ProdFlag
     →0 Because'ProdFlag did not have expected value "Test", but rather "',#.ProdFlag,'"' ⋄ :EndIf

 :If 2=⎕NC'dbval'
     :If 0×dbval Check #.MyEnvVar
         →0 Because'EnvironmentVariable was not retrieved with correct value' ⋄ :EndIf
 :EndIf

 'ic'#.⎕NS''⋄#.ic ⎕SE.UCMD'sink←LOAD initconga'

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

⍝ re-run build-script (this time in production mode)
 ⎕SE.UCMD'DBuild ',##.TESTSOURCE,'DBuild_1.dyalogbuild -c -p',ucmd_flags

:If 'Production'Check #.ProdFlag
     →0 Because'ProdFlag did not have expected value "Production", but rather "',#.ProdFlag,'"' ⋄ :EndIf
