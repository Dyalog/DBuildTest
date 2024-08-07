 r←setup_Coverage null;nr;n;NR
 '#.ns_Coverage'⎕NS''
 nr←⎕NR'test_Coverage_'
 :For n :In ⍳100
     NR←nr
     NR[1]←⊂'R←test_Coverage_',(,'ZI4'⎕fmt n),' null'
     #.ns_Coverage.⎕FX NR
 :EndFor
 r←''
