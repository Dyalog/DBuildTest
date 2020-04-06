:Namespace DyalogBuild ⍝ V 1.25
⍝ 2017 04 11 MKrom: initial code
⍝ 2017 05 09 Adam: included in 16.0, upgrade to code standards
⍝ 2017 05 21 MKrom: lowercase Because and Check to prevent breaking exisitng code
⍝ 2017 05 22 Adam: reformat
⍝ 2017 05 23 Adam: uppercased Because and Check and moved Words, reinstate blank lines, make compatible with 15.0
⍝ 2017 06 05 Adam: typo
⍝ 2017 06 15 Adam: TOOLS → EXPERIMENTAL
⍝ 2017 06 18 MKrom: test for missing argument
⍝ 2017 06 23 MKrom: get rid of empty fn names
⍝ 2017 06 24 Brian: Allow commented lines in dyalogtest files, drop leading comma in args.tests, exit gracefully if no tests defined
⍝ 2017 06 27 Adam: Add disclaimer to help
⍝ 2017 07 24 MKrom: save exists state
⍝ 2017 12 12 Brian: DBuild - allow SALT "special" locations (e.g. [DYALOG], et al), add 'apl' as loadable type
⍝ 2018 01 12 Brian: DBuild - if the user specifies a folder and there's only a single .dyalogbuild file, use it
⍝ 2018 03 28 MKrom: Add "PROD" command, as EXEC but only executed for production builds
⍝ 2018 03 28 MKrom: Tolerate tab in place of space
⍝ 2018 03 29 MKrom: Also look for .dyalogtest file below WSFOLDER and WSFOLDER/Tests
⍝ 2018 03 29 MKrom: Added "Fail" function
⍝ 2018 04 18 Adam: ]??cmd → ]cmd -??
⍝ 2018 05 01 Adam: add SVN tag
⍝ 2018 05 07 Adam: help text tweak
⍝ 2018 05 17 MKrom: Bugfix: EXEC commands were not being executed in production builds
⍝ 2018 05 19 MKrom: Report errors in result of ]dbuild
⍝ 2018 05 24 Adam: Move to DEVOPS
⍝ 2018 06 27 Adam: Remove "experimental" warning
⍝ 2018 06 28 Adam: Check actual version. Add DATA: path, Format=charvecs(default)/charvec/charmat/json, SetEOL=crlf/etc.
⍝ 2018 09 28 Brian: DTest - Allow wildcards ? and * in test function names (regex will also work)
⍝ 2018 11 13 Adam: help tweak
⍝ 2019 02 01 Adam: help
⍝ 2019 02 13 Brian: allow commented lines in build scripts
⍝ 2019 03 14 MBaas: handle nested msgs
⍝ 2020 01 21 MBaas: mostly backward-compatibile with v12 (need to sort out ⎕R/⎕S,@)
⍝ 2020 01 22 MBaas: compatibility with Classic
⍝ 2020 01 23 MBaas: took care of ⎕R,⎕S,@
⍝ 2020 01 24 MBaas: DBuild: added switch -halt for "halt on error" as in DTest; fixed bugs found while testing under v12
⍝ 2020 01 27 MBaas: DBuild: target: wsid, save=1, off=1 (and switch -save=1 to override settings from file);]DBuild: added -TestClassic
⍝ 2020 01 28 MBaas: DBuild: -TestClassic=version;bug fixes;doco
⍝ 2020 01 29 MBaas: DBuild: $EnvVar
⍝ 2020 03 23 MBaas: made TestClassic is a simple switch w/o values assigned; fixes dealing with -halt in -save in DBuild;various minor fixes
⍝ 2020 04 03 MBaas: added -clear to DTest to make sure that the ws is ⎕CLEARed before executing tests (simplifies repeated testing)
⍝ 2020 04 06 MBaas: ]DBuild 1.25 executes the content of secret variable ⎕SE.DBuild_postSave after saving the ws 

    ⎕ML←1

    :Section Compatibility
    ∇ R←DyaVersion
      R←{2⊃⎕VFI(2>+\'.'=⍵)/⍵}2⊃'.'⎕WG'APLVersion'
    ∇

    Classic←{92::1 ⋄ 0×⎕ucs ⎕ucs ⍵}9056  ⍝ running on a classic edition???

    ∇ {sink}←SetupCompatibilityFns
      sink←⍬   ⍝ need dummy result here, otherwise getting VALUE ERROR when ⎕FX'ing namespace
      :If 13≤DyaVersion
          table←⍪
          ltack←⊣
          rtack←⍎⎕UCS 8866
          GetNumParam←{⍺←⊣ ⋄ ⊃2⊃⎕VFI ⍺ GetParam ⍵}    ⍝ Get numeric parameter (0 if not set)
      :Else
          table←{r←(⍴⍵),(1≥⍴⍴⍵)/1 ⋄ r←r[1],×/1↓⍴⍵ ⋄ r⍴⍵}
          ltack←{⍺}
          rtack←{⍵}
          GetNumParam←{⍺←'0' ⋄ ⊃2⊃⎕VFI ⍺ GetParam ⍵}    ⍝ Get numeric parameter (0 if not set)
      :EndIf
     
      :If 15≤DyaVersion
          GetFilesystemType←{⊃1 ⎕NINFO ⍵} ⍝ 1=Directory, 2=Regular file
          ListFiles←{⍺←'' ⋄ ⍺ ListPost15 ⍵}
          qNGET←{⎕NGET ⍵ 1}
      :Else
          ListFiles←{⍺←'' ⋄ ⍺ ListPre15 ⍵}
          GetFilesystemType←{2-(ListFiles{(-∨/'\/'=¯1↑⍵)↓⍵}⍵)[1;4]}
          qNGET←{,⊂GetVTV ⍵}              ⍝ return nested content, so that 1⊃qNGET is ≡ 1⊃⎕NGET (no other elements used here!)
      :EndIf
     
      :If 16≤DyaVersion
      :AndIf ~Classic
          where←⍎⎕UCS 9080
      :Else
          where←{(,⍵)/,⍳⍴⍵}
      :EndIf
     
      :If 18≤DyaVersion
          lc←¯1∘⎕C                                    ⍝ lower case
          uc←1∘⎕C                                     ⍝ upper case
      :ElseIf 15≤DyaVersion
          lc←819⌶                                     ⍝ lower case
          uc←1∘(819⌶)                                 ⍝ upper case
      :Else
          lowerAlphabet←'abcdefghijklmnopqrstuvwxyzáâãçèêëìíîïðòóôõùúûýàäåæéñöøü'
          upperAlphabet←'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÂÃÇÈÊËÌÍÎÏÐÒÓÔÕÙÚÛÝÀÄÅÆÉÑÖØÜ'
          fromto←{n←⍴1⊃(t f)←⍺ ⋄ ~∨/b←n≥i←f⍳s←,⍵:s ⋄ (b/s)←t[b/i] ⋄ (⍴⍵)⍴s} ⍝ from-to casing fn
          lc←lowerAlphabet upperAlphabet∘fromto ⍝ :Includable Lower-casification of simple array
          uc←upperAlphabet lowerAlphabet∘fromto ⍝ Ditto Upper-casification
      :EndIf
    ∇

    SetupCompatibilityFns

    ∇ r←{normalize}qNPARTS filename;filesep;mask;path;file;ext;cd;i;pth
          ⍝ splits a filename into: path name ext
      :If 0=⎕NC'normalize' ⋄ normalize←0 ⋄ :EndIf
      :If 15≤DyaVersion
          r←normalize ⎕NPARTS filename
      :Else
          filesep←(~isWin)↓'\/'
          mask←⌽∨\⌽filename∊filesep
          path←mask/filename
          ((path∊filesep)/path)←'/'
          file←(~mask)/filename
          :If normalize
              cd←GetCurrentDirectory,'/' ⋄ pth←path ⋄ path←''
              ((cd∊filesep)/cd)←'/'
              :If 0∊⍴pth ⋄ path←cd ⋄ :Else
                  :While 0<⍴pth
                      :If './'≡2↑pth ⋄ path←cd{0∊⍴⍵:⍺ ⋄ ⍵}path ⋄ pth←2↓pth
                      :ElseIf '../'≡3↑pth ⋄ path←{(2≤⌽+\⌽⍵∊filesep)/⍵}cd{0∊⍴⍵:⍺ ⋄ ⍵}path ⋄ pth←3↓pth
                      :Else ⋄ i←⍬⍴where pth∊filesep ⋄ path←path,i↑pth ⋄ pth←i↓pth
                      :EndIf
                  :EndWhile
              :EndIf
          :EndIf
          mask←∨\⌽<\⌽'.'=file
          ext←mask/file
          file←(~mask)/file
          r←path file ext
      :EndIf
    ∇

    ∇ r←GetCurrentDirectory;GCD;GetLastError
     ⍝ Get Current Directory
      :Select APLVersion
      :CaseList '*nix' 'Mac'
          r←⊃_SH'pwd'
      :Case 'Win'
          'GCD'⎕NA'I kernel32.C32∣GetCurrentDirectory* I4 >0T'
          :If 0≠1⊃r←GCD 256 256
              r←2⊃r
          :Else
              ⎕NA'I4 kernel32.C32|GetLastError'
              11 ⎕SIGNAL⍨'GetCurrentDirectory error:',⍕GetLastError
          :EndIf
      :EndSelect
    ∇


    ∇ {larg}qMKDIR path;CreateDirectory;GetLastError;err
      ⍝ Create a folder
      :If 15>DyaVersion      ⍝ Versions < 15 can't deal with the different ⍺ of ⎕MKDIR, so larg is ignored here...
          :Select APLVersion
          :CaseList '*nix' 'Mac'
              :If ~DirExists path
                  1 _SH'mkdir ',unixfix path
                  ('mkdir error on ',path)⎕SIGNAL 11/⍨~DirExists path
              :EndIf
          :Case 'Win'
              ⎕NA'I kernel32.C32∣CreateDirectory* <0T I4' ⍝ Try for best function
              →(0≠CreateDirectory path 0)⍴0 ⍝ 0 means "default security attributes"
              ⎕NA'I4 kernel32.C32|GetLastError'
              err ⎕SIGNAL⍨'CreateDirectory error:',⍕err←GetLastError
          :EndSelect
      :Else
          :If 0=⎕NC'larg'
              ⎕MKDIR path
          :Else
              larg ⎕MKDIR path
          :EndIf
      :EndIf
    ∇


    ∇ R←qNEXISTS FileOrDir
      :If DyaVersion≤15
          :Trap R←0
              R←0<1↑⍴ListFiles FileOrDir
          :EndTrap
      :Else
          R←⎕NEXISTS FileOrDir
      :EndIf
    ∇

    ∇ qNDELETE name;DeleteFileX;GetLastError;FindFirstFile;FindNextFile;FindClose;handle;rslt;ok;next;⎕IO;path
      :If qNEXISTS name
          :If DyaVersion≤15
              ⎕IO←0
              :Select APLVersion
              :CaseList '*nix' 'Mac'
                  _SH'rm -f ',unixfix name
              :Case 'Win'
                  'DeleteFileX'⎕NA'I kernel32.C32∣DeleteFile* <0T'
                  ⎕NA'I4 kernel32.C32|GetLastError'
                  :If ∨/'*?'∊name ⍝ wildcards?
                      path←{(⌽∨\⌽⍵∊'\/')/⍵}name
                      _FindDefine
                      handle rslt←_FindFirstFile name
                      :If 0=handle
                          :Return ⍝ ('ntdir error:',⍕rslt)⎕SIGNAL 102      ⍝ file not found
                      :EndIf
                      :If '.'≠⊃6⊃rslt
                          {}DeleteFileX⊂path,6⊃rslt
                      :EndIf
                      :While 1=0⊃ok next←_FindNextFile handle
                          :If '.'≠⊃6⊃next
                              {}DeleteFileX⊂path,6⊃next
                          :EndIf
                      :EndWhile
                      :If 0 18∨.≠ok next
                          ('ntdir error:',⍕next)⎕SIGNAL 11   ⍝ DOMAIN
                      :EndIf
                      {}FindClose handle
                  :Else
                      :If 0=DeleteFileX⊂name
                          11 ⎕SIGNAL⍨'DeleteFile error:',⍕GetLastError
                      :EndIf
                  :EndIf
              :EndSelect
          :Else
              ⎕NDELETE name
          :EndIf
      :EndIf
    ∇

    ∇ r←{pattern}ListPost15 path
      :If 0=⎕NC'pattern' ⋄ :OrIf pattern≡'' ⋄ pattern←''
      :Else ⋄ path,←(~path[≢path]∊'\/')/'/'
      :EndIf
      r←⍉↑0 2 9 1(⎕NINFO ⎕OPT 1)(path,pattern)
      r[;4]←r[;4]=1
    ∇

    ∇ r←{pattern}ListPre15 path;z;rslt;handle;next;ok;attrs;⎕IO;FindFirstFileX;FindNextFileX;FindClose;FileTimeToLocalFileTime;FileTimeToSystemTime;GetLastError;isFile;filter;isFolder
    ⍝ path and pattern are related.
    ⍝ If there is no pattern (or pattern is empty)
    ⍝   If path ends with '/' or '\' then return information for the contents of the folder, otherwise, return information about the folder (or file) itself
    ⍝ If a non-empty pattern exists, it is used as a filter on the contents of path (path is treated as a folder name)
    ⍝ Examples:
    ⍝   List '/dir/foo'  ⍝ returns information about /dir/foo
    ⍝   List '/dir/foo/' ⍝ returns information about the contents of /dir/foo/
    ⍝   '*.dyalog' List '/dir/foo'  ⍝ returns information about the .dyalog files in /dir/foo/
    ⍝   List '/dir/foo/*.dyalog'    ⍝ also returns information about the .dyalog files in /dir/foo/
     
    ⍝ Information returned is:
    ⍝ [;0] Name [;1] Length [;2] LastAccessTime [;3] IsDirectory
    ⍝ taken from MiServer's Files-class, with minor changes for usage in DyalogBuild
      ⎕IO←0
      :If 0=⎕NC'pattern' ⋄ :OrIf pattern≡'' ⋄ pattern←''
      :Else ⋄ path,←(~path[(⍴path)-~⎕IO]∊'\/')/'/'
      :EndIf
      isFolder←'/\'∊⍨¯1↑path
      filter←''
      :If isFile←~0∊⍴pattern
          filter←isFolder↓'/',pattern
      :EndIf
     
      r←0 4⍴'' 0 0 0
     
      :Select APLVersion
      :Case '*nix'
          →(0∊⍴rslt←1 _SH'ls -al',isFolder↓'d --time-style=full-iso ',unixfix path,filter)⍴0
          rslt←↑rslt
          rslt←' ',('total '≡6⍴rslt)↓[0]rslt
          r←((1↑⍴rslt),4)⍴0
          z←∧⌿' '=rslt ⍝ entirely blank columns
          z←z∧10>+\z    ⍝ Do not split file names
          rslt←z⊂rslt
          r[;3]←'d'=(0⊃rslt)[;1]                 ⍝ IsDirectory
          r[;1]←(~r[;3])×1⊃⎕VFI,4⊃rslt ⍝ Size
          z←,(5⊃rslt),6⊃rslt ⋄ ((z∊'-:')/z)←' ' ⋄ z←((1↑⍴r),6)⍴1⊃⎕VFI z
          r[;2]←↓⌊z,1000×1|z[;5]                ⍝ Add msec to Timestamp
          r[;0]←{(⌽~∨\⌽⍵='/')/⍵}¨{(-+/∧\' '=⌽⍵)↓¨↓⍵}0 1↓8⊃rslt    ⍝ Name
     
      :Case 'Mac'
          →(0∊⍴rslt←1 _SH'stat -lt "%F %T %z" ',unixfix path,isFolder{0∊⍴⍵:⍺/'*' ⋄ ⍵}filter)⍴0
          r←((1↑⍴rslt),4)⍴0
          rslt←↑{⎕ML←3 ⋄ ⍵⊂⍨~{⍵∧9>+\⍵}' '=⍵}¨rslt
          r[;3]←'d'=0⊃¨rslt[;1]                         ⍝ IsDirectory
          r[;1]←(~r[;3])×1⊃¨⎕VFI¨rslt[;4]               ⍝ Size
          z←↑∊¨↓{w←⍵ ⋄ ((w∊'-:')/w)←' ' ⋄ 1⊃⎕VFI w}¨rslt[;5 6] ⍝
          r[;2]←↓z,0                                    ⍝ 0 msec for MacOS to Timestamp
          r[;0]←path∘{⍺((⍴⍺){⍵↓⍨⍺⍺×⍺≡⍺⍺⍴⍵})⍵}¨rslt[;8]  ⍝ Name
     
      :Case 'Win'
      ⍝ See DirX for explanations of results of _FindNextFile etc
          _FindDefine
          handle rslt←_FindFirstFile path,isFolder{0∊⍴⍵:⍺/'*' ⋄ ⍵}filter
          :If 0=handle
              :Return ⍝ ('ntdir error:',⍕rslt)⎕SIGNAL 102      ⍝ file not found
          :EndIf
          rslt←,⊂rslt
          :While 1=0⊃ok next←_FindNextFile handle
              rslt,←⊂next
          :EndWhile
          :If 0 18∨.≠ok next
              ('ntdir error:',⍕next)⎕SIGNAL 11   ⍝ DOMAIN
          :EndIf
          ok←FindClose handle
          →(0∊⍴rslt←↓[0]↑rslt)⍴0
          rslt←(⊂~(6⊃rslt)∊(,'.')'..')/¨rslt  ⍝ remove . and ..
          r←((1↑⍴0⊃rslt),4)⍴0
          (0⊃rslt)←⍉attrs←(32⍴2)⊤0⊃rslt    ⍝ Get attributes into bits
          r[;3]←(0⊃rslt)[;27]              ⍝ IsDirectory?
          r[;1]←0(2*32)⊥⍉↑4⊃rslt           ⍝ combine size elements
          r[;2]←_Filetime_to_TS¨3⊃rslt     ⍝ As ⎕TS vector
          r[;0]←(⊂{w←⍵ ⋄ ((w='\')/w)←'/' ⋄ w}isFolder⊃({(⌽∨\⌽⍵∊'/\')/⍵}path)path),¨6⊃rslt     ⍝ Name (prefixed with path, using / instead of \)
      :EndSelect
      r←r[⍋↑r[;0];]
    ∇

    ∇ rslt←_Filetime_to_TS filetime;⎕IO
      :If 1≠0⊃rslt←FileTimeToLocalFileTime filetime(⎕IO←0)
      :OrIf 1≠0⊃rslt←FileTimeToSystemTime(1⊃rslt)0
          rslt←0 0                   ⍝ if either call failed then zero the time elements
      :EndIf
      rslt←1 1 0 1 1 1 1 1/1⊃rslt    ⍝ remove day of week
    ∇

    ∇ _FindDefine;WIN32_FIND_DATA
      :If 0=⎕NC'FindFirstFileX'
          WIN32_FIND_DATA←'{I4 {I4 I4} {I4 I4} {I4 I4} {U4 U4} {I4 I4} T[260] T[14]}'
          'FindFirstFileX'⎕NA'I4 kernel32.C32|FindFirstFile* <0T >',WIN32_FIND_DATA
          'FindNextFileX'⎕NA'U4 kernel32.C32|FindNextFile* I4 >',WIN32_FIND_DATA
          ⎕NA'kernel32.C32|FindClose I4'
          ⎕NA'I4 kernel32.C32|FileTimeToLocalFileTime <{I4 I4} >{I4 I4}'
          ⎕NA'I4 kernel32.C32|FileTimeToSystemTime <{I4 I4} >{I2 I2 I2 I2 I2 I2 I2 I2}'
          ⎕NA'I4 kernel32.C32∣GetLastError'
      :EndIf
    ∇

    ∇ rslt←_FindFirstFile name;⎕IO
      rslt←FindFirstFileX name(⎕IO←0)
      :If ¯1=0⊃rslt                   ⍝ INVALID_HANDLE_VALUE
          rslt←0 GetLastError
      :Else
          (1 6⊃rslt)_FindTrim←0        ⍝ shorten the file name at the null delimiter
          (1 7⊃rslt)_FindTrim←0        ⍝ and for the alternate name
      :EndIf
    ∇

    ∇ rslt←_FindNextFile handle;⎕IO
      rslt←FindNextFileX handle(⎕IO←0)
      :If 1≠0⊃rslt
          rslt←0 GetLastError
      :Else
          (1 6⊃rslt)_FindTrim←0             ⍝ shorten the filename
          (1 7⊃rslt)_FindTrim←0             ⍝ shorten the alternate name
      :EndIf
    ∇

    ∇ name←name _FindTrim ignored;⎕IO
     ⍝ Truncates a character vector at the null delimiting byte.
     ⍝ The null is not included in the result.
      ⎕IO←0
      name↑⍨←name⍳⎕UCS 0
    ∇

    ∇ Chars←GetText name;nid;signature;nums;sz;b
     ⍝ Read ANSI or Unicode character file
      sz←⎕NSIZE nid←(unixfix name)⎕NTIE 0
      signature←⎕NREAD nid 83 3 0
      :If signature≡¯17 ¯69 ¯65 ⍝ UTF-8?
          nums←⎕NREAD nid 83 sz
          Chars←'UTF-8'⎕UCS 256|nums ⍝ Signed ints
      :ElseIf ∨/b←(2↑signature)∧.=2 2⍴¯1 ¯2 ¯2 ⍝ Unicode (UTF-16)
          Chars←{,⌽(2,⍨2÷⍨⍴⍵)⍴⍵}⍣(ltack/b)⎕NREAD nid 83 sz 2
          Chars←'UTF-16'⎕UCS(2*16)|163 ⎕DR Chars
      :Else ⍝ ANSI or UTF-8
          Chars←{11::⎕UCS ⍵ ⋄ 'UTF-8'⎕UCS ⍵}256|⎕NREAD nid 83 sz 0
      :EndIf
      ⎕NUNTIE nid
    ∇

    ∇ vtv←GetVTV name
     ⍝ Read ANSI or Unicode character file as vector of text vectors
      :Trap 0
          vtv←{1↓¨(v=n)⊂v←(n←⎕UCS 10),⍵}(GetText name)~⎕UCS 13
      :Else  ⍝  Classic V12/13 have problems with GetText of this file (as used in dVersion), so if everything failed, this is our last resort
          vtv←⎕SE.UnicodeFile.ReadNestedText name
      :EndTrap
    ∇

    ∇ f←unixfix f;slash;space
    ⍝ replaces Windows file separator \ with Unix file separator /
    ⍝ '\ ' is denotes an escaped space under Unix - so don't change those \
    ⍝ escape any spaces that remain
    ⍝ this approach is mindnumbingly simple and probably dangerous
    ⍝ which is why we call unixfix very cautiously
      :If (⊂APLVersion)∊'*nix' 'Mac'
    ⍝ fails on the unlikely (but possible to create on Windows) '\tmp\ myspace.txt'
          slash←'\'=f
          space←' '=f
          ((slash>1↓space,0)/f)←'/'
          ((space>¯1↓0,slash)/f)←⊂'\ '
          f←∊f
      :EndIf
    ∇

    ∇ {res}←{options}LoadCode file_target;target;file
    ⍝ loads code from scriptfile (NB: file points to one or more existing files, no pattern etc.)
    ⍝ Options defines SALT-Options
    ⍝ file_target: (filename )
      (file target)←file_target
      :If 0=⎕NC'options' ⋄ options←'' ⋄ :EndIf
      options←((0<≢options)⍴' '),options
      :If DyaVersion<15
          res←⎕SE.SALT.Load file,' -target=',target,options
          res ⎕SIGNAL(∨/'could not bring in'⍷res)/11
      :ElseIf DyaVersion<17
          res←⎕SE.SALT.Load file,' -target=',target,options
          res ⎕SIGNAL('***'≡3↑⍕res)/11
      :Else
          :If 0=⎕NC target ⋄ target←target ⎕NS'' ⋄ :EndIf
          ⍝:If 326≠⎕DR target ⋄ target←⍎target ⋄ :EndIf ⍝ make sure it's a ref!
          :Trap (~halt)/0
              ⍝res←2 target.⎕FIX¨(⊂'file://'),¨eis file
              ⍝ MK suggested 2⎕FIX - but some of the tests then failed - and I hesitate to add everything that SALT does to find files in its folders, so will continue to ]LOAD for the time being...
              res←⎕SE.SALT.Load file,' -target=',target,options
          :Else
              ('Error loading ',file,': ',∊⎕DM,¨⎕UCS 13)⎕SIGNAL 11
          :EndTrap
          {(⍵,⎕UCS 13)⎕SIGNAL('***'≡3↑' '~⍨⍕⍵)/11}¨⊆res
      :EndIf
    ∇

    ∇ r←data Put name
     ⍝ Write data to file
      r←{(⎕NUNTIE ⍵)rtack data ⎕NAPPEND(0 ⎕NRESIZE ⍵)(⎕DR data)}Nopen name
    ∇

    ∇ tn←Nopen name
      :Trap 0
          tn←name ⎕NCREATE 0
      :Else
          tn←name ⎕NTIE 0
      :EndTrap
    ∇

    ∇ R←{vers}∆TestClassic string;avu
⍝ ⎕AVU from Classic 12.1                                                                                                                                                                                            ↓↓↓↓                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ↓↓↓↓
      R←''
      avu←0 8 10 13 32 12 6 7 27 9 9014 619 37 39 9082 9077 95 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 1 2 175 46 9068 48 49 50 51 52 53 54 55 56 57 3 164 165 36 163 162 8710 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 4 5 253 183 127 9049 193 194 195 199 200 202 203 204 205 206 207 208 210 211 212 213 217 218 219 221 254 227 236 240 242 245 123 8364 125 8867 9015 168 192 196 197 198 9064 201 209 214 216 220 223 224 225 226 228 229 230 231 232 233 234 235 237 238 239 241 91 47 9023 92 9024 60 8804 61 8805 62 8800 8744 8743 45 43 247 215 63 8714 9076 126 8593 8595 9075 9675 42 8968 8970 8711 8728 40 8834 8835 8745 8746 8869 8868 124 59 44 9073 9074 9042 9035 9033 9021 8854 9055 9017 33 9045 9038 9067 9066 8801 8802 243 244 246 248 34 35 30 38 180 9496 9488 9484 9492 9532 9472 9500 9508 9524 9516 9474 64 249 250 251 94 252 96 8739 182 58 9079 191 161 8900 8592 8594 9053 41 93 31 160 167 9109 9054 9059
      :If 2=⎕NC'vers'
          :Select vers  ⍝ use new version
          :Case 12
              avu←0 8 10 13 32 12 6 7 27 9 9014 619 37 39 9082 9077 95 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 1 2 175 46 9068 48 49 50 51 52 53 54 55 56 57 3 164 165 36 163 162 8710 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 4 5 253 183 127 9049 193 194 195 199 200 202 203 204 205 206 207 208 210 211 212 213 217 218 219 221 254 227 236 240 242 245 123 8364 125 8867 9015 168 192 196 197 198 9064 201 209 214 216 220 223 224 225 226 228 229 230 231 232 233 234 235 237 238 239 241 91 47 9023 92 9024 60 8804 61 8805 62 8800 8744 8743 45 43 247 215 63 8714 9076 126 8593 8595 9075 9675 42 8968 8970 8711 8728 40 8834 8835 8745 8746 8869 8868 124 59 44 9073 9074 9042 9035 9033 9021 8854 9055 9017 33 9045 9038 9067 9066 8801 8802 243 244 246 248 34 35 30 38 8217 9496 9488 9484 9492 9532 9472 9500 9508 9524 9516 9474 64 249 250 251 94 252 8216 8739 182 58 9079 191 161 8900 8592 8594 9053 41 93 31 160 167 9109 9054 9059
          :Case 13     ⍝ ⎕AVU from 14.0 onwards (the only difference is rtack which was (can't show here) before )
              avu←0 8 10 13 32 12 6 7 27 9 9014 619 37 39 9082 9077 95 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 1 2 175 46 9068 48 49 50 51 52 53 54 55 56 57 3 8866 165 36 163 162 8710 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 4 5 253 183 127 9049 193 194 195 199 200 202 203 204 205 206 207 208 210 211 212 213 217 218 219 221 254 227 236 240 242 245 123 8364 125 8867 9015 168 192 196 197 198 9064 201 209 214 216 220 223 224 225 226 228 229 230 231 232 233 234 235 237 238 239 241 91 47 9023 92 9024 60 8804 61 8805 62 8800 8744 8743 45 43 247 215 63 8714 9076 126 8593 8595 9075 9675 42 8968 8970 8711 8728 40 8834 8835 8745 8746 8869 8868 124 59 44 9073 9074 9042 9035 9033 9021 8854 9055 9017 33 9045 9038 9067 9066 8801 8802 243 244 246 248 34 35 30 38 180 9496 9488 9484 9492 9532 9472 9500 9508 9524 9516 9474 64 249 250 251 94 252 96 8739 182 58 9079 191 161 8900 8592 8594 9053 41 93 31 160 167 9109 9054 9059
          :Case 14
              avu←0 8 10 13 32 12 6 7 27 9 9014 619 37 39 9082 9077 95 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 1 2 175 46 9068 48 49 50 51 52 53 54 55 56 57 3 8866 165 36 163 162 8710 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 4 5 253 183 127 9049 193 194 195 199 200 202 203 204 205 206 207 208 210 211 212 213 217 218 219 221 254 227 236 240 242 245 123 8364 125 8867 9015 168 192 196 197 198 9064 201 209 214 216 220 223 224 225 226 228 229 230 231 232 233 234 235 237 238 239 241 91 47 9023 92 9024 60 8804 61 8805 62 8800 8744 8743 45 43 247 215 63 8714 9076 126 8593 8595 9075 9675 42 8968 8970 8711 8728 40 8834 8835 8745 8746 8869 8868 124 59 44 9073 9074 9042 9035 9033 9021 8854 9055 9017 33 9045 9038 9067 9066 8801 8802 243 244 246 248 34 35 30 38 180 9496 9488 9484 9492 9532 9472 9500 9508 9524 9516 9474 64 249 250 251 94 252 96 8739 182 58 9079 191 161 8900 8592 8594 9053 41 93 31 160 167 9109 9054 9059
          :Else
              LogError'Unknow value for ClassicVersion, supported values are 12, 13, 14'
              →0
          :EndSelect
      :EndIf
      :If isChar string
          R←∪(~(⎕UCS,string)∊avu)/,string
      :EndIf
    ∇
    :endSection Compatibility

    :Section ADOC

    ∇ t←Describe
      t←1↓∊(⎕UCS 10),¨{⍵/⍨∧\(⊂'')≢¨⍵}Comments ⎕SRC ⎕THIS ⍝ first block of non-empty comment lines
    ∇

    ∇ (n v d)←Version;f;s;z
      :If DyaVersion≥16
          s←⎕SRC ⎕THIS                  ⍝ appearently this only works in V16+
      :Else
          :If z←9=⎕NC'SALT_Data'           ⍝ namespace has been loaded,,,
              :Trap 0
                  s←GetVTV SALT_Data.SourceFile
              :Else ⋄ z←0
              :EndTrap
          :EndIf
          :If ~z
              (n v d)←'DyalogBuild' '1.24' '2020-01-28'  ⍝ this happens during ]LOAD with Dyalog ≤ 15 or regular usage with v12! - it doesn't matter if this data isn't accurate (no harm during ]LOAD, need to find workaround for v12!)
              →0
          :EndIf
      :EndIf
      f←Words⊃s                     ⍝ split first line
      n←2⊃f                         ⍝ ns name
      v←'.0',⍨'V'~⍨⊃⌽f              ⍝ version number
      d←1↓∊'-',¨3↑Words⊃⌽Comments s ⍝ date
    ∇

    Words←{(' '≠⍵){⎕ML←3 ⋄ ⍺⊂⍵}⍵}
    Comments←{{1↓¨⍵/⍨∧\'⍝'=⊃∘{(∨\' '≠⍵)/⍵}¨⍵}1↓⍵}
    :EndSection ───────────────────────────────────────────────────────────────────────────────────

    :Section UTILS

    ∇ r←APLVersion
      :Select 3↑⊃'.'⎕WG'APLVersion'
      :CaseList 'Lin' 'AIX' 'Sol'
          r←'*nix'
      :Case 'Win'
          r←'Win'
      :Case 'Mac'
          r←'Mac'
      :Else
          ∘∘∘ ⍝ unknown version
      :EndSelect
    ∇

    ∇ r←isWin
      r←'Win'≡APLVersion
    ∇


    ∇ R←dVersion
      R←⍎{(∧\(2>+\⍵='.')∧⍵∊⎕D,'.')/⍵}2⊃Version       ⍝ max file version number that this can handle (fn instead of Constant because it would not ]LOAD with V12 otherwise... - ns not set up so ⎕SRC not working)
    ∇

    eis←{1=≡⍵:⊂⍵ ⋄ ⍵}                                ⍝ enclose if simple
    Split←{dlb¨1↓¨(1,⍵=⍺)⊂⍺,⍵}                       ⍝ Split ⍵ on ⍺, and remove leading blanks from each segment
    GetParam←{⍺←'' ⋄ (⌊/names⍳eis ⍵)⊃values,⊂⍺}      ⍝ Get value of parameter
    dlb←{(∨\' '≠⍵)/⍵}                                ⍝ delete leading blanks
    null←0                                           ⍝ UCMD switch not specified
    whiteout←{w←⍵ ⋄ ((w=⎕UCS 9)/w)←' ' ⋄ w}          ⍝ convert whitespace to space
    isChar ←{0 2∊⍨10|⎕DR ⍵}                          ⍝ determine if argument's datatype is character

      Ö←{ ⍝ ö over/depth (AB's suggested operator)
          ⍺←{⍵ ⋄ ⍺⍺}                 ⍝ monadic: pass-thorugh
          3=⎕NC'⍵⍵':(⍵⍵ ⍺)⍺⍺(⍵⍵ ⍵)   ⍝ fÖg: over
          2=⎕NC'⍺⍺':rtack ⍺((⍺⍺ ltack rtack)∇∇ ⍵⍵)⍵
          k←⌽3⍴⌽⍵⍵                   ⍝ r → r r r    q r → r q r    p q r → p q r
          n←k<0
          d←|≡¨3⍴⍵ ⍺ ⍵ ⍵
          (n/k)+←n/d
          3 4∊⍨⎕NC'⍺':⍺⍺{⍵⍵<|≡⍵:∇¨⍵ ⋄ ⍺⍺ ⍵}(⊃k)rtack ⍵ ⍝ called monadically
          b←1↓k<d
          ⍱/b:rtack ⍺ ⍺⍺ ⍵
          </b:rtack ⍺∘∇¨⍵
          >/b:∇∘⍵¨rtack ⍺
          ∧/b:rtack ⍺ ∇¨⍵
      }

    ∇ txt←ExpandEnvVars txt;p;z;i;nam;val
   ⍝ Look for $EnvVar and replace with actual value
   ⍝ naming convention: characters (any case) or "_" or digits (may not begin with a digit)
      z←txt∊'_',⎕D,⎕A,lc ⎕A
      :For p :In ⌽where(txt='$')∧1,⍨1↓txt∊'_',⎕A,lc ⎕A
          i←+/∧\p↓z
          i←i+' '=txt[p+i+1]  ⍝ consume the first (and only the first) space after the name
          nam←txt[p+⍳i]~' '
          val←2 ⎕NQ'.' 'GetEnvironment'nam
          txt←txt[⍳p-1],val,(p+i)↓txt
      :EndFor
    ∇



    ∇ w←WIN ⍝ running under Windows
      :Trap 6
          w←⎕SE.SALTUtils.WIN ⍝ ≥16.0
      :Else
          w←'Win'≡3↑⊃'.'⎕WG'APLVersion' ⍝ ≤15.0
      :EndTrap
    ∇

    ∇ r←∆CSV args;z;file;encoding;coltypes;num
    ⍝ Primitive ⎕CSV for pre-v16
    ⍝ No validation, no options
     
      :Trap 2 ⍝ Syntax Error if ⎕CSV not available
          r←⎕CSV args
      :Else
          (file encoding coltypes)←args
          z←1⊃qNGET file
          z←1↓¨↑{(','=⍵)⊂⍵}¨',',¨z
          :If 0≠⍴num←(2=coltypes)/⍳⍴coltypes
              z[;num]←{⊃2⊃⎕VFI ⍵}¨z[;num]
          :EndIf
          r←z
      :EndTrap
    ∇

    :EndSection ────────────────────────────────────────────────────────────────────────────────────

    :Section TEST "DSL" FUNCTIONS

    ∇ r←Test args;⎕TRAP;start;source;ns;files;f;z;fns;filter;verbose;LOGS;steps;setups;setup;DYALOG;WSFOLDER;suite;halt;m;v;sargs;ignored;type;TESTSOURCE;extension;repeat;run;quiet;setupok;trace;matches;t;orig;nl∆;LoggedErrors
      ⍝ run some tests from a namespace or a folder
      ⍝ switches: args.(filter setup teardown verbose)
   i←quiet←0  ⍝ Clear/Log needs these  
      Clear args.clear 

      ⍝ Not used here, but we define them test scripts that need to locate data:
      DYALOG←2 ⎕NQ'.' 'GetEnvironment' 'DYALOG'
      WSFOLDER←⊃qNPARTS ⎕WSID
     
      LoggedErrors←LOGS←''
      i←0  ⍝ just in case we're logging outside main loop
      (verbose filter halt quiet trace)←args.(verbose filter halt quiet trace)
      :If null≢repeat←args.repeat
          repeat←⊃2⊃⎕VFI repeat
      :EndIf
     
      :If halt ⋄ ⎕TRAP←0 'S' ⋄ :EndIf ⍝ Defeat UCMD trapping
     
      repeat←1⌈repeat
      
      :If 0∊⍴args.Arguments
      :AndIf 9≠#.⎕NC source←⊃args.Arguments←,⊂'Tests'
          r←'An argument is required - see ]dtest -? for more information.' ⋄ →0
      :ElseIf 9=#.⎕NC source←1⊃args.Arguments ⍝ It's a namespace
          ns←#⍎source
          TESTSOURCE←⊃1 qNPARTS''
      :Else                               ⍝ Not a namespace
          :If qNEXISTS f←source           ⍝ Argument is a file
          :OrIf qNEXISTS f←source,'.dyalogtest'
          :OrIf qNEXISTS f←WSFOLDER,source
          :OrIf qNEXISTS f←WSFOLDER,source,'.dyalogtest'
          :OrIf qNEXISTS f←WSFOLDER,'Tests/',source
          :OrIf qNEXISTS f←WSFOLDER,'Tests/',source,'.dyalogtest'
              (TESTSOURCE z extension)←qNPARTS f
              :If 2=type←GetFilesystemType f
                  :If '.dyalogtest'≡lc extension ⍝ That's a suite
                      :If null≡args.suite
                          args.suite←f
                      :EndIf
                      f←¯1↓TESTSOURCE ⋄ type←1 ⍝ Load contents of folder
                  :Else                          ⍝ Arg is a source file - load it
                      'ns'⎕NS''
                      files←(⊂f),{null≡⍵:'' ⋄ TESTSOURCE,⍵,'.dyalog'}¨args.(setup teardown)  ⍝ also load setup and teardown (if used)
                      :For f :In files~⊂''
                          :Trap (~halt)/0
                              LoadCode f(⍕ns)
                              :If verbose ⋄ 0 Log'load file ',f  ⋄ :EndIf
                          :Else
                              LogError⊃⎕DM
                          :EndTrap
                      :EndFor
                  :EndIf
              :EndIf
     
              :If 1=type
                  files←('*.dyalog'ListFiles f)[;1]
                  'ns'⎕NS''
                  :For f :In files
                      :Trap (~halt)/0
                          LoadCode f(⍕ns)
                      :Else
                          LogError⊃⎕DM
                      :EndTrap
                  :EndFor
                  :If verbose ⋄ 0 Log(⍕1↑⍴files),' files loaded from ',source ⋄ :EndIf
              :EndIf
          :Else
              LogTest'"',source,'" is neither a namespace nor a folder.'
              →FAIL ltack r←LOGS
          :EndIf
      :EndIf
     
      :If null≢suite←args.suite ⍝ Is a test suite defined?
          ⍝ Merge settings
          ignored←⍬
          sargs←LoadTestSuite suite
     
          :For v :In (sargs.⎕NL-2)∩args.⎕NL-2 ⍝ overlap?
              :If null≢args⍎v
                  ignored,←⊂v
              :EndIf
          :EndFor
          'args'⎕NS sargs ⍝ merge
          :If 0≠⍴ignored
              0 Log'*** warning - modifiers overwritten by test suite contents: ',,⍕ignored
          :EndIf
      :EndIf
     
    ⍝ Establish test DSL in the namespace
      :If halt=0 ⋄ ns.Check←≢
      :Else
          'ns'⎕NS'Check'
      :EndIf
      'ns'⎕NS'Because' 'Fail' 'IsNotElement'
      ns.Log←{⍺←{⍵} ⋄ ⍺ ##.LogTest ⍵}  ⍝ a←rtack could cause problems with classic...
     
      :If args.tests≢0
          orig←fns←(','Split args.tests)~⊂''args.tests
          nl←ns.⎕NL ¯3
          :If DyaVersion≥13
              fns←{w←⍵ ⋄ ((w='?')/w)←'.' ⋄ ((w='*')/w)←⊂'.*' ⋄ ∊⍵}¨fns   ⍝ replace bare * wildcard with .* to and ? with . make it valid regex
              fns←1⌽¨'$^'∘,¨fns ⍝ note ^ is shift-6, not the APL function ∧
              t←1
              :If 0∊⍴matches←↑(fns ⎕S{⍵.(Block PatternNum)})ns.⎕NL ¯3
                  0 Log'*** function(s) not found: ',,⍕t/orig
                  fns←⍬
              :Else
                  :If ∨/t←~(⍳⍴fns)∊1+∪matches[;2]
                      0 Log'*** function(s) not found: ',,⍕t/orig
                  :EndIf
                  fns←∪matches[⍋matches[;2];1]
              :EndIf
          :Else
              fns←⍬
              :For f :In orig
                  nl∆←nl
                  :If 0<⍴s←where f='*' ⋄ nl∆←(s-1)↑¨nl∆ ⋄ f←(s-1)↑f ⋄ :EndIf
                  z←f='?' ⋄ nl∆←(⊂z){(+/⍺≠'?')>⍴⍵:'' ⋄ a←((⍴⍺)⌈⍴⍵)↑⍺ ⋄ (~a)/⍵}¨nl∆ ⋄ f←(~z)/f
                  fns,←(nl∆≡¨⊂f)/nl
              :EndFor
          :EndIf
      :Else ⍝ No functions selected - run all named test_*
          fns←{⍵⌿⍨(⊂'test_')≡¨5↑¨⍵}ns.⎕NL-3
      :EndIf
     
      :If null≢filter
      :AndIf 0∊⍴fns←(1∊¨filter∘⍷¨fns)/fns
          0 Log'*** no functions match filter "',filter,'"'
          →FAIL ltack r←LOGS
      :EndIf
     
      :If null≢setups←args.setup
          setups←' 'Split args.setup
      :EndIf
      r←LOGS
     
      :For run :In ⍳repeat
          :If verbose∧repeat≠0
              0 Log'run #',(⍕run),' of ',⍕repeat
          :EndIf
          :For setup :In setups
              steps←0
              start←⎕AI[3]
              LOGS←''
              :If verbose∧1<⍴,setups ⋄ r,←⊂'For setup = ',setup ⋄ :EndIf
              :If ~setupok←null≡f←setup
                  :If 3=ns.⎕NC f ⍝ function is there
                      :If verbose ⋄ 0 Log'running setup: ',f ⋄ :EndIf
                      f LogTest z←(ns⍎f)⍬
                      setupok←0=1↑⍴z
                  :Else ⋄ LogTest'-setup function not found: ',f
                      ∘∘∘
                  :EndIf
              :EndIf
     
              →setupok↓END
     
              :If verbose
                  0 Log'running ',(⍕1↑⍴fns),' tests'↓⍨¯1×1=↑⍴fns
              :EndIf
              :For f :In fns
                  steps+←1
                  :If verbose ⋄ 0 Log'running: ',f ⋄ :EndIf
                  (trace/1)ns.⎕STOP f
                  :Trap (~halt∨trace)/0 777
                      f LogTest(ns⍎f)⍬
                  :Case 777 ⍝ Assertion failed
                      f LogTest'Assertion failed: ',⊃⎕DM
                  :Else
                      f LogTest⊃⎕DM
                  :EndTrap
     
              :EndFor
     
              :If null≢f←args.teardown
                  :If 3=ns.⎕NC f ⍝ function is there
                      :If verbose ⋄ 0 Log'running teardown: ',f ⋄ :EndIf
                      f LogTest(ns⍎f)⍬
                  :Else ⋄ LogTest'-teardown function not found: ',f
                  :EndIf
              :EndIf
     
     END:
              :If 0∊⍴LOGS
                  r,←(quiet≡null)/⊂'   ',((1≠1↑⍴setups)/setup,': '),(⍕steps),' test',((1≠steps)/'s'),' passed in ',(1⍕0.001×⎕AI[3]-start),'s'
              :Else
                  r,←(⊂'Errors encountered',(setup≢null)/' with setup "',setup,'":'),'   '∘,¨LOGS
              :EndIf
          :EndFor ⍝ Setup
      :EndFor ⍝ repeat
     
     FAIL:
      r←table r
    ∇

    ∇ msg Fail value
      msg ⎕SIGNAL(1∊value)/777
    ∇

    ∇ r←expect Check got
      :If r←expect≢got
          ⎕←'expect≢got:'
          :if 200≥⎕size'expect'⋄⎕←'expect=',,expect⋄:endif 
          :if 200≥⎕size'got'⋄⎕←'got<0',,got ⋄ :endif
          ⍝ ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃(1⊃⎕RSI).⎕NR 2⊃⎕SI
          ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃⎕THIS.⎕NR 2⊃⎕SI
          ⍝:If ##.halt ⋄ ∘∘∘ ⋄ :EndIf
          (1+⊃⎕LC)⎕STOP 1⊃⎕SI ⍝ stop in next line
      :EndIf
    ∇

    ∇ line←line Because msg
     ⍝ set global "r", return branch label
      r←(2⊃⎕SI),'[',(⍕2⊃⎕LC),']: ',msg
    ∇

∇ z←A IsNotElement B
:if z←~A{a←⍺⋄1<≢a:^/(⊂a)∊⍵⋄3+^/a∊⍵}B
:andif ##.halt
⎕←'A IsNotElement B!'
:if 200≥⎕size 'A'⋄⎕←'A=',,A  ⋄:endif
:if 200≥⎕size 'B'⋄⎕←'B=',,B  ⋄:endif
          ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃⎕THIS.⎕NR 2⊃⎕SI
          (1+⊃⎕LC)⎕STOP 1⊃⎕SI ⍝ stop in next line
      :EndIf
∇

    ∇ args←LoadTestSuite suite;setups;lines;i;cmd;params;names;values;tmp;f
     
      args←⎕NS''
     
      :If qNEXISTS suite
          lines←⊃qNGET suite
      :Else
          r←,⊂'Test suite "',suite,'" not found.' ⋄ →0
      :EndIf
     
      args.tests←⍬
     
      :For i :In ⍳⍴lines
          :If ':'∊i⊃lines ⍝ Ignore blank lines
          :AndIf '⍝'≠1↑i⊃lines
              (cmd params)←':'Split whiteout i⊃lines
              (names values)←↓[1]↑¯2↑¨(⊂⊂''),¨'='Split¨','Split params
              cmd←lc cmd~' ' ⋄ names←lc names
     
              :If (i=1)∧'dyalogtest'≢cmd
                  'First line of file must define DyalogTest version'⎕SIGNAL 11
              :EndIf
     
              :Select cmd
              :Case 'dyalogtest'
                  :If dVersion≥_version←GetNumParam'version' ''
                      :If verbose
                          0 Log'DyalogTest version ',⍕_version
                          Log'Processing Test Suite "',suite,'"'
                      :EndIf
                  :Else
                      ('This version of ]',Ûcmd,' only supports Dyalog Test file format v',(⍕dVersion),' and lower')⎕SIGNAL 2
                  :EndIf
     
              :Case 'setup'
                  args.setup←GetParam'fn' ''
                  args.setup←{1↓¯1↓⍵/⍨~'  '⍷⍵}' ',args.setup,' '
     
              :Case 'test'
                  :If 0=⎕NC'args.tests' ⋄ args.tests←⍬ ⋄ :EndIf
                  args.tests,←',',GetParam'fn' ''
     
              :Case 'teardown'
                  args.teardown←GetParam'fn' '' ⍝ function is there
     
              :CaseList 'id' 'description'
                  :If verbose ⋄ Log cmd,': ',GetParam'' ⋄ :EndIf
              :Else
                  Log'Invalid keyword: ',cmd
              :EndSelect
          :EndIf
      :EndFor
     
      args.tests↓⍨←1  ⍝ drop off leading comma
    ∇

    :EndSection ────────────────────────────────────────────────────────────────────────────────────

    :Section BUILD

    ∇ r←Build args;file;prod;path;lines;extn;name;exists;extension;i;cmd;params;values;names;_description;_id;_version;id;v;target;source;wild;options;z;tmp;types;start;_defaults;f;files;n;quiet;save;ts;LoggedErrors;tmpPath;chars;nums;fileType;targetNames;targetName;fileContent;fileData;tmpExt;eol;halt;off;logfile;LoggedMessages;TestClassic;production;ClassicVersion
    ⍝ Process a .dyalogbuild file
     
      start←⎕AI[3]
      extension←'.dyalogbuild' ⍝ default extension
     
      LoggedErrors←0⍴⊂''
     
      i←0 ⍝ we are on "line zero" if any logging happens
     
      :If 0∊⍴args.Arguments
          args.Arguments←,⊂file←FindBuildFile ⎕WSID
          args.clear←1 ⍝ Rebuilding workspace
      :AndIf 0∊⍴file
          'Build file not named and no default found'⎕SIGNAL 22
      :EndIf
     
      file←1⊃args.Arguments
      (prod quiet save halt TestClassic off)←args.(production quiet save halt TestClassic off) ⍝ save must be 0, ⎕SAVE does not work from a UCMD
      (off TestClassic prod)←{2⊃⎕VFI⍕⍵}¨off TestClassic prod  ⍝ these get passed as char (but could also be numeric in case we're being called directly. So better be paranoid and ensure that we have a number)
     
      halt←~halt  ⍝ invert it, so that we can use it directly for :trap halt/
      Clear args.clear
     
      (exists file)←OpenFile file
      (path name extn)←qNPARTS file
     
      ('File not found: ',file)⎕SIGNAL exists↓22
     
      lines←1⊃qNGET file
     
      _version←0
      _id←''
      _description←''
      _defaults←'⎕ML←⎕IO←1'
     
      :For i :In ⍳⍴lines
          :If ~':'∊i⊃lines ⋄ :Continue ⋄ :EndIf ⍝ Ignore blank lines
          (cmd params)←':'Split whiteout i⊃lines
          params←ExpandEnvVars params
          (names values)←↓[1]↑¯2↑¨(⊂⊂''),¨'='Split¨','Split params
          cmd←lc cmd~' ' ⋄ names←lc names
          :If (i=1)∧'dyalogbuild'≢cmd
              'First line of file must define DyalogBuild version'⎕SIGNAL 11
          :EndIf
     
          :Select cmd
          :Case 'dyalogbuild'
              :If dVersion≥_version←GetNumParam'version' ''
                  0 Log'DyalogBuild version ',⍕dVersion
                  Log'Processing "',file,'" (written for version ≥ ',(⍕_version),')'
              :Else
                  ('This version of ]',Ûcmd,' only supports Dyalog Test file format v',(⍕dVersion),' and lower')
              :EndIf
     
          :Case 'id'
              id←GetParam'id' ''
              v←GetNumParam'version'
              Log'Building ',id,(v≠0)/' version ',⍕v
     
          :Case 'description'
              ⍝ no action
     
          :Case 'copy'
              wild←'*'∊source←GetParam'file' ''
              target←GetParam'target'
     
              :If qNEXISTS path,target
                  :For f :In files←'*'ListFiles path,target
                      qNDELETE f
                  :EndFor
              :Else
                  2 qMKDIR path,target ⍝ /// needs error trapping
              :EndIf
     
              :If 0∊⍴files←source ListFiles path
                  LogError'No files found to copy in ":',path,source,'"'
              :Else
                  :For f :In files
                      cmd←((1+WIN)⊃'cp' 'copy'),' "',f,'" "',path,target,'/"'
                      ((WIN∧cmd∊'/')/cmd)←'\'
                      {}⎕CMD cmd
                  :EndFor
              :EndIf
              :If (n←⍴files)≠tmp←⍴'*'ListFiles path,target,'/'
                  LogError(⍕n),' expected, but ',(⍕tmp),' files ended up in "',target,'"'
              :Else
                  Log(⍕n),' file',((n≠1)/'s'),' copied from "',source,'" to "',target,'"'
              :EndIf
     
          :Case 'run'
              LogError'run is under development'
              :Continue
     
              tmp←GetParam'file' ''
              (exists tmp)←OpenFile tmp
              :If ~exists ⋄ LogError'unable to find file ',tmp ⋄ :Continue ⋄ :EndIf
     
          :CaseList 'ns' 'class' 'csv' 'apl' 'lib' 'data'
              target←'#'GetParam'target'
              target←(('#'≠⊃target)/'#.'),target
              :If 0∊⍴source←GetParam'source' ''
                  'Source is required'Signal 11
              :EndIf
     
              :If (cmd≡'ns')∧0=⎕NC target
                  target ⎕NS''
                  :Trap (~halt)/0
                      target⍎_defaults
                       ⍝ Log'Created namespace ',target
                  :Else
                      :If DyaVersion<13
                          LogError'Error establishing defaults in namespace ',target,': ',⊃⎕DM
                      :Else
                          LogError'Error establishing defaults in namespace ',target,': ',⊃⎕DMX.DM
                      :EndIf
                  :EndTrap
              :EndIf
     
              :If cmd≡'csv'
                  types←2⊃⎕VFI GetParam'coltypes'
                  :If ~0=tmp←#.⎕NC target
                      LogError'Not a free variable name: ',target,', current name class = ',⍕tmp ⋄ :Continue
                  :EndIf
                  :Trap halt/999
                      tmp←∆CSV(path,source)'',(0≠⍴types)/⊂types
                      ⍎target,'←tmp'
                      Log target,' defined from CSV file "',source,'"'
                  :Else
                      :If DyaVersion<13
                          LogError⊃⎕DM
                      :Else
                          LogError⊃⎕DMX.DM
                      :EndIf
                  :EndTrap
                  :Continue
              :EndIf
     
              wild←'*'∊source
              options←((wild∧DyaVersion>14)/' -protect'),(prod/' -nolink'),(' -source'/⍨cmd≡'data')  ⍝ protect started with Dyalog 14 (or was it 13?)
              :If DyaVersion<13
                  tmpPath←path{cmd≡'lib':⍵ ⋄ ⍵[1,⍴⍵]≡'[]':⍵ ⋄ ⍺,⍵}source
              :Else
                  tmpPath←path{cmd≡'lib':⍵ ⋄ ⍵,⍨⍺/⍨0∊⍴('^\[.*\]'⎕S 3)⍵}source
              :EndIf
              :Trap halt/11
                  ⍝z←⎕SE.SALT.Load tmp←tmpPath,((~0∊⍴target)/' -target=',target),options
                  z←options LoadCode tmpPath target
              :Else
                  LogError⊃⎕DM
                  :Continue
              :EndTrap
     
              :If cmd≡'data'
                  target ⎕NS''
                  fileType←lc'charvecs'GetParam'format'
                  :If 'charvec'≡fileType
                      chars←'cr' 'lf' 'nel' 'vt' 'ff' 'ls' 'ps'
                      nums←'13' '10' '133' '11' '12' '8232' '8233'
                      :If DyaVersion<13
                          tmp←lc'lf'GetParam'seteol'
                          z←chars⍳⊂tmp
                          :If z≤⍴chars ⋄ eol←⎕UCS z⊃nums
                          :Else ⋄ eol←⎕UCS 2⊃⎕VFI z⊃chars
                          :EndIf
                      :Else
                          eol←⎕UCS⍎¨(chars,nums)⎕S(,⍨nums)rtack lc'lf'GetParam'seteol'
                      :EndIf
                  :EndIf
                  tmpExt←3⊃qNPARTS tmpPath
                  tmpExt,⍨←'='/⍨0≠⍴tmpExt
                  targetNames←2⊃¨qNPARTS,eis(⎕SE.SALT.List tmpPath,' -extension',tmpExt,' -raw')[;2]
                  :For targetName fileContent :InEach targetNames(,⊂⍣(2=≡z)rtack z)
                      :Select fileType
                      :Case 'charvec'
                          fileData←(-⍴eol)↓∊fileContent,¨⊂eol
                      :Case 'charmat'
                          fileData←↑fileContent
                      :Case 'json'
                          fileData←0 ⎕JSON∊fileContent
                      :Case 'charvecs'
                          fileData←fileContent
                      :EndSelect
                      targetName(⍎target).{⍎⍺,'←⍵'}fileData
                  :EndFor
                  z←targetNames
                  fileType,←' '
              :Else
                  fileType←''
              :EndIf
     
              :If 0∊⍴z     ⍝ no names
                  LogError'Nothing found: ',tmp
              :ElseIf (,1)≡,⍴z ⍝ exactly one name
                  Log{(uc 1↑⍵),1↓⍵}fileType,cmd,' ',source,' loaded as ',⊃z
              :Else        ⍝ many names
                  Log(⍕⍴,z),' ',fileType,('namesfiles'↑⍨5×¯1*cmd≡'file'),' loaded from ',source,' into ',target
              :EndIf
     
          :CaseList 'lx' 'exec' 'prod' 'defaults'
              :If 0∊⍴tmp←GetParam'expression' ''
                  LogError'expression missing'
              :Else
                  tmp←params ⍝ MBaas: use entire segment after ":" as argument (so that : and , can be used in these APL-Expressions!)
                  :If cmd≡'lx'
                      #.⎕LX←tmp
                      Log'Latent Expression set'
                  :ElseIf prod∨cmd≢'prod' ⍝ only execute PROD command if -production specified
                      :Trap halt/0 ⋄ #⍎tmp
                      :Else
                          :If DyaVersion<13
                              LogError⊃⎕DM
                          :Else
                              LogError⊃⎕DMX.DM
                          :EndIf
                      :EndTrap
                      :If cmd≡'defaults' ⋄ _defaults←tmp ⋄ Log'Set defaults ',tmp ⋄ :EndIf ⍝ Store for use each time a NS is created
                  :EndIf
              :EndIf
     
          :Case 'target'
              :If 0∊⍴tmp←GetParam'wsid' ''
                  LogError'wsid missing'
              :Else
                  ⎕WSID←∊1 qNPARTS path,tmp
                  Log'WSID set to ',⎕WSID
              :EndIf
              save←0
              :If 99≠tmp←'99'GetNumParam'save'  ⍝ can be set as an option in build-file
              :OrIf 1⊃tmp←⎕VFI⍕args.save          ⍝ or a switch when calling UCMD (which actually override the setting from the buildfile)
                  save←(,1)≡,2⊃tmp
              :EndIf
              :If off=2 ⋄ off←1=GetNumParam'off' 0 ⋄ :EndIf ⍝ only process this one if the modifier was not provided (and therefore has its default-value of 2)
          :Else
              :If '⍝'≠⊃cmd ⍝ ignore commented lines
                  LogError'Invalid keyword: ',cmd
              :EndIf
          :EndSelect
     
      :EndFor
     
      :If prod ⋄ ⎕EX'#.SALT_Var_Data' ⋄ :EndIf
     
      :If TestClassic>0
          z←TestClassic{
              2=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic⍎⍵
              3=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic ⎕CR ⍵
              ∇¨(⊂⍵,'.'),¨(⍎⍵).⎕NL-2.1 3.1 9.1
          }¨(⊂'#.'),¨#.⎕NL-2.1 3.1 3.2 9.1
          :If 0<⍴z
              LogError('Classic-Test found incompatible characters in following functions/variables:',⎕UCS 13 10),¯2↓∊z{('- ',⍺,⍵)/⍨×≢⍺}Ö 1 rtack(⎕UCS 13 10)
          :Else
              Log'Workspace seems to be compatible with Classic Edition ',⍕{⍵>1:⍵ ⋄ 12}TestClassic
          :EndIf
      :EndIf
      n←≢LoggedErrors
      :If save≢0
          :If 0=n
              :If save≡1 ⋄ save←⎕WSID ⋄ :EndIf
              :Trap 0 ⍝ yes, all trap have a halt/ after them - this one doesn't and shouldn't.
                  0 #.⎕SAVE save ⍝→ Mantis 18008
                  :Trap 0  ⍝ paranoid, but want to avoid any bugs here to trigger the save again...
                      tmp←⍕{0::0 ⋄ (ListFiles ⍵)[1;2]}save
                      Log'Saved as ',save,' (',tmp,' bytes)'
                  :EndTrap
              :Else
                  Log'Cant 0 ⎕SAVE ws because:'
                  Log ⎕DM
                  qNDELETE ⎕WSID  ⍝ avoid prompts during )SAVE
                  {sink←2 ⎕NQ'⎕SE' 'keypress'⍵}¨')SAVE',⊂'ER'
                  Log'Enqueued keypresses to save upon exit'
              :EndTrap
          :Else
              LogError'DBuild found errors during process, workspace will not be saved!'
          :EndIf
      :EndIf
     
      :If quiet∧0=n ⋄ r←0 0⍴0
      :Else
          r←'DyalogBuild: ',(⍕⍴lines),' lines processed in ',(1⍕0.001×⎕AI[3]-start),' seconds.'
          r,←(0≠n)/' ',(⍕n),' errors encountered.'
          LoggedMessages,←⊂r
      :EndIf
     
      :If off
          logfile←∊(2↑qNPARTS file),'.log'
          qNDELETE logfile
          (∊LoggedMessages,¨⊂⎕UCS 13 10)Put logfile
          ⍝⎕OFF 13×~0∊⍴,LoggedErrors  ⍝ requires DyaVers ≥ 14.0
          {sink←2 ⎕NQ'⎕SE' 'keypress'⍵}¨')OFF',⊂'ER'  ⍝ as long as 17479 isn't fixed (and for all older versions) we can't use ⎕OFF but have to ⎕NQ'KeyPress'
       :elseif 2=⎕SE.⎕nc'DBuild_postSave'
          ⍎⎕←⎕se.DBuild_postSave
      :EndIf  ⍝ we exit with 1 if there were errors, 0 if everything's fine.
    ∇

    ∇ r←FindBuildFile path;found;file;ext
      r←''
      :Repeat
          path←(-(¯1↑path)∊'/\')↓path ⍝ drop trailing / or \
          (path file ext)←qNPARTS path
      :Until found←qNEXISTS r←path,file,'/',file,'.dyalogbuild'
      :OrIf 1≥+/r∊'/\'
      r←found/r
    ∇

    ∇ (exists file)←OpenFile file;tmp;path;extn;name
      (path name extn)←qNPARTS file
      :If exists←qNEXISTS file
          :If 1=GetFilesystemType file   ⍝ but it is a folder!
              :If exists←qNEXISTS tmp←file,'/',name,extension ⍝ If folder contains name.dyalogbuild
                  file←tmp ⍝ Then use the file instead
              :ElseIf 1=⍴tmp←(ListFiles(⊃1 qNPARTS file),'*',extension)[;1] ⍝ if there's only a single .dyalogbuild file, use it
                  exists←qNEXISTS file←⊃tmp
              :ElseIf 1<⍴tmp
                  LogError'There is more than one ',(extension),' file in ',file,'. Please specify a single file.'
              :EndIf
          :EndIf
      :Else
          exists←qNEXISTS file←file,(0∊⍴extn)/extension
      :EndIf
    ∇

    ∇ Clear clear;tmp;n
      →(clear≡0)⍴0
      :If (clear≡1)∨0∊⍴,clear ⋄ #.(⎕EX ⎕NL⍳9) ⋄ Log'workspace cleared'
      :ElseIf ∧/1⊃tmp←⎕VFI clear
          n←#.⎕NL 2⊃tmp
          #.⎕EX n ⋄ Log'Expunged ',(⍕⍴n),' names of class ',clear
      :Else
          LogError'invalid argument to clear, should be empty or a numeric list of name classes to expunge'
      :EndIf
    ∇

    LineNo←{'[',(,'ZI3'⎕FMT ⍵),']'}

    ∇ {r}←{f}LogTest msg
      r←0 0⍴0
      →(0=⍴∊msg)⍴0
      :If 2=⎕NC'f' ⋄ msg←(f,': ')∘,¨eis msg ⋄ :EndIf
      :If verbose ⋄ ⎕←msg ⋄ :EndIf
      LOGS,←eis msg
      :If 0=⎕NC'LoggedMessages' ⋄ LoggedMessages←'' ⋄ :EndIf
      LoggedMessages,←eis msg
    ∇

    ∇ {pre}Log msg
      →quiet⍴0
      :If 0=⎕NC'pre' ⋄ :OrIf pre=1 ⋄ msg←' ',(LineNo i),' ',msg ⋄ :EndIf
      :If 0=⎕NC'LoggedMessages' ⋄ LoggedMessages←'' ⋄ :EndIf
      ⎕←msg
      LoggedMessages,←⊂msg
    ∇

    ∇ dm Signal en
     ⍝ subroutine of Build: uses globals i and file
      (dm,' in line ',(LineNo i),' of file ',file)⎕SIGNAL 2
    ∇

    ∇ {r}←LogError msg
     ⍝ subroutine of Build: uses globals i and file
      r←' *****  ',msg
      Log r
      LoggedErrors,←⊂r
    ∇

    :EndSection

    :Section UCMD

    ∇ r←List
      r←⎕NS¨2⍴⊂''
      r.Group←⊂'DEVOPS'
      r.Name←'DBuild' 'DTest'
      r.Desc←'Run one or more DyalogBuild script files (.dyalogbuild)' 'Run (a selection of) functions named test_* from a namespace, file or directory'
      r.Parse←'1S -production -quiet -halt -save=0 1 -off=0 1:2 -clear[=] -TestClassic' '1S -clear[=] -tests= -filter= -setup= -teardown= -suite= -verbose -quiet -halt -trace -repeat='
    ∇

    ∇ Û←Run(Ûcmd Ûargs)
     ⍝ Run a build
      :Select Ûcmd
      :Case 'DBuild'
          Û←Build Ûargs
      :Case 'DTest'
          Û←Test Ûargs
      :EndSelect
    ∇

    ∇ r←level Help Cmd;d
      :Select Cmd
      :Case 'DBuild'
          r←⊂'Run one or more DyalogBuild script files (.dyalogbuild)'
          r,←⊂'    ]',Cmd,' <files> [-clear[=NCs]] [-production] [-quiet] [-halt] [-save=0|1] [-off=0|1] [-TestClassic'
          :If level=0
              r,←⊂']',Cmd,' -?? ⍝ for more information'
          :EndIf
          :If level=1
              r,←'' 'Argument is:'
              r,←⊂'    files         name of one or more .dyalogbuild files'
              r,←'' 'Optional modifiers are:'
              r,←⊂'    -clear[=NCs]              expunge all objects, optionally of specified name classes only'
              r,←⊂'    -production               remove links to source files'
              r,←⊂'    -quiet                    only output actual errors'
              r,←⊂'    -halt                     halt on error rather than log and continue'
              r,←⊂'    -save=0|1                 save the build workspace (overwrites TARGET''s save-option). NB: we only save if no errors were logged during Build-process!'
              r,←⊂'    -off=0|1                  )OFF after completion (if errors were logged, logfile will be created)'
              r,←⊂'    -TestClassic              check imported code for compatibility with classic editions (charset, not language-features!)'
              r,←⊂''
              r,←⊂']',Cmd,' -??? ⍝ for description of the DyalogBuild script format'
          :EndIf
          :If level≥2
              r,←⊂''
              r,←⊂'each non-empty line of a DyalogBuild script has the following syntax:'
              r,←⊂'INSTRUCTION : argument, Parameter1=value1, Parameter2=value2,...'
              r,←⊂'              Everything after INSTRUCTION: may reference environment-variables using syntax $EnvVar.'
              r,←⊂'              You can continue with any non-alphabetic chars immediately following the name of the var, otherwise leave a blank.'
              r,←⊂'              ie: "$Foo\Goo" => "C:\TEMP\Goo", "$Git MyDir" => "c:\git\MyDir", "$Git  MyDir" => "c:\git\ MyDir"'
              r,←⊂''
              r,←⊂'INSTRUCTION may be one of the following:'
              r,←⊂'  DYALOGBUILD : nnn'
              r,←⊂'    This instruction must be included and be the first one. "nnn" specifies the minimum version required to run this script.'
              r,←⊂'  ID : name[, Version=nnn]'
              r,←⊂'    This instruction is purely informational and causes a log entry of "Building name" or "Building name version nnn" where "nnn" is a number.'
              r,←⊂'  COPY : path1, Target=path2'
              r,←⊂'    Copies one or more files from path1 to path2.'
              r,←⊂'  NS : pathname[, Target=namespace]'
              r,←⊂'    Loads the APL object(s) defined in the file(s) matching the pattern "pathname" into "namespace" (default is #), establishing the namespace if it does not exist.'
              r,←⊂'  {CLASS|APL} : pathname[, Target=namespace]'
              r,←⊂'    Loads the APL object defined in "pathname" into "namespace" (default is #).'
              r,←⊂'  LIB : name[, Target=namespace]'
              r,←⊂'    Loads the library utility "name" into "namespace" (default is #).'
              r,←⊂'  CSV : pathname, Target=matname[, ColTypes=spec]'
              r,←⊂'    Loads the CSV file "pathname" as a matrix called "matname". "spec" corresponds to the third element of ⎕CSV''s right argument; for details, see ',⎕SE.UCMD'Help ⎕CSV -url'
              r,←⊂'  DATA : pathname, Target=namespace[, Format=type[, SetEOL=nl]]'
              r,←⊂'    Loads the contents of the file(s) matching the pattern "pathname" into one or more variables in "namespace" (default is #). The variable(s) will be named with the base filename(s). "type" dictates how the file content of each file is interpreted, and may be one of:'
              r,←⊂'      charvec   meaning as a simple character vector. If SetEOL=nl is specified, the lines will be separated by the chosen line ending sequence; one or more of the leftmost character codes or the corresponding decimal numbers of:'
              r,←⊂'                  LF   Line Feed            ⎕UCS 10    (the default)'
              r,←⊂'                  VT   Vertical Tab         ⎕UCS 11'
              r,←⊂'                  FF   Form Feed            ⎕UCS 12'
              r,←⊂'                  CR   Carriage Return      ⎕UCS 13'
              r,←⊂'                  NEL  New Line             ⎕UCS 133'
              r,←⊂'                  LS   Line Separator       ⎕UCS 8282'
              r,←⊂'                  PS   Paragraph Separator  ⎕UCS 8233'
              r,←⊂'      charvecs  meaning as a vector of character vectors'
              r,←⊂'      charmat   meaning as a character matrix'
              r,←⊂'      json      meaning as json. The variable will be a numeric scalar, a vector, or a namespace in accordance with the JSON code in the file.'
              r,←⊂'  LX : expression'
              r,←⊂'    Sets the workspace''s ⎕LX to "expression".'
              r,←⊂'  EXEC : expression'
              r,←⊂'    Executes the APL expression "expression".'
              r,←⊂'  PROD : expression'
              r,←⊂'    Executes the APL expression "expression" only if ]',Cmd,' was called with the -production modifier'
              r,←⊂'  DEFAULTS : "expression"'
              r,←⊂'    Executes the APL expression "expression" in each namespace created or accessed by the NS instruction.'
              r,←⊂'  TARGET : wsname.dws'
              r,←⊂'    Sets the WSID to "wsname.dws" so the workspace is ready to )SAVE.'
              r,←⊂'    Supports optional parameters:'
              r,←⊂'    save=0|1 (Default 0): save the workspace after a successfull (=no errors were logged) build'
              r,←⊂'    off=0|1  (Default=0): )OFF after completion of Build. If errors were logged, a logfile (same name as the .dyalogbuiöd-file with .log-extension)'
              r,←⊂'                          will be created and exit code 1 will be set.'
          :EndIf
     
      :Case 'DTest'
          r←⊂'Run (a selection of) functions named test_* from a namespace, file or directory'
          r,←⊂'    ]',Cmd,' {<ns>|<file>|<path>} [-halt] [-filter=string] [-quiet] [-repeat=n] [-setup=fn] [-suite=file] [-teardown=fn] [-trace] [-verbose] [-clear[=n]]'
          :If level>0
              r,←'' 'Argument is one of:'
              r,←⊂'    ns              namespace in the current workspace'
              r,←⊂'    file            .dyalog file containing a namespace'
              r,←⊂'    path            path to directory containing functions in .dyalog files'
              r,←'' 'Optional modifiers are:'
              r,←'     -clear[=n]      clear ws before running tests (optionally delete nameclass n only)'
              r,←⊂'    -tests=         comma-separated list of tests to run'
              r,←⊂'    -halt           halt on error rather than log and continue'
              r,←⊂'    -filter=string  only run functions where string is found in the leading ⍝Test: comment'
              r,←⊂'    -quiet          qa mode: only output actual errors'
              r,←⊂'    -repeat=n       repeat test n times'
              r,←⊂'    -setup=fn       run the function fn before any tests'
              r,←⊂'    -suite=file     run tests defined by a .dyalogtest file'
              r,←⊂'    -teardown=fn    run the function fn after all tests'
              r,←⊂'    -trace          set stop on line 1 of each test function'
              r,←⊂'    -verbose        display more status messages while running'
          :Else
              r,←⊂']',Cmd,' -?? ⍝ for more info'
          :EndIf
      :EndSelect
    ∇






    :EndSection ────────────────────────────────────────────────────────────────────────────────────
:Endnamespace ⍝ DyalogBuild  $Revision$