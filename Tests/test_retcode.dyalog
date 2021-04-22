r←test_retcode dummy;ok
⍝ useful testcase in combination with -off to test returncode
⍝ use "ok=0|1" to control result of this test (default is ok)
⍝ This test is used by test_ReturnCode.
r←''
ok←⊃1↑(1+⎕io)⊃⎕vfi{0=⍴,⍵:'1'⋄⍵}2⎕nq'.' 'GetEnvironment' 'ok'
:if 1 Check ok
   →0 Because 'This test was instructed to fail by passing envvar "ok" with value ',(⍕ok),'!' ⋄ :endif