 r←test_DBuild_2 dummy;ucmd_flags
 r←''
 :if ##.DyaVersion>17    ⍝ this test deals with ]LINKed files - so it it will work on 17.1 or greater
 :If ##.halt ⋄ ⎕SE.UCMD'sink←UDEBUG on' ⋄ :EndIf ⍝ otherwise halt won't propagate properly into the ]DBUild-Call...

 ucmd_flags←(##.halt/' -h'),##.quiet/' -q'
 ⎕SE.UCMD'DBuild ',##.TESTSOURCE,'DBuild_2.dyalogbuild -c',ucmd_flags

 :If (,⊂'NonParametric')Check #.⎕NL-9
     →0 Because'Did not find exactly one namespace in #' ⋄ :EndIf

 :If ('foo' 'qNGET')Check #.⎕NL-3.1 3.2
     →0 Because'List of functions in # not as expected!' ⋄ :EndIf

 :If ('MyArray' 'array' 'var')Check #.⎕NL-2.1
     →0 Because'List of variables in # not as expected!' ⋄ :EndIf

 :If ((⍳3)∘.,'ABCD')Check #.var
     →0 Because'"var" did not contain expected value!' ⋄ :EndIf

:endif