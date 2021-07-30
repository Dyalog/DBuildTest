 r←test_DBuild_2 dummy;sink
 r←''

 :If ##.DyaVersion>17    ⍝ this test deals with ]LINKed variables - so it will work on 17.1 or greater
     sink←##.Build ##.TESTSOURCE,'DBuild_2.dyalogbuild -c -q=2'

     :If (,⊂'NonParametric')Check #.⎕NL-9
         →0 Because'Did not find exactly one namespace in #' ⋄ :EndIf

     :If ('foo' 'qNGET')Check #.⎕NL-3.1 3.2
         →0 Because'List of functions in # not as expected!' ⋄ :EndIf


     :If ('MyArray' 'array' 'var')Check #.⎕NL-2.1
         →0 Because'List of variables in # not as expected!' ⋄ :EndIf

     :If ((⍳3)∘.,'ABCD')Check #.var
         →0 Because'"var" did not contain expected value!' ⋄ :EndIf
 :EndIf

⍝ test that it errs when trying to get .apla into <17.1!
