r←test_wsfull1 dummy;wa
r←''
wa←⎕wa

⍝ create something that will be sure to explode
⍝ and don't do anything to trap errors, ofc

big1 ←(⌈.1×wa)⍴3.14
big2 ←(⌈.2×wa)⍴3.15
big3 ←(⌈.3×wa)⍴3.16
big4 ←(⌈.4×wa)⍴3.17