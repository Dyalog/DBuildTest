:Namespace DyalogBuild ⍝ V 1.62
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
⍝ 2020 01 21 MBaas: mostly backward-compatible with v12 (need to sort out ⎕R/⎕S,@)
⍝ 2020 01 22 MBaas: compatibility with Classic
⍝ 2020 01 23 MBaas: took care of ⎕R,⎕S,@
⍝ 2020 01 24 MBaas: DBuild: added switch -halt for "halt on error" as in DTest; fixed bugs found while testing under v12
⍝ 2020 01 27 MBaas: DBuild: target: wsid, save=1, off=1 (and switch -save=1 to override settings from file);]DBuild: added -TestClassic
⍝ 2020 01 28 MBaas: DBuild: -TestClassic=version;bug fixes;doco
⍝ 2020 01 29 MBaas: DBuild: $EnvVar
⍝ 2020 03 23 MBaas: made TestClassic is a simple switch w/o values assigned; fixes dealing with -halt in -save in DBuild;various minor fixes
⍝ 2020 04 03 MBaas: added -clear to DTest to make sure that the ws is ⎕CLEARed before executing tests (simplifies repeated testing)
⍝ 2020 04 06 MBaas: ]DBuild 1.25 executes the content of secret variable ⎕SE.DBuild_postSave after saving the ws
⍝ 2020 04 15 MBaas: ]DTest {file} now loads ALL fn present in folder of {file}, but only execute the test specified in file. (So test may use utils w/o bothering about loading them)
⍝ 2020 04 21 MBaas: ]DTest - timestamp (adds ⎕TS to log-messages)
⍝ 2020 04 23 MBaas: ]DTest: renamed -timestamp to -ts; added -timeout
⍝ 2020 04 29 MBaas: ]DTest -order=0|1|"NumVec". Default is random order when executing tests and setups. If tests fail, order will be accessible in *.rng.txt-files!
⍝ 2020 05 19 MBaas: colon in arguments of the instructions (i.e. LX/EXEC/PROD/DEFAULTS with pathnames) caused trouble. Fixed.
⍝ 2020 05 20 MBaas: variables with platform-info; typos fixed (in Help);]DBuild only creates logfile (with -off) if it found errors
⍝ 2020 07 01 MBaas: ]DTest -init; fixed bugs when ]DBuild used -save-Modifier
⍝ 2020 07 23 MBaas: v1.30 ]DTest -off;lots of small fixes & enhancements - see commit-msg for details
⍝ 2020 07 24 MBaas: some fixes for compatibility with old Dyalog-Versions
⍝ 2020 08 05 AWS: Avoid calling ⎕USING if on AIX or using a classic interpreter - avoids extraneous errors on status window stream
⍝ 2020 08 21 MBaas: v1.31 ]DTest accepts any # of arguments (can be useful for selection of Tests as in DUI-QAs)
⍝ 2021 02 04 MBaas: v1.4 ]DBuild deals with ]LINKed files;fixed various bugs in Build & Test
⍝ 2021 01 10 Adam: v1.32 defer getting .NET Version until needed
⍝ 2021 01 20 MBaas: v1.33 moved assignments into dedicated Init-fn to avoid running them when UCMD is loaded
⍝ 2021 03 16 MBaas: v1.41 merging of various minor changes, mostly TACIT-related
⍝ 2021 03 23 MBaas: v1.43 fixes: Classic compatibility, relative paths for tests & suites
⍝ 2021 03 30 MBaas: v1.44 fixes: more Classic compatibility - missed a few things with 1.43, but now it should be done.
⍝ 2021 04 22 MBaas: v1.45: improved loading of code (from .dyalog + .apln,.aplc,.aplf,.apli,.aplo);various fixes & cleanups
⍝ 2021 04 30 MBaas: v1.46 has a better workaround for saving (no need to go into the session);-save=0 can overwrite the option set with TARGET
⍝ 2021 05 19 MBaas: v1.50 special handling of WS FULL in DTest and DBuild; allows specifying TARGET with .exe or .dll extension;handle multiple TARGET-Entries per file
⍝ 2021 06 02 MBaas: v1.51: v1.50 did not report ALL errors
⍝ 2021 06 24 MBaas: v1.52: minor details
⍝ 2021 07 26 MBaas: v1.53: fixed VALUE ERROR in ]DBuild
⍝ 2021 07 29 MBaas: v1.60: added switch to -coco to ]DTest to enable testing of Code Coverage (requires version ≥18.0)
⍝ 2021 09 01 MBaas: v1.61: DTest -off=2 to create .log-file for failed tests, but not ⎕OFF (useful when called by other fns, as CITA does)
⍝                          -testlog also create {basename}.session.log ALWAYS (success or failure) with the entire session output of executing the test, launching a test shows current version of DyalogBuild
⍝                          DTest: -trace switch will also trace into setup-fns, not only tests.
⍝                          Help for DBuild or DTest will also show version number
⍝ 2021 12 17 MBaas, v1.62: new internal variable (available to tests): _isCITA - is set to 1 if running under control of CITA (Continous Integration Tool for APL)
⍝                   v1.62: streamlined logging and creation of logfiles (reporting errors and optionally info and warnings, too)
⍝                   v1.62: it is also possible to get test results in a .json file (see loglvl): this file also has performance stats and collects various memory-related data


    DEBUG←⎕se.SALTUtils.DEBUG ⍝ used for testing to disable error traps  ⍝ BTW, m19091 for that being ⎕se even after Edit > Reformat.
    :Section Compatibility
    ⎕IO←1
    ⎕ML←1


    ∇ R←GetDOTNETVersion;vers;⎕IO;⎕USING
⍝ R[1] = 0/1/2: 0=nothing, 1=.net Framework, 2=NET CORE
⍝ R[2] = Version (text-vector)
⍝ R[3] = Version (identifiable x.y within [2] in numerical form)
⍝ R[4] = Textual description of the framework
      ⎕IO←1
      R←0 '' 0 ''
      :If (82=⎕DR' ')∨'AIX'≡3↑⊃'.'⎕WG'APLVersion'
          ⍝ calls on ⎕USING generate output which is not wanted on AIX or classic interpreters.  On Windows or Unicode
          ⍝ .NET Core may not be installed, so the output is valid. ⎕USING may generate trappable errors in future
          ⍝ rendering this redundant.
          →0
      :EndIf
      :Trap 0
          ⎕USING←'System' ''
          vers←System.Environment.Version
          R[2]←⊂⍕vers
          R[3]←vers.(Major+0.1×Minor)
          :If 4=⌊R[3]   ⍝ a 4 indicates .net Framework!
              R[1]←1
              :If (⍕vers)≡'4.0.30319.42000'   ⍝ .NET 4.6 and higher!
                  R[4]←⊂Runtime.InteropServices.RuntimeInformation.FrameworkDescription
              :ElseIf (10↑⍕vers)≡'4.0.30319.' ⍝ .NET 4, 4.5, 4.5.1, 4.5.2
                  R[4]←⊂'.NET Framework ',2⊃R
              :EndIf
          :ElseIf 3.1=R[3]  ⍝ .NET CORE
          :OrIf 4<R[3]
              R[1]←2
              ⎕USING←'System,System.Runtime.InteropServices.RuntimeInformation'
              R[4]←⊂Runtime.InteropServices.RuntimeInformation.FrameworkDescription
          :EndIf
      :Else
      ⍝ bad luck, go with the defaults
      :EndTrap
    ∇

    ∇ {R}←GetTools4CITA args;names
      :Access public
    ⍝ args primarily intended for internal use (giving the ns in which to setup DSL)
    ⍝ sets up ns "⎕se._cita' and define some tools for writing tests in it
    ⍝ a few essential ⎕N-Covers and the tools for CITA to write a log and a status-file
      Init 2
      :If 0=⎕SE.⎕NC'_cita'
          names←'SetupCompatibilityFns' 'DyaVersion' 'APLVersion' 'isChar' 'Split' 'Init' 'GetDOTNETVersion'
          names,←'qNPARTS' 'qMKDIR' 'qNEXISTS' 'qNDELETE' '_Filetime_to_TS' 'Nopen'
          names,←'isWin' 'isChar' 'GetCurrentDirectory' 'unixfix' ⍝ needed by these tools etc.
          names,←'swise' 'refs'   ⍝ useful to deal with WS FULL
          :If DyaVersion≤15
              names,←'ListPre15' 'GetVTV' 'Put' '_FindDefine' '_FindFirstFile' '_FindNextFile' '_FindTrim' 'GetText'
          :Else
              names,←⊂'ListPost15'
          :EndIf
          '⎕se._cita'⎕NS names
          _cita.('⎕se._cita'⎕NS ⎕NL-3)
      :EndIf
      ⎕SE._cita.Init 2
      :If args≡''
          args←'#'
      :EndIf
      :Trap DEBUG↓0
          args ⎕NS'Because' 'Fail' 'Check' 'IsNotElement' 'eis'
      :EndTrap
      :If ⎕SE._cita.DyaVersion≥15
          ⎕RL←⍬ 2  ⍝ CompCheck: ignore
      :EndIf
      ⎕SE._cita.randomstring←(⎕A,⎕D)[?32⍴36]
     
      R←⎕SE._cita.randomstring,'⍝     ───  Loaded tools into namespace ⎕se._cita ─── (WA=',(,'CI15'⎕FMT ⎕WA),' bytes) ───'
    ∇

    ∇ {sink}←SetupCompatibilityFns
      sink←⍬   ⍝ need dummy result here, otherwise getting VALUE ERROR when ⎕FX'ing namespace
      eis←{1=≡⍵:⊂⍵ ⋄ ⍵}                         ⍝ enclose if simple (can't use left-shoe underbar because of classic compatibility )
     
      :If 13≤DyaVersion
      :AndIf ~_isClassic
          table←⍎⎕UCS 9066
          ltack←⍎⎕UCS 8867
          rtack←⍎⎕UCS 8866
          GetNumParam←{⍺←ltack ⋄ ⊃2⊃⎕VFI ⍺ GetParam ⍵}    ⍝ Get numeric parameter (0 if not set)
      :Else
          table←{r←(⍴⍵),(1≥⍴⍴⍵)/1 ⋄ r←r[1],×/1↓⍴⍵ ⋄ r⍴⍵}
          ltack←{⍺}
          rtack←{⍵}
          GetNumParam←{⍺←'0' ⋄ ⊃2⊃⎕VFI ⍺ GetParam ⍵}    ⍝ Get numeric parameter (0 if not set)
      :EndIf
     
      :If 14≤DyaVersion
          tally←≢    ⍝ CompCheck: ignore
      :Else
          tally←{⍬⍴1,⍨⍴⍵}
      :EndIf
     
      :If 15≤DyaVersion
          GetFilesystemType←{⊃1 ⎕NINFO ⍵} ⍝ 1=Directory, 2=Regular file  ⍝ CompCheck: ignore
          ListFiles←{⍺←'' ⋄ ⍺ ListPost15 ⍵}
          qNGET←{⎕NGET ⍵ 1}   ⍝ CompCheck: ignore
          ⍝qNPUT←{(⊂⍺)⎕NPUT ⍵}    ⍝ CompCheck: ignore
          qNPUT←{
             ⍝ 0::∘∘∘,⎕←(⎕JSON ⎕DMX),⎕trap←0'S'
              (~0∊⍴⍺)∧3≠≡⍺:(⊂∊(eis,⍺),¨⊂NL)⎕NPUT ⍵             ⍝ CompCheck: ignore
              (eis,⍺)⎕NPUT ⍵             ⍝ CompCheck: ignore
          }
      :Else
          ListFiles←{⍺←'' ⋄ ⍺ ListPre15 ⍵}
          GetFilesystemType←{2-(ListFiles{(-∨/'\/'=¯1↑⍵)↓⍵}⍵)[1;4]}
          ⍝ we only emulate ⎕NGET {filename} 1
          qNGET←{⍝ return nested content, so that 1⊃qNGET is ≡ 1⊃⎕NGET (no other elements used here!)
              ,⊂GetVTV ⍵
          }
          qNPUT←{⍝ extra-complicated to at least handle overwrite (no append yet)
              (,1)≡2⊃(eis ⍵),0:(⍺ Put⊃eis ⍵)ltack(qNDELETE⊃⍵)
              ⍺ Put⊃eis ⍵
          }
      :EndIf
     
      :If 16≤DyaVersion
      :AndIf ~_isClassic
          where←⍎⎕UCS 9080
      :Else
          where←{(,⍵)/,⍳⍴⍵}
      :EndIf
     
      :If 16≤DyaVersion
          qJSONi←qJSONe←⎕JSON                          ⍝ CompCheck: ignore
      :ElseIf 14.1≤DyaVersion
          qJSONi←{0(7159⌶)⍵} ⍝ CompCheck: ignore
          qJSONe←{(7160⌶)⍵} ⍝ CompCheck: ignore
      :Else
          qJSONi←qJSONe←{'This functionality not available in versions < 14.1'⎕SIGNAL 11}
      :EndIf
      :If 18≤DyaVersion
          lc←¯1∘⎕C                                             ⍝ lower case ⍝ CompCheck: ignore
          uc←1∘⎕C                                              ⍝ upper case ⍝ CompCheck: ignore
      :ElseIf 15≤DyaVersion
          lc←819⌶                                     ⍝ lower case ⍝ CompCheck: ignore
          uc←1∘(819⌶)                                 ⍝ upper case ⍝ CompCheck: ignore
      :Else
          lowerAlphabet←'abcdefghijklmnopqrstuvwxyzáâãçèêëìíîïðòóôõùúûýàäåæéñöøü'
          upperAlphabet←'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÂÃÇÈÊËÌÍÎÏÐÒÓÔÕÙÚÛÝÀÄÅÆÉÑÖØÜ'
          fromto←{1<|≡⍵:(⊂⍺)∇¨⍵ ⋄ n←⍴1⊃(t f)←⍺ ⋄ ~∨/b←n≥i←f⍳s←,⍵:s ⋄ (b/s)←t[b/i] ⋄ (⍴⍵)⍴s} ⍝ from-to casing fn
          lc←lowerAlphabet upperAlphabet∘fromto ⍝ :Includable Lower-casification of simple array
          uc←upperAlphabet lowerAlphabet∘fromto ⍝ Ditto Upper-casification
      :EndIf
    ∇

    ∇ r←{normalize}qNPARTS filename;filesep;mask;path;file;ext;cd;i;pth
          ⍝ splits a filename into: path name ext
      :If 0=⎕NC'normalize'
          normalize←0
      :EndIf
      :If 15≤DyaVersion
          r←normalize ⎕NPARTS filename ⍝ CompCheck: ignore
      :Else
          filesep←(~isWin)↓'\/'
          mask←⌽∨\⌽filename∊filesep
          path←mask/filename
          ((path∊filesep)/path)←'/'
          file←(~mask)/filename
          :If normalize
              cd←GetCurrentDirectory,'/' ⋄ pth←path ⋄ path←''
              ((cd∊filesep)/cd)←'/'
              :If 0∊⍴pth
                  path←cd
              :Else
                  :While 0<⍴pth
                      :If './'≡2↑pth
                          path←cd{0∊⍴⍵:⍺ ⋄ ⍵}path
                          pth←2↓pth
                      :ElseIf '../'≡3↑pth
                          path←{(2≤⌽+\⌽⍵∊filesep)/⍵}cd{0∊⍴⍵:⍺ ⋄ ⍵}path
                          pth←3↓pth
                      :Else
                          i←⍬⍴where pth∊filesep
                          path←path,i↑pth
                          pth←i↓pth
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



    ∇ r←{quietly}_SH cmd
      :Access public shared
      quietly←{6::⍵ ⋄ quietly}0
      :If quietly
          cmd←cmd,' </dev/null 2>&1'
      :EndIf
      r←{0::'' ⋄ ⎕SH ⍵}cmd
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
              ⎕MKDIR path ⍝ CompCheck: ignore
          :Else
              larg ⎕MKDIR path ⍝ CompCheck: ignore
          :EndIf
      :EndIf
    ∇


    ∇ R←qNEXISTS FileOrDir
      :If DyaVersion≤15
      :OrIf (DyaVersion≤17)∧∨/'*?'∊FileOrDir
          :Trap DEBUG↓R←0
              R←0<1↑⍴ListFiles FileOrDir
          :EndTrap
      :ElseIf ∨/'*?'∊FileOrDir
          R←(⎕NEXISTS ⎕OPT'Wildcard' 1)FileOrDir ⍝ CompCheck: ignore
      :Else
          R←⎕NEXISTS FileOrDir ⍝ CompCheck: ignore
      :EndIf
    ∇

    ∇ {sink}←{wild}qNDELETE name;DeleteFileX;GetLastError;FindFirstFile;FindNextFile;FindClose;handle;rslt;ok;next;⎕IO;path
    ⍝ not entirely compatible, uses ⍺ to emulate variant 'Wildcard'1
      sink←⍬
      :If 0=⎕NC'wild'
          wild←0
      :EndIf
      :If wild∧DyaVersion<17
      :OrIf DyaVersion≤15
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
                  :AndIf 2≠GetLastError
                      11 ⎕SIGNAL⍨'DeleteFile error:',⍕GetLastError
                  :EndIf
              :EndIf
          :EndSelect
      :ElseIf wild
          1(⎕NDELETE ⎕OPT 1)name   ⍝ CompCheck: ignore
      :Else
          1 ⎕NDELETE name   ⍝ CompCheck: ignore
      :EndIf
    ∇



    ∇ r←{pattern}ListPost15 path
      :If 0=⎕NC'pattern'
      :OrIf pattern≡''
          pattern←''
      :Else
          path,←(~path[tally path]∊'\/')/'/'
      :EndIf
      r←⍉↑0 2 9 1(⎕NINFO ⎕OPT 1)(path,pattern) ⍝ CompCheck: ignore
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
      :If 0=⎕NC'pattern'
      :OrIf pattern≡''
          pattern←''
      :Else
          path,←(~path[(⍴path)-~⎕IO]∊'\/')/'/'
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

    ∇ {names}←{options}LoadCode file_target;target;file;whatWeHave;f1;f2;f3;fl;fls;sep;sf
    ⍝ loads code from scriptfile (NB: file points to one existing file, no pattern etc.)
    ⍝ Options defines SALT-Options
    ⍝ file_target: (filename )
    ⍝ res: nested vector of names that were defined
      names←0⍴⊂''
      →(0=tally file_target)/0  ⍝ gracefully treatment of empty calls
      (file target)←file_target
      :If 0=⎕NC'options'
          options←''
      :EndIf
      :If target≢''
      :AndIf 0=⎕NC target
          target ⎕NS''
      :EndIf
      options←' ',options
     
      (f1 f2 f3)←qNPARTS file
      ⍝ filenames may contain wildcards - which isn't so useable with Link.Import.
      ⍝ So we resolve them and work through the list, processing every file as good as we can
      ⍝ but List may not be the right tool to do that because it does not give us a filename with extension - so we can't recognize -.apla!
      ⍝ OTOH, a default DIR-Lister would not searcch the SALT-Libraries etc.
     
      ⍝ search the specified file in the source-folder and SALT's workdir  (emulate SALT.Load here)
      sep←'∘',(1+isWin)⊃':' ';'     ⍝ separator for those paths...
     
      :For sf :In (⊂f1),sep Split ⎕SE.SALT.Settings'workdir'
          :If ~(⊃⌽sf)∊'\/'
              sf,←⎕SE.SALT.FS
          :EndIf
          :If 0<⍬⍴⍴fls←(ListFiles sf,f2,f3)[;1]
              :For fl :In fls
                  :If (⊂lc 3⊃qNPARTS fl)∊'.dyalog' '.aplc' '.aplf' '.apln' '.aplo' '.apli'
                      :Trap DEBUG↓0
                          res←⎕SE.SALT.Load fl,' -target=',target,options
                      :Else
                          res←'*** Error executing "⎕SE.SALT.Load ',fl,' -target=',target,options,'": ',NL
                          :If DyaVersion<13.1
                              res,←⍕⎕DM,¨⊂NL
                          :Else
                              res,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')   ⍝ CompCheck: ignore
                          :EndIf
                      :EndTrap
                      res ⎕SIGNAL('***'≡3↑⍕res)/11
                      names,←⊂res
                  :ElseIf (3⊃qNPARTS file)≡'.apla'
                      :If DyaVersion>17
                      :AndIf 9=⎕SE.⎕NC'Link'
                      :AndIf 3=⎕SE.Link.⎕NC'Import'
                          :Trap DEBUG↓0
                              {}⎕SE.Link.Import(⍎target)(fl)
                          :Else
                              res←'*** Error executing Link.Import (',target,') ',fl,':'
                              res,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')      ⍝ CompCheck: ignore
                              res ⎕SIGNAL 11
                          :EndTrap
                          names,←⊂{2 6::{2 6::⍵ ⋄ ⎕SE.Link.StripCaseCode 2⊃⎕NPARTS ⍵}⍵ ⋄ ⎕SE.Link.U.StripCaseCodePart ⍵}2⊃⎕NPARTS fl     ⍝ CompCheck: ignore
                      :Else
                          ('*** We need at least v17.1 with ]LINK to import ',fl)⎕SIGNAL 11
                      :EndIf
                  :EndIf
              :EndFor
          :EndIf
          :If ~0∊⍴names      ⍝ if we found any names
              :Leave            ⍝ do not bother searching SALT's workdirs!
          :EndIf
      :EndFor
    ∇

    ∇ {r}←data Put name
     ⍝ Write data to file. r=number of bytes written.
      :Select |≡data
      :CaseList 0 1
      :Case 2
          data←⊃data
      :Case 3
          data←∊(⊃data),¨⊂NL
      :Else
          ⎕SIGNAL 11
      :EndSelect
      data←'UTF-8'⎕UCS data   ⍝ get unsigned int so that we can write unicode
      data←¯128+256|128∘+data  ⍝ convert to signed int
      r←data{z←⍺ ⎕NAPPEND(0 ⎕NRESIZE ⍵)83 ⋄ ⎕NUNTIE ⍵ ⋄ z}Nopen name
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

    ⍝ useful for CITA or DTest when dealing with WS FULL (from dfns):
      refs←{                              ⍝ Vector of sub-space references for ⍵.
          ⍺←⍬ ⋄ (⍴,⍺)↓⍺{                  ⍝ default exclusion list.
              ⍵∊⍺:⍺                       ⍝ already been here: quit.
              ⍵.(↑∇∘⍎⍨/⌽(⊂⍺∪⍵),↓⎕NL 9)    ⍝ recursively traverse any sub-spaces.
          }⍵                              ⍝ for given starting ref.
      }

      swise←{         ⍝ Space wise
          ⍺⍺¨refs ⍵   ⍝ Apply to each space
      }


    :endSection Compatibility

    :Section ADOC

    ∇ t←Describe
      t←1↓∊(⎕UCS 10),¨{⍵/⍨∧\(⊂'')≢¨⍵}Comments ⎕SRC ⎕THIS ⍝ first block of non-empty comment lines   ⍝ CompCheck: ignore
    ∇

    ∇ (n v d)←Version;f;s;z
    ⍝ Version of DBuildTest (3 elems: name version date)
      :If DyaVersion≥16
          s←⎕SRC ⎕THIS                  ⍝ appearently this only works in V16+
      :Else
          :If z←9=⎕NC'SALT_Data'           ⍝ namespace has been loaded,,,
              :Trap DEBUG↓0
                  s←GetVTV SALT_Data.SourceFile
              :Else ⋄ z←0
              :EndTrap
          :EndIf
          :If ~z
              (n v d)←'DyalogBuild' '1.45' '2021-04-20'  ⍝ this happens during ]LOAD with Dyalog ≤ 15 or regular usage with v12! - it doesn't matter if this data isn't accurate (no harm during ]LOAD, need to find workaround for v12!)  ⍝ TODO: get version-#
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
      ⍝ numeric version (maj.min) of DBuildTest (for comparison against the min. version given in the Dyalogtest-element of a .dyalogtest)
      R←2⊃⎕VFI{(2>+\⍵='.')/⍵}2⊃Version
    ∇

    Split←{dlb¨1↓¨(1,⍵∊⍺)⊂(⊃⍺),⍵}                       ⍝ Split ⍵ on ⍺, and remove leading blanks from each segment
    SplitFirst←{dlb¨1↓¨(1,<\⍵=⍺)⊂⍺,⍵}                ⍝ Split ⍵ on first occurence of ⍺, and remove leading blanks from each segment
    GetParam←{⍺←'' ⋄ (⌊/names⍳eis ⍵)⊃values,⊂⍺}      ⍝ Get value of parameter
    dlb←{(∨\' '≠⍵)/⍵}                                ⍝ delete leading blanks
    dtb←{(-{⍵⊥⍵}⍵=' ')↓⍵}                            ⍝ delete trailing blanks (DB)
    null←0                                           ⍝ UCMD switch not specified
    whiteout←{w←⍵ ⋄ ((w=⎕UCS 9)/w)←' ' ⋄ w}          ⍝ convert whitespace to space
    isChar ←{0 2∊⍨10|⎕DR ⍵}                          ⍝ determine if argument's datatype is character
    _hasBitSet←{t←8⍴2 ⋄ 0<+/(t⊤⍺)∧t⊤⍵}                ⍝ deal with bit-flags (hardcoded maximum is 8)

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
          r←⎕CSV args  ⍝ CompCheck: ignore
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

    ⍝ from dfns:
      rmcm←{                          ⍝ APL source with comments removed.
          cm←∨\(⍵='⍝')>≠\⍵=''''       ⍝ mask of comments.
          ⎕UCS(cm×32)+(~cm)×⎕UCS ⍵    ⍝ blanks for comments in source matrix.
      }

    ∇ Init lvl;aplv1
        ⍝ Setup some names with information about the platform we're working on
      :If lvl≥0
          _Version←2⊃'.'⎕VFI 2⊃'.'⎕WG'APLVersion'
      ⍝ Version has all the details (major, minor, revision, *)
      ⍝ whereas DyaVersion is more readable with its simple numeric format
          DyaVersion←{2⊃⎕VFI(2>+\'.'=⍵)/⍵}2⊃'.'⎕WG'APLVersion'
      :EndIf
      :If lvl≥1
      :OrIf lvl=¯1
          _isClassic←Classic←82=⎕DR' '
          _is32bit←~_is64bit←∨/'64'⍷aplv1←1⊃'.'⎕WG'APLVersion'
          _OS←3↑aplv1  ⍝ 12.1 does not know it...
          (_isWin _isLinux _isAIX _isMacOS _isSolaris)←'Win' 'Lin' 'AIX' 'Mac' 'Sol'∊⊂3↑_OS
          _isCITA←~0∊⍴2 ⎕NQ'.' 'GetEnvironment' 'CITATest'
          _DotNet←1⊃GetDOTNETVersion
          NL←⎕UCS 10,⍨isWin/13
      :EndIf
      :If lvl≥2
          SetupCompatibilityFns ⍝ dedicated fn avoid unneccessary execution of that code when loading the UCMD
      :EndIf
    ∇

    :EndSection ────────────────────────────────────────────────────────────────────────────────────

    :Section TEST "DSL" FUNCTIONS

    ∇ r←Test args;TID;timeout;ai;nl
      ⍝ run some tests from a namespace or a folder
      ⍝ switches: args.(filter setup teardown verbose)
      ⍝ result "r" is build in XTest (excute test) as global "r" gets updated. Can't return explicit result in XTest because we're running it in a thread.
      Init 2
      i←quiet←0  ⍝ Clear/Log needs these
      Clear args.clear
     
      timeout←0 args.Switch'timeout'
      r←''
      :If timeout>0
          ai←⎕AI[3]+timeout×1000
          TID←XTest&args
          :While ⎕AI[3]<ai
          :AndIf TID∊⎕TNUMS
              ⎕DL 0.1  ⍝ wait a little bit...
          :EndWhile
          :If TID∊⎕TNUMS
              r,←⊂'*** Test aborted because thread was still running after timeout of ',(⍕timeout),' seconds'
              0 ⎕TKILL TID
          :EndIf
      :Else
          XTest args
      :EndIf
    ∇

    ∇ XTest args;⎕TRAP;start;source;ns;files;f;z;fns;filter;verbose;LOGS;LOGSi;steps;setups;setup;DYALOG;WSFOLDER;suite;halt;m;v;sargs;overwritten;type;TESTSOURCE;extension;repeat;run;quiet;setupok;trace;matches;t;orig;nl∆;LoggedErrors;i;start0;nl;templ;base;WSFULL;msg;en;off;order;ts;timestamp;home;CoCo;r1;r2;tie;tab;ThisTestID;ignore;loglvl;logBase;logFile;log
      i←quiet←0
      ⍝ Not used here, but we define them test scripts that need to locate data:
      DYALOG←2 ⎕NQ'.' 'GetEnvironment' 'DYALOG'
      WSFOLDER←⊃qNPARTS ⎕WSID
      ThisTestID←(,'ZI4,<->,ZI2,<->,ZI2,<->,ZI2,<:>,ZI2,<:>,ZI3'⎕FMT 1 6⍴⎕TS),' *** DTest ',2⊃Version
      ⎕←ThisTestID  ⍝ this MUST go into the session because it marks the start of this test (useful to capture session.log later!)
      LOGSi←LOGS←3⍴⊂''   ⍝ use distinct variables for initial logs and test logs
      i←0  ⍝ just in case we're logging outside main loop
      (verbose filter halt quiet trace timestamp order)←args.(verbose filter halt quiet trace ts order)
      repeat←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.repeat
      loglvl←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.loglvl
      off←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.off
      :If halt
          ⎕TRAP←0 'S'
      :EndIf ⍝ Defeat UCMD trapping
     
      repeat←1⌈repeat
      file←''
     
      :If 0∊⍴args.Arguments
      :AndIf 9≠#.⎕NC source←⊃args.Arguments←,⊂'Tests'
          r←'An argument is required - see ]dtest -? for more information.' ⋄ →0
      :ElseIf 9=#.⎕NC source←1⊃args.Arguments ⍝ It's a namespace
          ns←#⍎source
          {}(⍕ns.##)⎕NS'verbose' 'filter' 'halt' 'quiet' 'trace' 'timestamp' 'order' 'off'
          TESTSOURCE←⊃1 qNPARTS''
          base←source
      :Else                               ⍝ Not a namespace
          :If qNEXISTS f←source           ⍝ Argument is a file
          :OrIf qNEXISTS f←source,'.dyalogtest'
          :OrIf qNEXISTS f←WSFOLDER,source
          :OrIf qNEXISTS f←WSFOLDER,source,'.dyalogtest'
          :OrIf qNEXISTS f←WSFOLDER,'Tests/',source
          :OrIf qNEXISTS f←WSFOLDER,'Tests/',source,'.dyalogtest'
          :OrIf qNEXISTS f←∊1 qNPARTS source                     ⍝ deal with relative names for folders
          :OrIf qNEXISTS f←∊1 qNPARTS source,'.dyalogtest'       ⍝ or individual tests
              file←f  ⍝ assign this variable which is needed by LogError
              (TESTSOURCE z extension)←qNPARTS f
              base←z
              :If 2=type←GetFilesystemType f  ⍝ it's a file
                  :If '.dyalogtest'≡lc extension ⍝ That's a suite
                      :If null≡args.suite
                          args.suite←f
                      :EndIf
                      f←¯1↓TESTSOURCE ⋄ type←1 ⍝ Load contents of folder
                  :Else                          ⍝ Arg is a source file - load it
                      :If filter≢null
                          LogTest'Can''t run test with file-argument AND -filter-switch!'
                          →FAIL
                      :EndIf
                      'ns'⎕NS''
                      :Trap (DEBUG∨halt)↓0
                          filter←∊LoadCode source(⍕ns)
                          f←¯1↓TESTSOURCE ⋄ type←1 ⍝ Load contents of folder
                      :Else
                          msg←'Error loading test from folder "',source,'"',NL
                          :If DyaVersion<13.1
                              LogError msg,∊⎕DM,¨⊂NL
                          :Else
                              LogError msg,⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                          :EndIf
                          →endPrep1
                      :EndTrap
                  :EndIf
              :EndIf
     
              :If 1=type  ⍝ deal with directories in f
                  TESTSOURCE←f,(~'/\'∊⍨⊃⌽f)/⎕SE.SALTUtils.FS ⍝ use it accordingly! (and be sure it ends with dir-sep)
                  files←('*.dyalog'ListFiles f)[;1]
                  files,←('*.aplf'ListFiles f)[;1]    ⍝ .aplf-extension!
                  'ns'⎕NS''
                  :For f :In files
                      :Trap (DEBUG∨halt)↓0
                          LoadCode f(⍕ns)
                      :Else
                          msg←'Error loading code from file "',f,'"'
                          :If DyaVersion<13.1
                              LogError msg,∊⍕⎕DM,¨⊂NL
                          :Else
                              LogError msg,⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                          :EndIf
                      :EndTrap
                  :EndFor
                  ⍝:if null≡args.tests
                  ⍝ args.tests←ns.⎕nl¯3
                  ⍝ :endif
                  :If verbose
                      0 Log(⍕1↑⍴files),' file',('s'/⍨1<tally files),' loaded from ',source
                  :EndIf
                  :If null≡args.suite  ⍝ if no suite is given
                      :If null≡args.setup
                          v←('setup_'⍷↑nl)[;1]/nl←ns.⎕NL-3
                          :If ~0∊⍴v
                              args.setup←¯1↓∊v,¨' '
                              :If 2=GetFilesystemType f   ⍝ single file given
                                  Log'No -suite nor -setup selected - running test against all setups!'
                              :Else                       ⍝ directory
                                  Log'No -suite nor -setup selected - running all tests in "',f,'" against all setups!'
                              :EndIf
                          :EndIf
                          :If ~0∊⍴v←('teardown_'⍷↑nl)[;1]/nl←ns.⎕NL-3
                              args.teardown←¯1↓∊v,¨' '
                          :EndIf
     
                      :EndIf
                  :EndIf
              :EndIf
          :Else
              :If args.init   ⍝ can we init it?
              :AndIf ∧/0<∊⍴¨1↑¨(TESTSOURCE z extension)←qNPARTS source  ⍝ did user give a file-spec? then try to create it!
                  :If ~qNEXISTS TESTSOURCE   ⍝ does directory exist?
                      {}3 qMKDIR TESTSOURCE
                  :EndIf
                  :If '.dyalogtest'≡lc extension
                      templ←('DyalogTest : ',2⊃Version)'ID         :' 'Description:' '' 'Setup   :' 'Teardown:' '' 'Test:'
                  :Else
                      templ←('r←',z,' dummy;foo')'r←''''' ':If .. Check ..'('      →0 Because ''test failed'' ⋄ :EndIf')
                  :EndIf
                  (⊂templ)qNPUT source
                  Log'Initialised ',source
                  →0
              :EndIf
              LogTest'"',source,'" is neither a namespace nor a folder or a .dyalogtest-file.'
              →FAIL
          :EndIf
      :EndIf
     endPrep1:
     
      :If null≢suite←args.suite ⍝ Is a test suite defined?
          ⍝ Merge settings
          overwritten←⍬
          v←LoadTestSuite suite
          :If ~1⊃v
              LogError'*** error loading suite "',suite,'": ',2⊃v
          :Else
              sargs←2⊃v
              :For v :In (sargs.⎕NL-2)∩args.⎕NL-2 ⍝ overlap?
                  :If null≢args⍎v
                      overwritten,←⊂v
                      ⍎'sargs.',v,'←args.',v
                  :EndIf
              :EndFor
              'args'⎕NS sargs ⍝ merge
              :If 0≠⍴overwritten
                  0 Log'*** warning - test-suite overridden by modifiers: ',,⍕overwritten
              :EndIf
          :EndIf
      :EndIf
     
    ⍝ Establish test DSL in the namespace
      :If halt=0
      :AndIf DyaVersion≥14
          ns.Check←≢   ⍝ CompCheck: ignore
      :Else
          'ns'⎕NS'Check'
      :EndIf
      'ns'⎕NS'Because' 'Fail' 'IsNotElement' 'RandomVal' 'tally' 'eis'
      ns.Log←{⍺←{⍵} ⋄ ⍺ ##.LogTest ⍵}  ⍝ ⍺←rtack could cause problems with classic...
     
      :If args.tests≢0
          orig←fns←(','Split args.tests)~⊂''args.tests
          nl←ns.⎕NL ¯3
          :If DyaVersion≥13
              fns←{w←⍵ ⋄ ((w='?')/w)←'.' ⋄ ((w='*')/w)←⊂'.*' ⋄ ∊⍵}¨fns   ⍝ replace bare * wildcard with .* to and ? with . make it valid regex
              fns←1⌽¨'$^'∘,¨fns ⍝ note ^ is shift-6, not the APL function ∧
              t←1
              :If 0∊⍴matches←↑fns ⎕S{⍵.(Block PatternNum)}ns.⎕NL ¯3   ⍝ CompCheck: ignore
                  LogError'*** function(s) not found: ',,⍕t/orig
                  fns←⍬
              :Else
                  :If ∨/t←~(⍳⍴fns)∊1+∪matches[;2]
                      LogError'*** function(s) not found: ',,⍕t/orig
                  :EndIf
                  fns←∪matches[⍋matches[;2];1]
              :EndIf
          :Else
              fns←⍬
              :For f :In orig
                  nl∆←nl
                  s←where f='*'
                  :If ~0∊⍴s
                      nl∆←(s-1)↑¨nl∆
                      f←(s-1)↑f
                  :EndIf
                  z←f='?' ⋄ nl∆←(⊂z){(+/⍺≠'?')>⍴⍵:'' ⋄ a←((⍴⍺)⌈⍴⍵)↑⍺ ⋄ (~a)/⍵}¨nl∆ ⋄ f←(~z)/f
                  fns,←(nl∆≡¨⊂f)/nl
              :EndFor
          :EndIf
      :Else ⍝ No functions selected - run all named test_*
          fns←{⍵⌿⍨(⊂'test_')≡¨5↑¨⍵}ns.⎕NL-3
      :EndIf
      :If null≢filter
      :AndIf 0∊⍴fns←(1∊¨filter∘⍷¨fns)/fns
          LogError'*** no functions match filter "',filter,'"'
          →FAIL
      :EndIf
     
      :If null≢setups←args.setup
          setups←' 'Split args.setup
      :EndIf
     
      r←''
      start0←⎕AI[3]
      :Select ,order
      :Case ,0  ⍝ order=0: random (or reproduce random from file)
          order←(('order',⍕tally fns)RandomVal 2⍴tally fns)∩⍳tally fns
      :Case ,1
          order←⍳tally fns   ⍝ 1: sequential
      :Else
          order←order{(⍺∩⍵),⍵~⍺}⍳tally fns  ⍝ numvec: validate and use that order (but make sure every test gets executed!)
      :EndSelect
      LOGSi←LOGS
      :For run :In ⍳repeat
          WSFULL←0  ⍝ indicates if we were hit by WS FULL
          :If verbose∧repeat>1
              0 Log'run #',(⍕run),' of ',⍕repeat
          :EndIf
          :For setup :In (,setups)[('setups',⍕tally setups)RandomVal 2⍴tally setups]   ⍝ randomize order of setups
              steps←0
              start←⎕AI[3]
              LOGS←3⍴⊂''
              :If verbose
              :AndIf setup≢null
                  r,←⊂'For setup = ',setup
              :EndIf
              :If ~setupok←null≡f←setup
                  :If 3=ns.⎕NC f ⍝ function is there
                      :If verbose
                          0 Log'running setup: ',f
                      :EndIf
                      (trace/1)ns.⎕STOP f
                      :Trap halt↓0
                          f LogTest z←(ns⍎f)⍬
                          setupok←0=1↑⍴z
                      :Else
                          msg←'Error executing setup "',f,'": '
                          :If DyaVersion<13.1
                              msg,←NL,⍕⎕DM,¨⊂NL
                          :Else
                              msg,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                          :EndIf
                          LogError msg
                          setupok←0
                      :EndTrap
                  :Else
                      LogTest'-setup function not found: ',f
                      setupok←0
                  :EndIf
              :EndIf
     
              →setupok↓END
     
⍝ after setup, make sure to start CodeCoverage (if modifier is set) - once only...
              :If null≢args.coco  ⍝ if switch is set
              :AndIf (1↑1⊃⎕VFI⍕args.coco)∨1<tally args.coco  ⍝ and we have either numeric value for switch or a longer string
              :AndIf 0=⎕NC'CoCo'   ⍝ only neccessary if we don't have an instance yet...
                  :If 18≤+/1 0.1 0 0×2⊃'.'⎕VFI 2⊃'.'⎕WG'APLVersion'   ⍝ needs at least 18.0
                      home←1⊃⎕NPARTS SALT_Data.SourceFile  ⍝ CompCheck: ignore
                      LoadCode(home,'aplteam-CodeCoverage-0.9.1/CodeCoverage.aplc')(⍕⎕THIS)  ⍝ we should use some other to bring this in ideally...()
                      :If 0=≢subj←args.coco_subj
                          :If 0<≢subj←#.⎕NL ¯9
                              subj←∊(⊂'#.'),¨subj,¨','
                          :EndIf
                          subj,←⍕ns
                      :EndIf
                      CoCo←⎕NEW CodeCoverage(,⊂subj)
                      ⎕SE.Dyalog.Utils.disp ¯5↑⎕SE.Input
                      CoCo.Info←'Report created by DTest ',(2⊃Version),' which was called with these arguments: ',⊃¯2↑⎕SE.Input
                      :If 1<≢args.coco
                      :AndIf (⎕DR' ')=⎕DR args.coco
                          :If ∨/'\/'∊args.coco  ⍝ if the argument looks like a filename (superficial test)
                              CoCo.filename←args.coco
                          :Else                  ⍝ otherwise we assume it is the name of the instance of an already running coverag-analysis
                              CoCo.filename←(⍎args.coco).filename
                              CoCo.NoStop←1
                          :EndIf
                      :Else
                          CoCo.filename←(739⌶0),,'</CoCoDTest_>,ZI4,ZI2,ZI2,ZI2,ZI2,ZI3'⎕FMT 1 6⍴⎕TS
                      :EndIf
                      :If 0=≢ignore←args.coco_ignore
                          ⍝ignore←∊(⊂⍕⎕THIS),¨'.',¨(⎕THIS.⎕NL ¯3 4),¨','
                          ignore←∊{(⊂⍕⍵),¨'.',¨(⍵.⎕NL ¯3 4),¨','}⎕SE.input.c
                      :EndIf
                      ignore,←(((0<≢ignore)∧','≠¯1↑ignore)⍴','),¯1↓∊(⊂(⍕⎕THIS),'.ns.'),¨('Check' 'Because' 'Fail' 'IsNotElement' 'RandomVal' 'tally' 'eis' 'Log'),¨','
                      CoCo.ignore←ignore
                      CoCo.Start ⍬
                  :Else
                      ⎕←'Need at least v18.0 to use Code Coverage with ]DTest!'
                  :EndIf
              :EndIf
     
     
              :If verbose
              :AndIf 1<tally fns
                  0 Log'running ',(⍕1↑⍴fns),' tests'↓⍨¯1×1=↑⍴fns
              :EndIf
              :For f :In fns[order]
                  steps+←1
                  :If verbose
                      0 Log'running: ',f
                  :EndIf
                  (trace/1)ns.⎕STOP f
                  :Trap (~halt∨trace)/0 777
                      ⍝f LogTest(ns⍎f)⍬
                      LogTest(ns⍎f)⍬   ⍝ avoid additional line with title of fn
                  :Case 777 ⍝ Assertion failed
                      f LogTest'Assertion failed: ',,⍕⎕DM,¨⊂NL
                  :Else
                      en←⎕EN  ⍝ save error-no before it gets overwritten
                      msg←'Error executing test "',f,'": '
                      :If DyaVersion<13.1
                          msg,←,⍕⎕DM,¨⊂NL
                      :Else
                          msg,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂''),NL     ⍝ CompCheck: ignore
                          msg,←,⍕⎕DM,¨⊂NL
                          :If 18≤DyaVersion
                              msg,←(⎕JSON ⎕OPT'Compact' 0)⎕DMX            ⍝ CompCheck: ignore
                          :ElseIf 16≤DyaVersion
                              msg,←⎕JSON ⎕DMX            ⍝ CompCheck: ignore
                          :EndIf
                      :EndIf
                      :If WSFULL←en=1   ⍝ special handling for WS FULL
                          msg,←NL,'⎕WA=',(⍕⎕WA)
                          msg,←NL,'The 20 largets objects found in the workspace:',NL
                          :Trap 1
                              res←⊃⍪/{((⊂⍕⍵),¨'.',¨↓nl),[1.5]⍵.⎕SIZE nl←⍵.⎕NL⍳9}swise ns  ⍝ CompCheck: ignore
                              res←res[(20⌊1↑⍴res)↑⍒res[;2];]
                              msg←msg,∊((↑res[;1]),'CI18'⎕FMT res[;,2]),⊂NL
                          :Else
                              msg,←'Error while generating that report: ',NL,,↑⎕DM,⊂NL
                          :EndTrap
     
                      :EndIf
                      ⍝ LogError msg
                      f LogTest msg
                  :EndTrap
     
              :EndFor
     
              :If null≢f←args.teardown
                  :If 3=ns.⎕NC f ⍝ function is there
                      :If verbose
                          0 Log'running teardown: ',f
                      :EndIf
                      :Trap (~halt∨trace)/0 777
                          f LogTest(ns⍎f)⍬
                      :Else
                          msg←'Error executing teardown "',f,'" :'
                          :If DyaVersion<13.1
                              msg,←,⍕⎕DM,¨⊂NL
                          :Else
                              msg,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')   ⍝ CompCheck: ignore
                              :If 18≤DyaVersion
                                  msg,←(⎕JSON ⎕OPT'Compact' 0)⎕DMX            ⍝ CompCheck: ignore
                              :ElseIf 16≤DyaVersion
                                  msg,←⎕JSON ⎕DMX            ⍝ CompCheck: ignore
                              :EndIf
                          :EndIf
                          LogError msg
                      :EndTrap
                  :Else
                      LogError'-teardown function not found: ',f
                  :EndIf
              :EndIf
     
     END:
              pre←'       '
              :For j :In ⍳3
                  :If ~0∊⍴j⊃LOGS
                      r,←(⊂((3↑pre),j⊃'Infos' 'Warnings' '*** Errors'),' logged ',((setup≢null)/' with setup "',setup,'":')),pre∘,¨(NL ⎕R(NL,pre))(j⊃LOGS)
                  :EndIf
              :EndFor
              :If 0∊⍴3⊃LOGS
                  r,←(quiet≡null)/⊂'   ',(((setup≢null)∧1≠1↑⍴setups)/setup,': '),(⍕steps),' test',((1≠steps)/'s'),' passed in ',(1⍕0.001×⎕AI[3]-start),'s'
                  1 qNDELETE TESTSOURCE,'*.rng.txt' ⍝ delete memorized random-numbers when tests succeeded
              :Else
                  r,←⊂' Time spent: ',(1⍕0.001×⎕AI[3]-start),'s'
              :EndIf
          :EndFor ⍝ Setup
      :EndFor ⍝ repeat
     
      r,←((1<tally setups)∧quiet≡null)/⊂'Total Time spent: ',(1⍕0.001×⎕AI[3]-start0),'s'
      :If ~0∊⍴3⊃LOGS
      :AndIf ~0∊⍴order
          r,←⊂'-order="',(⍕order),'"'
      :EndIf
      :If args.coco≢null
          :If 9=⎕NC'CoCo'
              :If 0=CoCo.⎕NC'NoStop'
              :OrIf CoCo.NoStop=0
                  CoCo.Stop ⍬
              :EndIf
              r1←CoCo.Finalise ⍬
              r2←CoCo.(1 ProcessDataAndCreateReport filename)
              tie←r1 ⎕FSTIE 0
              tab←⎕FREAD tie,10
              ⎕FUNTIE tie
              res←≢¨tab[;2 4]    ⍝ CompCheck: ignore
              CoCo.res←res←0.1×⌊0.05+1000×÷/+⌿res
              r,←⊂'Coverage = ',(3 0⍕res),'%'
              r,←⊂']open ',r2,'     ⍝ to see coverage details...'
          :EndIf
      :EndIf
      →FAIL2  ⍝ skip adding LOGS to r (we've done that before already and only need the code below if something made us →FAIL)
     FAIL:
    ⍝   ⎕←'≢LOGS=',≢¨LOGS
      :For j :In ⌽⍳3
          :If ~0∊⍴j⊃LOGS
              r,←(⊂(j⊃'Info' 'Warning' 'Error'),'s:'),'   '∘,¨j⊃LOGS
          :EndIf
      :EndFor
      LOGS←3⍴⊂''   ⍝ reset LOGS, it's in r now...
     FAIL2:
      LOGS←LOGSi,¨LOGS  ⍝ prepend initial logs
      r←table r
     
      :If off>0
      :OrIf loglvl>0
          :If 0≢args.testlog
              ⎕←'args.testlog=',args.testlog
              :If (⎕DR' ')=⎕DR args.testlog
              :AndIf 0<≢args.testlog
                  logFile←args.testlog
                  :If ''≡1⊃qNPARTS logFile
                  :AndIf ~∨/'\/'∊logFile
                      logFile←TESTSOURCE,logFile
                  :EndIf
                  :If ~'.'∊logFile  ⍝ make sure we have an extension
                      logFile,←'.log'   ⍝ and it's ".log"
                  :EndIf
              :Else
                  logFile←TESTSOURCE,base,'.log'
              :EndIf
          :Else
              logFile←TESTSOURCE,base,'.log'
          :EndIf
     
          logBase←({∊(1⊃qNPARTS ⍵),{⍵[⍳¯1+⍵⍳'.']}∊1↓qNPARTS ⍵}logFile),'.'
          :If (loglvl _hasBitSet 16)∧0<⍴3⊃LOGS
          :OrIf loglvl _hasBitSet 8
              log←⎕SE ⎕WG'Log'
              log←∊log,¨⊂NL
              :If 0<≢i←{⍵/⍳tally ⍵}ThisTestID⍷log
                  log←(i-1)↓log
              :EndIf
              (⊂log)qNPUT(logBase,'session.log')1
          :EndIf
     
          :For j :In ⍳2
              :If ~0∊⍴j⊃LOGS
                  :If loglvl _hasBitSet j⊃2 4
                      (⊂i⊃LOGS)qNPUT logBase,(j⊃'info.log' 'warn.log')
                  :EndIf
              :EndIf
          :EndFor
     
          :If loglvl _hasBitSet 32
          :AndIf 18≤DyaVersion
              res←⎕NS''
              res.rc←20+(~0∊⍴3⊃LOGS)+WSFULL
              res.(LogInfo LogWarn LogError)←LOGS
              :If 9=⎕NC'CoCo'
                  res.CoveragePercent←CoCo.res
              :EndIf
              :If 2=⎕NC'⎕se._cita._memStats'
                  res.cpu23←⎕SE._cita.∆cpu
                  res.memStats←⎕SE._cita._memStats
              :EndIf
              (⊂(⎕JSON ⎕OPT('Compact' 0)('HighRank' 'Split'))res)qNPUT(logFile,'.json')1  ⍝ CompCheck: ignore
          :EndIf
     
          :If ~0∊⍴3⊃LOGS
          :AndIf (off>0)∨loglvl _hasBitSet 1
              ⎕←'Errors were collected - writing them to logFile',(off=1)/' before doing ⎕OFF ',⍕21+WSFULL
              (⊂∊(3⊃LOGS),¨⊂NL)qNPUT logFile 1
              :If off=1
                  rc←21+WSFULL
                  ⎕OFF rc
              :EndIf
          :EndIf
     
          :If off=1
              ⎕←'OFF 20'
              ⎕OFF 20
          :EndIf
      :EndIf
    ∇

    ∇ msg Fail value
      msg ⎕SIGNAL(1∊value)/777
    ∇

    ∇ line←line Because msg
     ⍝ set global "r", return branch label
      :If 0=⎕NC'r'
          r←''
      :EndIf
      r←r,((~0∊tally r)/⎕UCS 10),(2⊃⎕SI),'[',(⍕2⊃⎕LC),']: ',msg
    ∇

    ∇ r←expect Check got
      :If r←expect≢got
      :AndIf ##.halt
          ⎕←'expect≢got:'
          :If 200≥⎕SIZE'expect'
              ⎕←'expect=',,expect
          :EndIf
          :If 200≥⎕SIZE'got'
              ⎕←'got=',,got
          :EndIf
          ⍝ ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃(1⊃⎕RSI).⎕NR 2⊃⎕SI
          ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃⎕THIS.⎕NR 2⊃⎕SI
          (1+⊃⎕LC)⎕STOP 1⊃⎕SI ⍝ stop in next line
      :EndIf
    ∇

    ∇ z←A IsNotElement B
      z←~A{a←⍺ ⋄ 1<''⍴⍴,a:∧/(⊂a)∊⍵ ⋄ ∧/a∊⍵}B
      :If z
      :AndIf ##.halt
          ⎕←'A IsNotElement B!'
          :If 200≥⎕SIZE'A'
              ⎕←'A=',,A
          :EndIf
          :If 200≥⎕SIZE'B'
              ⎕←'B=',,B
          :EndIf
          ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',(1+2⊃⎕LC)⊃⎕THIS.⎕NR 2⊃⎕SI
          (1+⊃⎕LC)⎕STOP 1⊃⎕SI ⍝ stop in next line
      :EndIf
    ∇

    ∇ R←{ctxt}RandomVal arg;rFile;r
⍝ generate random values
      :If 0=⎕NC'ctxt'
          ctxt←⎕SI[2 3]{(1⊃⍺),'_',(1⊃⍵),'_',(2⊃⍺),'_',2⊃⍵}⍕¨⎕LC[2 3]
      :EndIf  ⍝ use ⎕SI as indicator of context
      rFile←TESTSOURCE,ctxt,'.rng.txt'    ⍝ name of rng-file
      :If qNEXISTS rFile         ⍝ found one - so re-use those numbers (instead of creating new series)
          r←∊1⊃qNGET rFile
          (((⎕UCS r)∊10 13)/r)←' '
          R←2⊃⎕VFI r
      :Else
          :If 1<tally arg
              R←arg[2]?arg[1]
          :Else
              R←?arg
          :EndIf
          (⍕R)Put rFile   ⍝ "remember" the generated numbers
      :EndIf
    ∇


    ∇ res←LoadTestSuite suite;setups;lines;i;cmd;params;names;values;tmp;f;args
      :If 0=tally 1⊃qNPARTS suite
          suite←TESTSOURCE,suite
      :ElseIf '.'≡1⊃1⊃qNPARTS suite ⍝ deal with relative paths
          :If '.'≡1⊃1⊃qNPARTS TESTSOURCE   ⍝ if suite and source are relative, ignore suite's relative folder and use SOURCE's...
              suite←∊(1 qNPARTS TESTSOURCE),1↓qNPARTS suite
          :Else
              suite←∊1 qNPARTS TESTSOURCE,suite
          :EndIf
      :EndIf      ⍝ default path for a suite is the TESTSOURCE-folder
      :If ''≡3⊃qNPARTS suite
          suite←suite,'.dyalogtest'
      :EndIf   ⍝ default extension
     
      :If qNEXISTS suite
          lines←⊃qNGET suite
      :Else
          args←,⊂'Test suite "',suite,'" not found.' ⋄ res←0,args ⋄ →0
      :EndIf
      lines←dtb¨↓rmcm↑lines
      args←⎕NS''
      ⎕RL←2  ⍝ CompCheck: ignore ⍝ use O/S rng
      path←1⊃1 qNPARTS suite
      args.tests←⍬
      args.coco_subj←''
      args.coco_ignore←⍕⎕THIS
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
                  :If 0=⎕NC'args.tests'
                      args.tests←⍬
                  :EndIf
                  args.tests,←',',GetParam'fn' ''
     
              :Case 'teardown'
                  args.teardown←GetParam'fn' '' ⍝ function is there
     
              :CaseList 'id' 'description'
                  :If verbose
                      Log cmd,': ',GetParam''
                  :EndIf
              :Case 'order'
                  args.order←2⊃⎕VFI params
              :Case 'codecoverage_subject'   ⍝ ,-separated list of namespaces to watch while running test (must be present in ws after setup)
                  args.coco_subj←params
              :Case 'codecoverage_ignore'
                  args.coco_ignore←params
              :Case 'alertifcoveragebelow'
                  args.alertifcoveragebelow←2⊃⎕VFI params
     
              :Else
                  Log'Invalid keyword: ',cmd
              :EndSelect
          :EndIf
      :EndFor
     
      args.tests↓⍨←1  ⍝ drop off leading comma
      res←1,args
    ∇

    :EndSection

    :Section BUILD

    ∇ {r}←Build args;file;prod;path;lines;extn;name;exists;extension;i;cmd;params;values;names;_description;_id;_version;id;v;target;source;wild;options;z;tmp;types;start;_defaults;f;files;n;quiet;save;ts;tmpPath;chars;nums;fileType;targetNames;targetName;fileContent;fileData;tmpExt;eol;halt;off;LOGS;logfile;TestClassic;production;ClassicVersion;j;synt;rfs;nam;str;wsid;command;line;TargetList;d;order;NQed;type;pars;det
    ⍝ Process a .dyalogbuild file
      Init 2
      oFFIssue←0    ⍝ set to 1 to repo MB's Keypress issue...
      rc←0   ⍝ returncode (if possible)   0=ok, 1=errors during Build-process
      LOGS←3⍴⊂''
      :If isChar args  ⍝ also allow the fn to be called directly (not as a UCMD) with a simple string arg that we will then parse using DBuilds Parse rules:
          lst←List
          lst←lst[lst.Name⍳⊂'DBuild']
          i←lst.Parse⍳' '
          synt←(i↓lst.Parse)('nargs=',i↑lst.Parse)
          args←(⎕NEW ⎕SE.Parser synt).Parse args
          args.(quiet save production halt)←{2⊃⎕VFI⍕⍵}¨args.(quiet save production halt)  ⍝ saw a string here when we went through the Parsing above - so let's ensure these vars are numeric...
      :EndIf
      start←⎕AI[3]
      extension←'.dyalogbuild' ⍝ default extension
      TargetList←0 5⍴''    ⍝ List of Targets we have to build ([;1]=lineno, [;2]=params names values)
      i←0 ⍝ we are on "line zero" if any logging happens
     
      :If 0∊⍴args.Arguments
          args.Arguments←,⊂file←FindBuildFile ⎕WSID
          args.clear←1 ⍝ Rebuilding workspace
      :AndIf 0∊⍴file
          'Build file not named and no default found'⎕SIGNAL 22
      :EndIf
     
      file←∊1 qNPARTS 1⊃args.Arguments
      (prod quiet save halt TestClassic)←args.(production quiet save halt testclassic)
      (TestClassic prod)←2⊃⎕VFI⍕TestClassic prod  ⍝ these get passed as char (but could also be numeric in case we're being called directly. So better be paranoid and ensure that we have a number)
      off←2 args.Switch'off'
     
      :If halt
          ⎕TRAP←0 'S'
      :EndIf ⍝ Defeat UCMD trapping
     
      Clear args.clear
      (exists file)←OpenFile file
      (path name extn)←qNPARTS file
     
      ('Build-File not found: ',file)⎕SIGNAL exists↓22
     
      lines←1⊃qNGET file
     
      _version←0
      _id←''
      _description←''
      _defaults←'⎕ML←⎕IO←1'
      :If ~prod
          ('Type' 'I')Log'NB: Loaded files will be linked to their source - use -prod to not link'
      :EndIf
      :For i :In ⍳⍴lines
          :If ~':'∊line←i⊃lines                    ⍝ if the line does not have a name-value setting
          :OrIf '⍝'=⊃{(⍵≠' ')/⍵}line     ⍝ or if it's a comment
              :Continue                       ⍝ skip it!
          :EndIf ⍝ Ignore blank lines
          line←{(∧\(~2|+\⍵='''')⍲⍵='⍝')/⍵}line
          (cmd params)←':'SplitFirst whiteout line
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
                  0 Log'Processing "',file,'" (written for version ≥ ',(⍕_version),')'
              :Else
                  ('Type' 'E')Log('This version of ]',Ûcmd,' only supports Dyalog Test file format v',(⍕dVersion),' and lower')
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
              :If ~exists
                  LogError'unable to find file ',tmp ⋄ :Continue
              :EndIf
     
          :CaseList 'ns' 'class' 'csv' 'apl' 'lib' 'data'
              target←'#'GetParam'target'
              target←(('#'≠⊃target)/'#.'),target
              :If 0∊⍴source←GetParam'source' ''
                  'Source is required'Signal 11
              :EndIf
              :If (cmd≡'ns')∧0=⎕NC target
                  target ⎕NS''
                  :Trap halt↓0
                      target⍎_defaults
                      Log'Created namespace ',target
                  :Else
                      :If DyaVersion<13
                          LogError'Error establishing defaults in namespace ',target,': ',⊃⎕DM
                      :ElseIf DyaVersion<16
                          LogError'Error establishing defaults in namespace ',target,': ',⎕DMX.(DM,': ',Message)    ⍝ CompCheck: ignore
                      :Else
                          LogError'Error establishing defaults in namespace ',target,': ',⎕JSON ⎕DMX                         ⍝ CompCheck: ignore
                      :EndIf
                  :EndTrap
              :EndIf
     
              :If cmd≡'csv'
                  types←2⊃⎕VFI GetParam'coltypes'
                  :If ~0=tmp←#.⎕NC target
                      LogError'Not a free variable name: ',target,', current name class = ',⍕tmp ⋄ :Continue
                  :EndIf
                  :Trap halt↓999
                      tmp←∆CSV(path,source)'',(0≠⍴types)/⊂types
                      ⍎target,'←tmp'
                      Log target,' defined from CSV file "',source,'"'
                  :Else
                      :If DyaVersion<13.1
                          LogError⊃⎕DM
                      :Else
                          LogError ⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                      :EndIf
                  :EndTrap
                  :Continue
              :EndIf
     
              wild←∨/'*?'∊source
              options←((wild∧DyaVersion>14)/' -protect'),(prod/' -nolink'),(' -source'/⍨cmd≡'data')  ⍝ protect started with Dyalog 14 (or was it 13?)
     
              :If DyaVersion<13
                  tmpPath←path{cmd≡'lib':⍵ ⋄ ⍵[1,⍴⍵]≡'[]':⍵ ⋄ ⍺,⍵}source
              :Else
                  tmpPath←path{cmd≡'lib':⍵ ⋄ ⍵,⍨⍺/⍨0∊⍴('^\[.*\]'⎕S 3)⍵}source   ⍝ CompCheck: ignore
              :EndIf
              :If cmd≡'lib'   ⍝ find path of library...(only if >17, so we'll be using ]LINK which needs path)
                  :If 17<DyaVersion
                      lib←⊃0(⎕NINFO ⎕OPT('Wildcard' 1)('Recurse' 1))((2 ⎕NQ'.' 'GetEnvironment' 'DYALOG'),'/Library/',source,'.dyalog')  ⍝ CompCheck: ignore
                  :Else
                      lib←source
                  :EndIf
                  lib←eis lib
                  :If 1=tally lib  ⍝ CompCheck: ignore
                      tmpPath←⊃lib
                  :ElseIf 1<tally lib  ⍝ CompCheck: ignore
                      LogError'too many matches searching library "',source,'": ',⍕lib
                      :Continue
                  :Else
                      LogError'Could not find library "',source,'"'
                      :Continue
                  :EndIf
              :EndIf
              :Trap DEBUG↓11
                  ⍝z←⎕SE.SALT.Load tmp←tmpPath,((~0∊⍴target)/' -target=',target),options
                  z←options LoadCode tmpPath target
              :Else
                  :If DyaVersion<13.1
                      LogError⊃⎕DM
                  :Else
                      LogError ⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                  :EndIf
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
                          j←chars⍳⊂tmp
                          :If j≤⍴chars
                              eol←⎕UCS j⊃nums
                          :Else
                              eol←⎕UCS 2⊃⎕VFI j⊃chars
                          :EndIf
                      :Else
                          eol←⎕UCS⍎¨(chars,nums)⎕S(,⍨nums)rtack lc'lf'GetParam'seteol'   ⍝ CompCheck: ignore
                      :EndIf
                  :EndIf
                  tmpExt←3⊃qNPARTS tmpPath
                  tmpExt,⍨←'='/⍨0≠⍴tmpExt
                  targetNames←2⊃¨qNPARTS,eis(⎕SE.SALT.List tmpPath,' -extension',tmpExt,' -raw')[;2]
                  :For targetName fileContent :InEach targetNames(,⊂⍣(1=≡z)rtack z)  ⍝ was 2!
                      :Select fileType
                      :Case 'charvec'
                          fileData←(-⍴eol)↓∊fileContent,¨⊂eol
                      :Case 'charmat'
                          fileData←↑fileContent
                      :Case 'json'
                          fileData←0 qJSON∊fileContent
                      :Case 'charvecs'
                          fileData←fileContent
                      :EndSelect
                      :If '.apla'≢lc 3⊃qNPARTS tmpPath  ⍝ has been brought in by LoadCode already
                          targetName(⍎target).{⍎⍺,'←⍵'}fileData
                      :EndIf
                  :EndFor
                  z←targetNames
                  fileType,←' '
              :Else
                  fileType←''
              :EndIf
     
              :If 0∊⍴z     ⍝ no names
                  LogError'Nothing found: ',source
              :ElseIf (,1)≡,⍴z ⍝ exactly one name
                  Log{(uc 1↑⍵),1↓⍵}fileType,cmd,' ',source,' loaded as ',⍕⊃z
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
                      :Trap halt↓0
                          #⍎tmp
                      :Else
                          LogError,⍕⎕DM,¨⊂NL
                      :EndTrap
                      :If cmd≡'defaults'
                          _defaults←_defaults,'⋄',tmp ⋄ Log'Set defaults ',tmp
                      :EndIf ⍝ Store for use each time a NS is created
                  :EndIf
              :EndIf
     
          :Case 'target'
              :If save=0
              :AndIf 0='2'GetNumParam'save'
                  Log'Found TARGET-Entry, but save=0 - TARGET with save=0 does not have any effect!'
              :Else
                  TargetList⍪←i line params names values
              :EndIf
          :Else
              :If '⍝'≠⊃cmd ⍝ ignore commented lines
                  LogError'Invalid keyword: ',cmd
              :EndIf
          :EndSelect
     
      :EndFor
     
      :If prod
          ⎕EX'#.SALT_Var_Data'
      :EndIf
     
      :If TestClassic>0
          z←TestClassic{
              2=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic⍎⍵
              3=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic ⎕CR ⍵
              +∇¨(⊂⍵,'.'),¨(⍎⍵).⎕NL-2.1 3.1 9.1  ⍝ +∇ avoids crashes in 12.1...15
          }¨(⊂'#.'),¨#.⎕NL-2.1 3.1 3.2 9.1
          :If 0<⍴z
              LogError('Classic-Test found incompatible characters in following functions/variables:',NL),¯2↓∊z{('- ',⍺,⍵)/⍨×,⍴⍺}Ö 1 rtack NL
          :Else
              Log'Workspace seems to be compatible with Classic Edition ',⍕{⍵>1:⍵ ⋄ 12}TestClassic
          :EndIf
      :EndIf
     
      n←tally 3⊃LOGS
      :If 0=n  ⍝ if no errors were found
          :If (save≡1)∧0=1↑⍴TargetList   ⍝ save switch was set, but no target-instruction given
                                    ⍝ pretend we had one which save under name of build-file
              TargetList←1 5⍴0('target: ',name)('wsid=',name)(,⊂'wsid')(,⊂name)
          :EndIf
          :For (i line params names values) :In ↓TargetList
              :If 0∊⍴tmp←GetParam'wsid' ''
                  LogError'wsid missing'
              :Else
                  d←1⊃qNPARTS tmp  ⍝ directory given?
                  :If {{~'/\'∊⍨(⎕IO+2×isWin∧':'∊⍵)⊃⍵}3↑⍵}d   ⍝ if that dir is an relative path
                      wsid←∊1 qNPARTS path,tmp                  ⍝ prefix path of buildfile
                  :Else
                      wsid←tmp
                  :EndIf
                  :If (⊂lc 3⊃qNPARTS wsid)∊'' '.dws'
                  :OrIf 0=tally GetParam'type'    ⍝ if type is not set, we're building a workspace
                      ⎕WSID←wsid
                  :EndIf
                  Log'WSID set to ',wsid
              :EndIf
              save←⍬⍴99~⍨(99 args.Switch'save'),bld←1,⍨'99'GetNumParam'save'
              :If save<1=⊃bld~99
                  Log'Target not saved because of switch -save=0'
              :EndIf
              :If off=2
                  off←1=GetNumParam'off' 0
              :EndIf ⍝ only process this one if the modifier was not provided (and therefore has its default-value of 2)
              :If ~save
                  :Continue
              :EndIf
                     ⍝ Apr 21-research found these vars referencing # (or elements of it) - get them out of the way temporarily
              rfs←0 2⍴''
              ⎕EX¨'⎕SE.'∘,¨'SALTUtils.spc.z' 'SALTUtils.spc.res'
              :Trap 0
                  :For nam :In '⎕SE.'∘,¨'THIS' 'SALTUtils.cs' 'SALTUtils.c.THIS' 'SALTUtils.spc.ns.proc'
                      :If 0<⎕NC nam
                      :AndIf 326=⎕DR⍎nam
                          str←⍕⍎nam
                          :If 1=⍴⍴⍎nam
                              str←',',str
                          :EndIf
                          :If (⍎nam)≢⍎str  ⍝ CompCheck: ignore
                              Log ⎕←'⎕SAVE workaround failed because of ',nam
                          :EndIf
                          rfs⍪←(nam)(str)  ⍝ remember refs stringified...
                          ⎕EX nam         ⍝ and delete them
                      :EndIf
                  :EndFor
              :Else
                  ('Type' 'W')Log'⎕SAVE workaround failed because of ',nam
                  rfs←0 2⍴''
              :EndTrap
              :If DyaVersion≥16
                  ⎕SIGNAL 0  ⍝ CompCheck: ignore   ⍝ reset ⎕DM, ⎕DMX to avoid problems with refs when saving
              :EndIf
              :Trap DEBUG↓0 ⍝ yes, all trap have a halt/ after them - this one doesn't and shouldn't.
                  :If ~0∊⍴type←GetParam'type'
                      ⍝ This uses an undocumented function. It won't be documented because it is due to be changed soon - so we don't want
                      ⍝ to be bound by any published behaviour ;)
                      ⍝ So THIS documentation is purely informal and only describes CURRENT behaviour:
                      ⍝ <type>     is one of 'ActiveXControl' 'InProcessServer' 'Library' 'NativeExe' 'OutOfProcessServer' 'StandaloneNativeExe'
                      ⍝ <flags>    is the sum of zero or more of the following:
                      ⍝
                      ⍝
                      ⍝
                      ⍝
                      ⍝ <resource> is a filename the contents of which will be inserted as a resource in the bound file (used by ASP.NET)
                      ⍝ <icon>     is the name of an icon file, the contents of which are used as the main icon for the bound file
                      ⍝ <cmdline>  is the command line that is bound in the find and passed to dyalog.dll when the dll is started
                      ⍝ <details>  is a 2 column matrix of character vectors which allow the APL programmer to add an RT_VERSION resource to the executable.
                      ⍝            This allows the program to populate the Properties the "Details" tab in the Properties dialog which can be opened by right clicking
                      ⍝            on an executable in Windows Explorer. The first column is the Property, the second the Value. Note that the properties are not
                      ⍝            limited to those displayed in the dialog, nor are any of the names or values validated. Note also that the name of the property
                      ⍝            that appears in the dialog is not necessarily the name that the program must use ..
                      ⍝            search for "string-name" in https://msdn.microsoft.com/en-us/library/windows/desktop/aa381058(v=vs.85).aspx for more details for executables.
                      ⍝            For .NET assemblies, look at https://msdn.microsoft.com/en-us/library/system.reflection(v=vs.110).aspx;
                      ⍝            any of the classes listed which has a constructor which takes a single string value as its argument should be definable.
                      det←⊃,/':'Split¨';'Split GetParam'details'
                      det←(⌽2,0.5×⍴det)⍴det
                      pars←'.' 'Bind'wsid(type)(GetNumParam'flags')(GetParam'resource')(GetParam'icon')(GetParam'cmdline')(det)
                      command←'2 ⎕NQ ',∊{''≡0↑⍵:'''',⍵,''' ' ⋄ (⍕⍵),' '}¨¯1↓pars
                      command←command,' (',(⍕⍴det),'⍴',(∊{''≡0↑⍵:'''',⍵,''' ' ⋄ (⍕⍵),' '}¨det),')'
                      2 #.⎕NQ pars ⍝*** this is not a problem IF the ⎕NQed keypresses execute successfully! ***
                  :Else
                      :If save≡1
                          save←wsid
                      :EndIf
                      command←')SAVE ',save
                      0 #.⎕SAVE save ⍝*** this is not a problem IF the ⎕NQed keypresses execute successfully! ***
                  :EndIf
                  :Trap DEBUG↓0  ⍝ paranoid, but want to avoid any bugs here to trigger the save again...
                      :If qNEXISTS save←wsid{''≡3⊃qNPARTS ⍺:⍺,⍵ ⋄ ⍺}'.dws'
                          tmp←⍕DEBUG{(~⍺)/~⍺::'???' ⋄ (ListFiles ⍵)[1;2]}save
                          Log'Saved as ',save,' (',tmp,' bytes)'
                      :EndIf
                  :EndTrap
                  command←''
              :Case 11   ⍝ DOMAIN ERROR
                  :If 0<102⌶#   ⍝ check most likely cause: links from ⎕SE to #
                      ('Type' 'E')Log'Problem creating ',wsid,':',NL,(∊⎕DM,¨⊂NL),'There might still be references from "somewhere in ⎕SE" to "something in #".',NL,'Please contact support@dyalog.com to discuss & resolve this if the enqueued keystrokes did not create the desired result.'
                  :Else
                      ('Type' 'E')Log'Problem creating ',wsid,':',NL,(↑⎕DM),⊂NL
                  :EndIf
                  :If halt ⋄ (⎕LC[1]+2)⎕STOP 1⊃⎕SI
                      ⎕←'Function halted.'
                      ⍝ stop here
                  :EndIf
              :Else
                  ('Type' 'E')Log'Problem creating ',wsid,':',,(↑⎕DM),⎕UCS 13
              :EndTrap
              :If ~0∊⍴command
                  :If qNEXISTS wsid,'.dws'
                  :AndIf ~'.exe'≡3⊃qNPARTS wsid
                      qNDELETE wsid,'.dws'  ⍝ avoid prompts during )SAVE
                  :EndIf
                  :If isWin
                      {sink←2 ⎕NQ ⎕SE'keypress'⍵}¨'  ',command,⊂'ER'
                      NQed←1
                      Log'Enqueued keypresses to automatically save after UCMD has completed'
                  :Else
                      Log'Please execute the following command when the UCMD has finished:'
                      Log command
                  :EndIf
                  :If ~0∊⍴rfs      ⍝ and created some refs
                      :For (nam str) :In ↓rfs   ⍝ then restore them...
                          ⍎nam,'←',str
                      :EndFor
                  :EndIf
              :EndIf
          :EndFor
      :Else
          ('Type' 'W')Log'DBuild found errors during process',save/', workspace was not saved!'
          n←1  ⍝ need error-count
          rc←1
      :EndIf
      ⍝:EndIf
 ⍝     :endif
     endSave:
      ('Type' 'I')Log'DyalogBuild: ',(⍕⍴lines),' lines processed in ',(1⍕0.001×⎕AI[3]-start),' seconds.'
      r←''
      :If 0<n←tally 3⊃LOGS
          ('Type' 'I')Log(0≠n)/' ',(⍕n),' error',((n>1)/'s'),' encountered.'
      :EndIf
      :For i :In ⍳3
          :If 0<n←tally i⊃LOGS
              r,←⊂((i⍴'*'),' ',((n>1)/⍕n),' ',i⊃'Info' 'Warning' 'Error'),((n>1)/'s'),':'
              r,←i⊃LOGS
          :EndIf
      :EndFor
      r←table r
      :If off=1  ⍝ careful: off∊0 1 2!
          logfile←∊(2↑qNPARTS file),'.log'
          qNDELETE logfile
          :If ~0∊⍴3⊃LOGS
              (∊r,¨⊂NL)Put logfile
          :EndIf
          :If isWin
                ⍝ June 2021, m19713: need to leading blanks to avoid an issue with 171c64, 180c32, 180c64, 181c32, 181c64 where ')OFF' would result in "oFF".
                ⍝ (No simple repro and not a problem on (121c64, 140c64, 141c64, 150c32)
              :If 0=⎕NC'NQed'
              :OrIf ~NQed
                  ⎕OFF rc
              :Else
                  {sink←2 ⎕NQ ⎕SE'keypress'⍵}¨((~oFFIssue)/'  '),')OFF',⊂'ER'  ⍝ as long as 18008 isn't fixed (and for all older versions) we can't use ⎕OFF but have to ⎕NQ'KeyPress'
                  →0
              :EndIf
          :Else
              :If 0=n                                                                 ⍝ if we found no errors
                  ⎕OFF                                                               ⍝ it is save to exit
              :Else                                                                   ⍝ otherwise
                  ⎕←'      )OFF     ⍝ errors in DBuild prevent automic OFFing...'    ⍝ tell the user
              :EndIf
          :EndIf
      :ElseIf 2=⎕SE.⎕NC'DBuild_postSave'
          ⍎⎕SE.DBuild_postSave
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
      :If (clear≡1)∨0∊⍴,clear
          ⍝ #.(⎕EX ⎕NL⍳9)
          #.⎕EX #.⎕NL⍳9
          Log'workspace cleared'
      :ElseIf ∧/1⊃tmp←⎕VFI clear
          n←#.⎕NL 2⊃tmp
          #.⎕EX n ⋄ Log'Expunged ',(⍕⍴n),' names of class ',clear
      :Else
          LogError'invalid argument to clear, should be empty or a numeric list of name classes to expunge'
      :EndIf
    ∇

    LineNo←{    '[',(,'ZI3'⎕FMT ⊃,⍵),']'    }  ⍝ m19572 deals with Edit|Reformat not removing those blanks...!

    ∇ {r}←{f}LogTest msg;type
      r←0 0⍴0 ⋄ type←3
      →(0∊tally∊msg)⍴0
      :If 0=⎕NC'f'
          f←''
      :ElseIf 2≤|≡f
          :If 2=|≡f ⍝ ONE name & value
              f←⊂f
          :EndIf
          f←,f
          :If (tally f)≥i←(,1↑¨f)⍳⊂,⊂'Type'
              type←'IWE'⍳⊃2⊃i⊃f
          :EndIf
          :If (tally f)≥i←(,1↑¨f)⍳⊂,⊂'Prefix'
              f←2⊃i⊃f
          :Else
              f←''
          :EndIf
      :EndIf
      :If 2=⎕NC'timestamp'
      :AndIf timestamp=1
          f←(⍕3↓⎕TS),' ',f
      :EndIf
      msg←(f,(~0∊⍴f)/': ')∘,¨eis msg
      :If verbose
      :AndIf quiet=0
          ⎕←msg
      :EndIf
      LOGS[type],←⊂eis msg
    ∇

    ∇ {pre}Log msg;type
    ⍝ no ⍺ or  ⍺=1: prefix log with lineno.
    ⍝ alternatively pre can also be a VTV with Name/Value-pairs ('Prefix' 'foo')('Type' 'I')
      type←1    ⍝ Info
      →(0=tally msg)/0
      :If 0=⎕NC'pre'
      :OrIf pre≡1
          pre←⊂'Prefix'(LineNo i)
      :EndIf
      :If 2=⎕NC'pre'
          :If ~(≡pre)∊0 1   ⍝ if is not a scalar or a simple vec
              :If 2=|≡pre ⍝ ONE name & value
                  pre←⊂pre
              :EndIf
              pre←,pre
              :If (tally pre)≥i←(,1↑¨pre)⍳⊂,⊂'Type'
                  type←'IWE'⍳⊃2⊃i⊃pre
              :EndIf
              :If (tally pre)≥i←(,1↑¨pre)⍳⊂,⊂'Prefix'
                  pre←2⊃i⊃pre
              :Else
                  pre←''
              :EndIf
          :Else
              pre←''
          :EndIf
      :EndIf
     
      :If 0=⎕NC'LOGS'
          LOGS←3⍴⊂''
      :EndIf  ⍝ may happen during Clean...
      LOGS[type],←⊂eis pre,msg
      :If quiet=0
          ⎕←pre,,msg
      :ElseIf quiet=1
      :AndIf type=3
          ⎕←pre,,msg
      :EndIf
    ∇

    ∇ dm Signal en
     ⍝ subroutine of Build: uses globals i and file
      (dm,' in line ',(LineNo i),' of file ',file)⎕SIGNAL 2
    ∇

    ∇ {r}←{decor}LogError msg
     ⍝ subroutine of Build: uses globals i
      :If 0=⎕NC'decor'
          decor←'*****'
      :EndIf
      decor←decor,' ERROR ',decor
      ('Type' 'E')('Prefix'decor)Log msg
      :If quiet=1    ⍝  make sure that errors are shown (unless we are explicitely told to shut up (quiet=2)- this is mostly relevant when Build is called during ]DTest)
          ⎕←msg
      :EndIf
    ∇

    :EndSection

    :Section UCMD

    ∇ r←List
      Init 0   ⍝ make sure _Version is available...
      r←⎕NS¨3⍴⊂''
      r.Group←⊂'DEVOPS'
      r.Name←'DBuild' 'DTest' 'GetTools4CITA'
      r.Desc←'Run one or more DyalogBuild script files (.dyalogbuild)' 'Run (a selection of) functions named test_* from a namespace, file or directory' 'Load tools to run CITA-tests'
      :If 14>1⊃_Version
          r.Parse←'1S -production -quiet[∊]0 1 2 -halt -save[∊]0 1 -off[=]0 1 -clear[=] -testclassic' '1 -clear[=] -tests= -testlog[=] -filter= -setup= -teardown= -suite= -verbose -quiet -halt -loglvl= -trace -ts -timeout= -repeat= -order= -init -off[=]0 1 2' ''
      :Else
          r.Parse←'1S -production -quiet[∊]0 1 2 -halt -save[∊]0 1 -off[=]0 1 -clear[=] -testclassic' '999s -clear[=] -tests= -testlog[=] -filter= -setup= -teardown= -suite= -verbose -quiet -halt -loglvl= -trace -ts -timeout= -repeat= -order= -init -off[=]0 1 2 -coco[=]' ''
      :EndIf
    ∇

    ∇ Û←Run(Ûcmd Ûargs)
     ⍝ Run a build
      :Select Ûcmd
      :Case 'DBuild'
          Û←Build Ûargs
      :Case 'DTest'
          Û←Test Ûargs
      :Case 'GetTools4CITA'
          Û←GetTools4CITA Ûargs
      :EndSelect
    ∇

    ∇ r←level Help Cmd;d
      Init 0
      :Select Cmd
      :Case 'DBuild'
          r←⊂'Run one or more DyalogBuild script files (.dyalogbuild) | Version ',2⊃Version
          r,←⊂'    ]',Cmd,' <files> [-clear[=NCs]] [-production] [-quiet] [-halt] [-save=0|1] [-off=0|1] [-TestClassic]'
          :Select level
          :Case 0
              r,←⊂']',Cmd,' -?? ⍝ for more information'
          :Case 1
              r,←'' 'Argument is:'
              r,←⊂'    files         name of one or more .dyalogbuild files'
              r,←'' 'Optional modifiers are:'
              r,←⊂'    -clear[=NCs]              expunge all objects, optionally of specified nameclasses only'
              r,←⊂'    -halt                     halt on error rather than log and continue'
              r,←⊂'    -production               remove links to source files'
              r,←⊂'    -quiet                    only output actual errors (quiet=2 only writes them to log, not into session)'
              r,←⊂'    -save=0|1                 save the build workspace (overwrites TARGET''s save-option). NB: we only save if no errors were logged during Build-process!'
              r,←⊂'    -off=0|1                  )OFF after completion (if errors were logged, logfile will be created)'
              r,←⊂'    -TestClassic              check imported code for compatibility with classic editions (charset, not language-features!)'
              r,←⊂''
              r,←⊂']',Cmd,' -??? ⍝ for description of the DyalogBuild script format'
          :Case 2
              r,←⊂''
              r,←⊂'each non-empty line of a DyalogBuild script has the following syntax:'
              r,←⊂'INSTRUCTION : argument, Parameter1=value1, Parameter2=value2,...'
              r,←⊂'              Everything after INSTRUCTION: may reference environment-variables using syntax $EnvVar.'
              r,←⊂'              You can continue with any non-alphabetic chars immediately following the name of the var, otherwise leave a blank.'
              r,←⊂'              ie: with EnvVars FOO="C:\TEMP" and Git="c:\git\", you can do'
              r,←⊂'                  "$Foo\Goo" => "C:\TEMP\Goo", "$Git MyDir" => "c:\git\MyDir", "$Git  MyDir" => "c:\git\ MyDir"'
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
              r,←⊂'    Loads the CSV file "pathname" as a matrix called "matname". "spec" corresponds to the third element of ⎕CSV''s right argument; for details, see ',⎕SE.UCMD'Help ⎕CSV -url' ⍝ CompCheck: ignore
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
              r,←⊂'    off=0|1  (Default=0): )OFF after completion of Build. If errors were logged, a logfile (same name as the .dyalogbuild-file with .log-extension)'
              r,←⊂'                          will be created and exit code 1 will be set.'
              r,←⊂''
              r,←⊂'More info in the wiki!  → https://github.com/Dyalog/DBuildTest/wiki/DBuild'
          :EndSelect
     
      :Case 'DTest'
          r←⊂'Run (a selection of) functions named test_* from a namespace, file or directory | Version ',2⊃Version
          r,←⊂'    ]',Cmd,' {<ns>|<file>|<path>} [-halt] [-filter=string] [-off] [-quiet] [-repeat=n] [-loglvl=n] [-setup=fn] [-suite=file] [-teardown=fn] [-testlog=] [-tests=] [-ts] [-timeout=] [-trace] [-verbose] [-clear[=n]] [-init] [-order=]'
          :Select level
          :Case 0
              r,←⊂']',Cmd,' -?? ⍝ for more info'
          :Case 1
              r,'' 'Argument is one of:'
              r,←⊂'    ns                namespace in the current workspace'
              r,←⊂'    file              .dyalog file containing a namespace or a test-fn'
              r,←⊂'    path              path to directory containing functions in .dyalog files'
              r,←'' 'Optional modifiers are:'
              r,←⊂'    -clear[=n]        clear ws before running tests (optionally delete nameclass n only)'
              r,←⊂'    -filter=string    only run functions whose name start with filter'
              r,←⊂'    -halt             halt on error rather than log and continue'
              r,←⊂'    -init             if specified test-file wasn''t found, it will be initialised with a template'
              r,←⊂'    -loglvl           control which log files we create (if value of "-off" > 0)'
              r,←⊂'                        1={base}.log: errors'
              r,←⊂'                        2={base}.warn.log warnings'
              r,←⊂'                        4={base}.warn.log info'
              r,←⊂'                        8={base}.session.log'
              r,←⊂'                       16={base}.session.log ONLY if test failed'
              r,←⊂'                       32={base}.log.json: machine-readable results'
              r,←⊂'                          Creating such a log is the ONLY way to get data on performance and memory usage of tests!'
              r,←⊂'    -order=0|1|"NumVec" control sequence of tests (default 0: random; 1:sequential;"NumVec":order)'
              r,←⊂'    -off[=0|1|2]      )off after running the tests'
              r,←⊂'                        0=do not )OFF after test'
              r,←⊂'                        1=)OFF after test'
              r,←⊂'                          creates {base}.log if errors found'
              r,←⊂'                          AND {warn|info}.log if warnings of info-msgs were created'
              r,←⊂'                          (NB: depends on -loglvl!)'
              r,←⊂'                        2=do not )OFF, but create .log-files (see loglvl)'
              r,←⊂'    -quiet            qa mode: only output actual errors'
              r,←⊂'    -repeat=n         repeat test n times'
              r,←⊂'    -setup=fn         run the function fn before any tests'
              r,←⊂'    -suite=file       run tests defined by a .dyalogtest file'
              r,←⊂'    -teardown=fn      run the function fn after all tests'
              r,←⊂'    -testlog=         force name of logfiles (default name of testfile)'
              r,←⊂'    -tests=           comma-separated list of tests to run'
              r,←⊂'    -timeout          sets a timeout. Seconds after which test(suite)s will be terminated. (Default=0 means: no timeout)'
              r,←⊂'    -ts               add timestamp (no date) to logged messages'
              r,←⊂'    -trace            set stop on line 1 of each test function'
              r,←⊂'    -verbose          display more status messages while running'
              r,←⊂''
              r,←⊂'More info in the wiki!  → https://github.com/Dyalog/DBuildTest/wiki/DTest'
          :Case 'GetTools4CITA'
              r←⊂'An internal tool for testing with CITA'
          :EndSelect
      :EndSelect
    ∇

    :namespace _cita

        ∇ Write2Log txt;file
      ⍝ needs name of test
          file←GetCITA_Log 1
          :If ~qNEXISTS file
              txt qNPUT file
          :Else ⍝ q&d "append":
              old←qNGET file
              (old,⊂txt)qNPUT file 1
          :EndIf
        ∇

        ∇ R←GetCITA_Log signal;z
        ⍝ signal: should we ⎕SIGNAL an error if no config file is found? (default=1)
          :If 4=⍴R←_ExpandEnvVars'.log',⍨2 ⎕NQ'.' 'GetEnvironment' 'CITA_Log'
        ⍝   ⎕←2 ⎕NQ'.' 'GetCommandLine'   ⍝ spit out commandline into the session - maybe it help diagnosing the problem...
              :If 1∊z←∊⎕RSI{0::0 ⋄ 2=⍺.⎕NC ⍵:0<⍺⍎⍵ ⋄ 0}¨⊂'CITA_Log'    ⍝ CompCheck: ignore   / search calling environment for variable CITA_Log
                  R←((z⍳2)⊃⎕RSI).CITA_Log                                ⍝ CompCheck: ignore
              :Else
              ⍝ alternatively use name of test
                  :If 0<≢R←2 ⎕NQ'.' 'GetEnvironment' 'CITATest'
                      R←∊(2↑qNPARTS R),'.CITA.log'
                  :Else
                      :If signal
                          'Found no CITA_Log in Environment - this dws is supposed to be called from CITA which should have passed the right commandline'⎕SIGNAL 11
                      :EndIf
                  :EndIf
              :EndIf
          :EndIf
        ∇

        ∇ R←_ExpandEnvVars R;i;j;var
⍝ expands references to EnvVars in string R
⍝ need to be enclosed either in % or []
⍝ Warning: this fails utterly it you feed misconstructed strings...
          :While 0<⍴i←{⍵/⍳⍴⍵}R∊'%['
              i←⊃i
              c←(1+R[⊃i]='[')⊃'%]'   ⍝ the closing character
              :If 0<j←⊃{⍵/⍳⍴⍵}(i<⍳≢R)∧R=c
                  var←i↓(j-1)↑R
                  var←2 ⎕NQ'.' 'GetEnvironment'var  ⍝ replace with value
                  R←R[⍳i-1],var,j↓R
              :Else ⍝ closing char was not found
                  'Invalid argument - not properly enclosed envvar'⎕SIGNAL 11
              :EndIf
          :EndWhile
        ∇
        ∇ {file}←{msg}_LogStatus status;file;⎕ML
        ⍝ (⍳100)⎕trace 1⊃⎕si
⍝ A step (setup|test|teardown) is finished, report its status to the engine.
⍝ msg allows inject of a message into the file, otherwise an empty file will be created.
⍝ options:
⍝ fail  | ok       | error     <------ these are the extensions of the status file
⍝ no    | yes      |           {for ⍵
⍝       | success  |           {alternative values
⍝ 0     | 1        |¯1         numeric codes for ⍵
⍝ bonus option: any other text passed as status will be used as file extension...
⍝
⍝ logging a status will save the session-log AND ⎕OFF (returncode as given in status[2] OR 31=success, 32=failure, 33=error)
⍝ returncode=¯42 will NOT off (but will write the log file!)
          ⎕ML←1
          :If 0=⎕NC'msg' ⋄ msg←'' ⋄ :EndIf
          file←∊2↑qNPARTS GetCITA_Log 1
          :If 1<⍴,status
          :AndIf 0={⎕ML←0 ⋄ ∊⍵}2⊃status
              (status MYrc)←status
          :EndIf
          :If isChar status  ⍝ decode status from character-string
            ⍝ translate known status into "standardized" extensions (that have a certain meaning in CITA)
              :If ∨/(⊂lc status){(0<''⍴⍴⍺)∧⍺≡(''⍴⍴⍺)↑⍵}¨'failure' 'no'
                  status←'fail' ⋄ rc←32
              :ElseIf ∨/(⊂lc status){(0<''⍴⍴⍺)∧⍺≡(''⍴⍴⍺)↑⍵}¨'success' 'ok' 'yes'
                  status←'ok' ⋄ rc←31
              :ElseIf ∨/(⊂lc status){(0<''⍴⍴⍺)∧⍺≡(''⍴⍴⍺)↑⍵}¨⊂'error'
                  status←'err' ⋄ rc←33
              :Else  ⍝ otherwise just use the value given...
              :EndIf
          :Else
         
              status←status×status∊¯1 1
              rc←(2+status)⊃33 32 31
              status←(2+status)⊃'err' 'fail' 'ok'
         
          :EndIf
          :If 2=⎕NC'MYrc'
              rc←MYrc
          :EndIf
    ⍝ uses qNPUT (which is brought in with GetToolsForCITA to write a file on all APL-Versions)
    ⍝ we're intentionally not passing ⍵[2]as 1 to force overwrite - because this is supposed to be called once only!
    ⍝ So if it crashes...that is well deserved...
          file←file,'.',status
          msg qNPUT file
          :If 2=⎕NC'⎕se._cita._memStats'
              t←{0::⍵ ⎕FCREATE 0 ⋄ ⍵ ⎕FSTIE 0}(1⊃qNPARTS file),'MemRep'
              ⎕SE._cita._memStats ⎕FAPPEND t
              ⎕SE._cita.∆cpu ⎕FAPPEND t
              ⎕FUNTIE t
          :EndIf
         
          :If 2=⎕NC'randomstring'
          :AndIf 0<⍴randomstring
              :Trap 0
                  log←⎕SE ⎕WG'Log'
                  :Trap 1
                      log←∊log,¨⊂NL
                  :Else
                      :Trap 0
                          ⎕←'trapped WSFULL! EN=',⎕EN
                          l2←''
                          :While 0<⍴log
                              l2,←1⊃log
                              l2,←NL
                              log←1↓log
                          :EndWhile
                          log←l2
                          ⎕EX'l2'
                          ⎕←'fixed it!'
                      :Else
                          ⎕←'Unfixable WS FULL!'
                          →0
                      :EndTrap
                  :EndTrap
                  :If 1∊y←randomstring⍷log
                      log←(y⍳1)↓log
                      log←((NL⍷log)⍳1)↓log
                  :EndIf
                  log,←'TS.End=',⍕⎕TS
                  log qNPUT(file←({(2>+\⍵='.')/⍵}file),'.sessionlog.txt')1
                  ⎕←'Wrote log to ',file
              :Else
                  ⎕←'*** Error while attempting to write sessionlog to a file:'
                  ⎕←⎕DM
              :EndTrap
          :EndIf
          :If rc≠¯42
              ⎕←'Wrote the log, now we will call ⎕OFF'
              ⎕←'⎕tnums=',⎕TNUMS
              ⎕←'on this line!' ⋄ ⎕OFF rc
          :EndIf
          ⍝1300⌶77  ⍝ Andy
        ∇

⍝ Define Success'blablabla' and Failure'blabla' and Error'blasbla'as shortcuts to 'blabla'_LogStatus 1|0|¯1
        Success←_LogStatus∘1
        Failure←_LogStatus∘0
        Error←_LogStatus∘¯1


        ∇ {R}←{AddPerf}RecordMemStats suffix;facts;pFmt;r
⍝ AddPerf=0 or missing: don't care about performance
⍝         1           : remember ⎕AI[2 3]
⍝         2           : report ∆ of ⎕AI[2 3]
          pFmt←{w←⍕⍵ ⋄ t←0.333×≢w ⋄ {(¯1+⊃where w∊⎕D)↓w},',',(⌽3,⌈t)⍴(-3×⌈t)↑w}  ⍝ pragmatic way to inject "," w/o worrying abt formatstrings or decimals (use TamStat's FmtX if we should need more)
          R←⍬
          :If 2=⎕NC'AddPerf'
              :Select AddPerf
              :Case 1 ⋄ ∆cpu←⎕AI[2 3]    ⍝ intentionally leaves ∆cpu behind in ⎕se._cita
              :Case 2 ⋄ ∆cpu←⎕AI[2 3]-∆cpu ⋄ R,←⊂('Perf: ∆ AI[2 3]=',∊' ',¨pFmt¨∆cpu)''
              :EndSelect
          :EndIf
          facts←(0 'WS available')(1 'WS used')(2 'Compactions')(3 'Successful garbage collections')(4 'Garbage pockets')(9 'Free pockets')(10 'Used pockets')
          facts,←(12 'Sediment size')(13 'WS alloc')(14 'Max WS')(15 'Limit on min ws alloc')(16 'Limit on max ws alloc')(19 '2002⌶ calls')
         
          r←⍬
          :For f :In facts
              r,←⊂pFmt(2000⌶)1⊃f
          :EndFor
          r←↑r
          r←↓('<   >,I2,< >'⎕FMT∊1⊃¨facts),(↑2⊃¨facts),'=',' ',(-+/' '=r)⌽r
         
          R,←⊂'Memory manager statistics',((0<≢suffix)⍴' '),suffix,':'
          R,←r
          :If 0=⎕NC'⎕se._cita._memStats'
              ⎕SE._cita._memStats←R
          :Else
              ⎕SE._cita._memStats,←R
          :EndIf
        ∇


    :EndNamespace

    :EndSection

:EndNamespace ⍝ DyalogBuild  $Revision$
