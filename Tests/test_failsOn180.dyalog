R←test_failsOn180
 :If '18.0'≡4↑v←2⊃'.'⎕WG'APLVersion'
     ⎕←R←'This test fails intentionally on v18.0 - and was executed against Version ',v
 :Else
     R←''
 :EndIf