 r←test_DBuild_3 dummy;ucmd_flags;l
 r←''
 :If 17.1≤##.DyaVersion  ⍝ this test requires v17.1 or better
sort←{⍵[⍋⍵]}
⍝ create some fns/vars to test if "-c" really clears them...
     #.⎕CY'dfns'
     #.foo←'goo'

     ucmd_flags←(##.halt/' -h'),##.quiet/' -q'
⍝ run build-script (non-prod mode)
     ##.Build ##.TESTSOURCE,'DBuild_3.dyalogbuild -c',ucmd_flags

     :If (sort'MyNS0' 'MyNS1' 'conga' 'httpcommand')Check l←sort #.⎕NL-9
         →0 Because'Did not find exactly four namespace in # but got ',⍕l ⋄ :EndIf
     :If 0 0 Check #.MyNS0.(⎕IO ⎕ML)
         →0 Because'New namespace MyNS0 did not have expected ⎕IO/⎕ML (according to defaults) set in script' ⋄ :EndIf
     :If 1 1 Check #.MyNS1.(⎕IO ⎕ML)
         →0 Because'New namespace MyNS1 did not have expected ⎕IO/⎕ML (according to defaults) set in script' ⋄ :EndIf

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

     'ic'#.⎕NS'' ⋄ ⎕SE.SALT.Load'InitConga -target=#.ic'

     :If (¯1↓#.ic.⎕CR'InitConga')Check ¯1↓#.conga.⎕CR'InitConga'
         →0 Because'InitConga not loaded identically to ]LOAD' ⋄ :EndIf

     :If (,⊂'HttpCommand')Check #.httpcommand.⎕NL ¯9
         →0 Because'HttpCommand was not loaded into httpcommand'

         :If 2 Check #.⎕ML
             →0 Because'DEFAULTS did not correctly process ⎕ML' ⋄ :EndIf
         :If 0 Check #.⎕IO
             →0 Because'DEFAULTS did not correctly process ⎕IO' ⋄ :EndIf
         :If 1E¯11 Check #.⎕CT
             →0 Because'DEFAULTS did not correctly process ⎕CT' ⋄ :EndIf
         :If 11 Check #.⎕PP
             →0 Because'DEFAULTS did not correctly process ⎕PP' ⋄ :EndIf

⍝ re-run build-script (this time in production mode)
         ##.Build ##.TESTSOURCE,'DBuild_3.dyalogbuild -c -p',ucmd_flags

         :If 'Production'Check #.ProdFlag
             →0 Because'ProdFlag did not have expected value "Production", but rather "',#.ProdFlag,'"' ⋄ :EndIf
     :EndIf
 :EndIf
