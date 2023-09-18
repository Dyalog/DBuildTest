:Namespace DyalogBuild ⍝ V 1.85
⍝ 2017 04 11 MKrom: initial code
⍝ 2017 05 09 Adam: included in 16.0, upgrade to code standards
⍝ 2017 05 21 MKrom: lowercase Because and Check to prevent breaking exisitng code
⍝ 2017 05 22 Adam: reformat
⍝ 2017 05 23 Adam: uppercased Because and Check and moved Words, reinstate blank lines, make compatible with 15.0
⍝ 2017 06 05 Adam: typo
⍝ 2017 06 15 Adam: TOOLS → EXPERIMENTAL
⍝ 2017 06 18 MKrom: test for missing argument
⍝ 2017 06 23 MKrom: get rid of empty function names
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
⍝ 2020 01 21 MBaas: mostly backward compatible with v12 (need to sort out ⎕R/⎕S,@)
⍝ 2020 01 22 MBaas: compatibility with Classic
⍝ 2020 01 23 MBaas: took care of ⎕R,⎕S,@
⍝ 2020 01 24 MBaas: DBuild: added switch -halt for "halt on error" as in DTest; fixed bugs found while testing under v12
⍝ 2020 01 27 MBaas: DBuild: target: wsid, save=1, off=1 (and switch -save=1 to override settings from file);]DBuild: added -TestClassic
⍝ 2020 01 28 MBaas: DBuild: -TestClassic=version;bug fixes;doco
⍝ 2020 01 29 MBaas: DBuild: $EnvVar
⍝ 2020 03 23 MBaas: made TestClassic is a simple switch w/o values assigned; fixes dealing with -halt in -save in DBuild;various minor fixes
⍝ 2020 04 03 MBaas: added -clear to DTest to make sure that the ws is ⎕CLEARed before executing tests (simplifies repeated testing)
⍝ 2020 04 06 MBaas: ]DBuild 1.25 executes the content of secret variable ⎕SE.DBuild_postSave after saving the ws
⍝ 2020 04 15 MBaas: ]DTest {file} now loads ALL functions present in folder of {file}, but only execute the test specified in file. (So test may use utils w/o bothering about loading them)
⍝ 2020 04 21 MBaas: ]DTest - timestamp (adds ⎕TS to log messages)
⍝ 2020 04 23 MBaas: ]DTest: renamed -timestamp to -ts; added -timeout
⍝ 2020 04 29 MBaas: ]DTest -order=0|1|"NumVec". Default is random order when executing tests and setups. If tests fail, order will be accessible in *.rng.txt files!
⍝ 2020 05 19 MBaas: colon in arguments of the instructions (i.e. LX/EXEC/PROD/DEFAULTS with pathnames) caused trouble. Fixed.
⍝ 2020 05 20 MBaas: variables with platform info; typos fixed (in Help);]DBuild only creates logfile (with -off) if it found errors
⍝ 2020 07 01 MBaas: ]DTest -init; fixed bugs when ]DBuild used -save Modifier
⍝ 2020 07 23 MBaas: v1.30 ]DTest -off;lots of small fixes & enhancements - see commit message for details
⍝ 2020 07 24 MBaas: some fixes for compatibility with old Dyalog versions
⍝ 2020 08 05 AWS: Avoid calling ⎕USING if on AIX or using a classic interpreter - avoids extraneous errors on status window stream
⍝ 2020 08 21 MBaas: v1.31 ]DTest accepts any # of arguments (can be useful for selection of Tests as in DUI QAs)
⍝ 2021 02 04 MBaas: v1.4 ]DBuild deals with ]LINKed files;fixed various bugs in Build & Test
⍝ 2021 01 10 Adam: v1.32 defer getting .NET Version until needed
⍝ 2021 01 20 MBaas: v1.33 moved assignments into dedicated Init function to avoid running them when UCMD is loaded
⍝ 2021 03 16 MBaas: v1.41 merging of various minor changes, mostly TACIT related
⍝ 2021 03 23 MBaas: v1.43 fixes: Classic compatibility, relative paths for tests & suites
⍝ 2021 03 30 MBaas: v1.44 fixes: more Classic compatibility - missed a few things with 1.43, but now it should be done.
⍝ 2021 04 22 MBaas: v1.45: improved loading of code (from .dyalog + .apln,.aplc,.aplf,.apli,.aplo);various fixes & cleanups
⍝ 2021 04 30 MBaas: v1.46 has a better workaround for saving (no need to go into the session);-save=0 can overwrite the option set with TARGET
⍝ 2021 05 19 MBaas: v1.50 special handling of WS FULL in DTest and DBuild; allows specifying TARGET with .exe or .dll extension;handle multiple TARGET entries per file
⍝ 2021 06 02 MBaas: v1.51: v1.50 did not report ALL errors
⍝ 2021 06 24 MBaas: v1.52: minor details
⍝ 2021 07 26 MBaas: v1.53: fixed VALUE ERROR in ]DBuild
⍝ 2021 07 29 MBaas: v1.60: added switch to -coco to ]DTest to enable testing of Code Coverage (requires version ≥18.0)
⍝ 2021 09 01 MBaas: v1.61: DTest -off=2 to create .log file for failed tests, but not ⎕OFF (useful when called by other functions, as CITA does)
⍝                          -testlog also create {basename}.session.log ALWAYS (success or failure) with the entire session output of executing the test, launching a test shows current version of DyalogBuild
⍝                          DTest: -trace switch will also trace into setup functions, not only tests.
⍝                          Help for DBuild or DTest will also show version number
⍝ 2021 12 17 MBaas, v1.62: new internal variable (available to tests): _isCITA - is set to 1 if running under control of CITA (Continous Integration Tool for APL)
⍝                   v1.62: streamlined logging and creation of logfiles (reporting errors and optionally info and warnings, too)
⍝                   v1.62: it is also possible to get test results in a .json file (see loglvl): this file also has performance stats and collects various memory related data
⍝ 2022 01 10 MBaas, v1.63: DBuild: ⎕WSID will not be set if save=0 (use save=2 to not save, but set ⎕WSID). "-q" modifier suppresses ALL logging (only logs errors)
⍝ 2022 05 26 MBaas, v1.70: DBuild: DATA: support for .TXT files was mistakenly removed with 1.4 - fixed that. Also: DEFAULTS were never applied to # - now they are. New modifier -target to override TARGET.
⍝                          also incompatible change: to import *.APLA use the APL directive! DATA used to support this, but it now strictly reads file content and assigns it.
⍝                          Removed code for compatibility with old versions. DBuild/DTest 1.7 requires at least Dyalog v18.0.
⍝                          Various little tweaks in DBuild & DTest and its tools (for example, if -halt is used, Check will produce more verbose output & explanation).
⍝                          Renamed switch "-coco" to "-coverage"
⍝                          Support for "SuccessValue" in .dyalogtest file: in case tests would return boolean result instead of string. (see help for details)
⍝                                       SuccessValue defines the exact value which test return to indicate "success". Anything else will be interpreted as sign of failure.
⍝                          The values for the setup and teardown modifiers are now optional, so you can avoid running any by using the modifier w/o value (so -setup will run NO setups)
⍝                          Added Assert for "lighter" tests (details: https://github.com/Dyalog/DBuildTest/wiki/Assert)
⍝ 2022 07 01 MBaas, v1.71: made Log less verbose when msg type is provided;PerfStats now contain "raw" (unformatted) data which makes it easier to analyse
⍝ 2022 07 25 MBaas, v1.72: fixed issues with the workarounds of "0⎕SAVE problem" (refs from ⎕SE to #)
⍝ 2022 07 26 MBaas, v1.73: DBuild: dealt with error if wsid contains invalid path; minor addition to help for -prod flag
⍝ 2022 08 15 MBaas, v1.74: DBuild: addressed #11 (if prod is set, -quiet will default to 1 and -save to 0); shorter log for loading of files to avoid linebreaks;added check for valence of setup/teardown/test functions
⍝ 2022 08 26 MBaas, v1.75: DBuild & DTest: tweaked help texts. DBuild: the mechanism to use config parameters is more robust and supports alternate notations.
⍝ 2022 09 16 MBaas, v1.76: DTest: rearrenged code setup of "ns" for .dyalogest files (##.verbose; setup/test/teardown fns can also ne niladic now; result of setup was not tested against SuccessValue; fixed handling of CodeCoverage_Subject in test suites.
⍝ 2022 10 07 MBaas: v1.77: DTest: CodeCoverage tweaks
⍝ 2023 02 01 MBaas, v1.78: Assert: fixed bug if a failing test is not surrounded by documenting code; result is optional now; error logs also include details of .NET Exceptions
⍝ 2023 02 03 MBaas, v1.79: Assert also shows ⍺ and ⍵ (if their tally is 60 or below)
⍝ 2023 02 04 MBaas, v1.80: _cita._LogStatus ensures its ⍵ is scalar when it is numeric
⍝ 2023 04 28 MBaas, v1.81: Check: additional context info in msgs of failing checks - if -halt is set, we also display the calling line
⍝ 2023 05 10 MBaas, v1.82: DTest now counts and reports the number of "Checks" that were executed (calls of function Check)
⍝ 2023 05 20 MBaas, v1.83: DBuild: the icon-parameter of the target-directive may use "./" to indicate path relative to the location of the .dyalogbuild file
⍝ 2023 07 05 MBaas, v1.84: DBuild: added "nousource" directive and option for TARGET to save a dws w/o source (neccessary when building for Classic & Unicode!)
⍝ 2023 09 03 MBaas, v1.85: DBuild: now supports building StandaloneNativeExe on macOS and Linux as well (from v19.0 onwards). ]DTest -f= supports wildcards * and ?

    SuccessValue←''
    ⍝ does not get in as a var with v19s startup
    ∇ R←DEBUG
      R←⎕SE.SALTUtils.DEBUG ⍝ used for testing to disable error traps  ⍝ BTW, m19091 for that being "⎕se" (instead of ⎕SE) even after Edit > Reformat.
    ∇
    :Section Compatibility
    ⎕IO←1
    ⎕ML←1

    ∇ R←GetDOTNETVersion;vers;⎕IO;⎕USING
⍝ R[1] = 0/1/2: 0=nothing, 1=.net Framework, 2=NET CORE
⍝ R[2] = Version (text vector)
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
    ⍝ sets up ns "⎕se._cita' and define some tools for writing tests in it (and copy DSL into # or ns passed as argument)
    ⍝ a few essential ⎕N* Covers and the tools for CITA to write a log and a status file
      Init 2
      :If 0=⎕SE.⎕NC'_cita'
          names←'SetupCompatibilityFns' 'DyaVersion' 'APLVersion' 'isChar' 'Split' 'Init' 'GetDOTNETVersion'
          names,←'_Filetime_to_TS' 'Nopen'
          names,←'isWin' 'isChar' 'GetCurrentDirectory' 'unixfix' ⍝ needed by these tools etc.
          names,←'swise' 'refs'   ⍝ useful to deal with WS FULL
          names,←⊂'ListPost15'
          names,←'base64' 'base64dec' 'base64enc'
     
          '⎕se._cita'⎕NS names
          _cita.('⎕se._cita'⎕NS ⎕NL-3)
      :EndIf
      ⎕SE._cita.Init 2
      :If args≡''
          args←'#'
      :EndIf
      :Trap DEBUG↓0
          args ⎕NS'eis' 'base64' 'base64dec' 'base64enc'
      :EndTrap
      ⎕RL←⍬ 2  ⍝ CompCheck: ignore
     
      R←'───  Loaded tools into namespace ⎕se._cita ─── (WA=',(,'CI15'⎕FMT ⎕WA),' bytes) ───'
    ∇

    ∇ {sink}←SetupCompatibilityFns
      sink←⍬              ⍝ need dummy result here, otherwise getting VALUE ERROR when ⎕FX'ing namespace
     
      eis←{⊆⍵}
      table←⍪
      ltack←⊣
      rtack←⊢
      GetNumParam←{⍺←'0' ⋄ ⊃2⊃⎕VFI ⍺ GetParam ⍵}    ⍝ Get numeric parameter (0 if not set)
      where←⍸
      tally←≢                                         ⍝ CompCheck: ignore - leave it here for compatibility with old tests...
      lc←¯1∘⎕C                                              ⍝ lower case ⍝ CompCheck: ignore
      uc←1∘⎕C                                               ⍝ upper case ⍝ CompCheck: ignore
     
      GetFilesystemType←{⊃1 ⎕NINFO ⍵} ⍝ 1=Directory, 2=Regular file  ⍝ CompCheck: ignore
      ListFiles←{⍺←'' ⋄ ⍺ ListPost15 ⍵}
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


    ∇ r←{pattern}ListPost15 path
      :If 0=⎕NC'pattern'
      :OrIf pattern≡''
          pattern←''
      :Else
          path,←(~path[≢path]∊'\/')/'/'
      :EndIf
      r←⍉↑0 2 9 1(⎕NINFO ⎕OPT 1)(path,pattern) ⍝ CompCheck: ignore
      r[;4]←r[;4]=1
    ∇


    ∇ rslt←_Filetime_to_TS filetime;⎕IO
      :If 1≠0⊃rslt←FileTimeToLocalFileTime filetime(⎕IO←0)
      :OrIf 1≠0⊃rslt←FileTimeToSystemTime(1⊃rslt)0
          rslt←0 0                   ⍝ if either call failed then zero the time elements
      :EndIf
      rslt←1 1 0 1 1 1 1 1/1⊃rslt    ⍝ remove day of week
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

    ∇ {names}←{options}LoadCode file_target_mode;target;file;whatWeHave;f1;f2;f3;fl;fls;sep;sf;source;res;mode;larg;ref
    ⍝ loads code from scriptfile (NB: file points to one existing file, no pattern etc.)
    ⍝ Options defines SALT options
    ⍝ file_target_mode: (filename )
    ⍝ res: nested vector of names that were defined
      names←0⍴⊂''
      →(0=≢file_target_mode)/0  ⍝ gracefully treatment of empty calls
      :If 2=≢file_target_mode ⋄ file_target_mode←file_target_mode,⊂'apl' ⋄ :EndIf
      (file target mode)←file_target_mode
      :If 0=⎕NC'options'
          options←''
      :EndIf
      :If target≢''         ⍝ if we have a target
      :AndIf 9≠⎕NC'target'  ⍝ and it's not a ref
      :AndIf 0=⎕NC target   ⍝ and doesn't even exist yet
          target ⎕NS''      ⍝ THEN we create it!
      :EndIf
      options←' ',options
     
      (f1 f2 f3)←⎕NPARTS file
      ⍝ filenames may contain wildcards - which isn't so useable with Link.Import.
      ⍝ So we resolve them and work through the list, processing every file as good as we can
      ⍝ but List may not be the right tool to do that because it does not give us a filename with extension - so we can't recognize -.apla!
      ⍝ OTOH, a default DIR lister would not search the SALT libraries etc.
     
      ⍝ search the specified file in the source folder and SALT's workdir  (emulate SALT.Load here)
      sep←'∘',(1+isWin)⊃':' ';'     ⍝ separator for those paths...
     
      :For sf :In (⊂f1),sep Split ⎕SE.SALT.Settings'workdir'
          :If ~(⊃⌽sf)∊'\/'
              sf,←⎕SE.SALT.FS
          :EndIf
          :If 0<⍬⍴⍴fls←(ListFiles sf,f2,f3)[;1]
              :For fl :In fls
                  :If 'data'≡lc mode
                      res←1⊃⎕NGET fl 1
                      names,←⊂fl res
                  :Else  ⍝ mode≡pl
                      :Select lc 3⊃⎕NPARTS fl
                      :CaseList '.dyalog' '.aplc' '.aplf' '.apln' '.aplo' '.apli'
                          :Trap DEBUG↓0 ⍝↓↓↓↓ be sure to pass target as a ref, bad things may happen otherwise ()
                              :If {(1=≢⍵)∧⊃1↑,⍵}~(⎕NC⍕target)∊0 9  ⍝ deal with name clashes
                              :AndIf (,'#')≢,⍕target
                                  ('target="',(⍕target),'" exists already with ⎕NC=',(⍕⎕NC target),' and is protected')⎕SIGNAL(∨/' -protect'⍷options)/11
                                  ⎕EX target
                              :EndIf
                              ref←{0::⍵ ⋄ ⍎⍵}target
                              res←2 ref.⎕FIX'file://',fl
                          :Else
                              res←'*** Error executing "⎕SE.SALT.Load ',fl,' -target=',(⍕target,options),'": ',NL
                              res,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')   ⍝ CompCheck: ignore
                          :EndTrap
                          res ⎕SIGNAL('***'≡3↑⍕res)/11
                          names,←⊂res
                      :Case '.apla'
                          :If 9=⎕SE.⎕NC'Link'
                          :AndIf 3=⎕SE.Link.⎕NC'Import'
                              :Trap DEBUG↓0
                                  {}⎕SE.Link.Import(⍎target)(fl)
                              :Else
                                  res←'*** Error executing Link.Import (',target,') ',fl,':'
                                  res,←⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')      ⍝ CompCheck: ignore
                                  res ⎕SIGNAL 11
                              :EndTrap
                              names,←⊂({2 6::{2 6::⍵ ⋄ ⎕SE.Link.StripCaseCode 2⊃⎕NPARTS ⍵}⍵ ⋄ ⎕SE.Link.U.StripCaseCodePart ⍵}2⊃⎕NPARTS fl)     ⍝ CompCheck: ignore
                          :Else
                              ('*** We need ]LINK to import ',fl)⎕SIGNAL 11
                          :EndIf
                      :EndSelect
                  :EndIf
              :EndFor
          :EndIf
          :If ~0∊⍴names         ⍝ if we found any names
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
      refs←{                              ⍝ Vector of sub space references for ⍵.
          ⍺←⍬ ⋄ (⍴,⍺)↓⍺{                  ⍝ default exclusion list.
              ⍵∊⍺:⍺                       ⍝ already been here: quit.
              ⍵.(↑∇∘⍎⍨/⌽(⊂⍺∪⍵),↓⎕NL 9)    ⍝ recursively traverse any sub spaces.
          }⍵                              ⍝ for given starting ref.
      }

      swise←{         ⍝ Space wise
          ⍺⍺¨refs ⍵   ⍝ Apply to each space
      }

    ⍝─── these functions are removed with v1.7 - but in this release we'll issue a DEPRECATED msg when they are called (so that anyone that uses them becomes aware of needed update...)
    qNDELETE←qNEXISTS←qNGET←qMKDIR←qNPARTS←qJSON←qJSONi←qJSONe←qPUT←ListPre15←{((1⊃⎕SI),' is deprecated with DBuildTest 1.7 - please use native functions instead or v1.33 which still supports these')⎕SIGNAL 6}
    ⍝ need to replace niladic _FindDefine with a tradfn:
    ⎕fx'_FindDefine' '((1⊃⎕si),'' is deprecated with DBuildTest 1.7 - please use native functions instead or v1.33 which still supports these'')⎕signal 11'    ⍝ niladic function...
    :endSection Compatibility

    :Section ADOC

    ∇ t←Describe
      t←1↓∊(⎕UCS 10),¨{⍵/⍨∧\(⊂'')≢¨⍵}Comments ⎕SRC ⎕THIS ⍝ first block of non-empty comment lines   ⍝ CompCheck: ignore
    ∇

    ∇ (n v d)←Version;f;s;z
    ⍝ Version of DBuildTest (3 elems: name version date)
      s←⎕SRC ⎕THIS                  ⍝ appearently this only works in V16+
      f←Words⊃s                     ⍝ split first line
      n←2⊃f                         ⍝ ns name
      v←'.0',⍨'V'~⍨⊃⌽f              ⍝ version number
      d←1↓∊'-',¨3↑Words{w←⎕VFI¨⍵ ⋄ ⍵⊃⍨⊃{(,⍵)/,⍳⍴⍵}∊(∧/¨3↑¨1⊃¨w)}⌽Comments s ⍝ date (sorry, extra complicated - but getting date from last comment that has one)
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
      ⍝ numeric version (maj.min) of DBuildTest (for comparison against the min. version given in the Dyalogtest element of a .dyalogtest)
      R←2⊃⎕VFI{(2>+\⍵='.')/⍵}2⊃Version
    ∇

    Split←{dlb¨1↓¨(1,⍵∊⍺)⊂(⊃⍺),⍵}                       ⍝ Split ⍵ on ⍺, and remove leading blanks from each segment
    sSplit←{dlb¨1↓¨(1,(0=2|+\⍵='"')∧⍵∊⍺)⊂(⊃⍺),⍵}                  ⍝ string safe split (does not confused by stuff enclosed in quotes)
    Splitb←{     1↓¨(1,⍺)⊂'.',⍵}                        ⍝ Split of ⍵ where ⍺=1 (no dlb)
    SplitFirst←{dlb¨1↓¨(1,<\⍵=⍺)⊂⍺,⍵}                   ⍝ Split ⍵ on first occurence of ⍺, and remove leading blanks from each segment
    GetParam←{⍺←'' ⋄ dtb dlb(⌊/names⍳eis ⍵)⊃values,⊂⍺}  ⍝ Get value of parameter
    dlb←{(∨\' '≠⍵)/⍵}                                   ⍝ delete leading blanks
    dtb←{(-{⍵⊥⍵}⍵=' ')↓⍵}                               ⍝ delete trailing blanks (DB)
    null←0                                              ⍝ UCMD switch not specified
    whiteout←{w←⍵ ⋄ ((w=⎕UCS 9)/w)←' ' ⋄ w}             ⍝ convert whitespace to space
    isChar ←{0 2∊⍨10|⎕DR ⍵}                             ⍝ determine if argument's datatype is character
    _hasBitSet←{t←8⍴2 ⋄ 0<+/(t⊤⍺)∧t⊤⍵}                  ⍝ deal with bit flags (hardcoded maximum is 8)

    WIN←⎕SE.SALTUtils.WIN                               ⍝ running under Windows1

    ∇ r←∆CSV args;z;file;encoding;coltypes;num
    ⍝ Primitive ⎕CSV for pre v16
    ⍝ No validation, no options
      :Trap 2 ⍝ Syntax Error if ⎕CSV not available
          r←⎕CSV args  ⍝ CompCheck: ignore
      :Else
          (file encoding coltypes)←args
          z←1⊃⎕NGET file
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
          _isCITA←~0∊⍴2 ⎕NQ'.' 'GetEnvironment' 'CITATEST'
          _DotNet←1⊃GetDOTNETVersion
          NL←⎕UCS 10,⍨isWin/13
      :EndIf
      :If lvl≥2
          SetupCompatibilityFns ⍝ dedicated function avoid unneccessary execution of that code when loading the UCMD
      :EndIf
    ∇

    ∇ r←base64 w
        ⍝ from dfns workspace
      r←{⎕IO ⎕ML←0 1             ⍝ Base64 encoding and decoding as used in MIME.
          chars←'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
          bits←{,⍉(⍺⍴2)⊤⍵}                   ⍝ encode each element of ⍵ in ⍺ bits,
                                                 ⍝   and catenate them all together
          part←{((⍴⍵)⍴⍺↑1)⊂⍵}                ⍝ partition ⍵ into chunks of length ⍺
          0=2|⎕DR ⍵:2∘⊥∘(8∘↑)¨8 part{(-8|⍴⍵)↓⍵}6 bits{(⍵≠64)/⍵}chars⍳⍵
                                       ⍝ decode a string into octets
          four←{                             ⍝ use 4 characters to encode either
              8=⍴⍵:'=='∇ ⍵,0 0 0 0           ⍝   1,
              16=⍴⍵:'='∇ ⍵,0 0               ⍝   2
              chars[2∘⊥¨6 part ⍵],⍺          ⍝   or 3 octets of input
          }
          cats←⊃∘(,/)∘((⊂'')∘,)              ⍝ catenate zero or more strings
          cats''∘four¨24 part 8 bits ⍵
      }w
    ∇

    ∇ b64←base64enc txt
      b64←base64'UTF-8'⎕UCS txt
    ∇

    ∇ txt←base64dec b64
      txt←'UTF-8'⎕UCS base64 b64
    ∇
    :EndSection ────────────────────────────────────────────────────────────────────────────────────

    :Section TEST "DSL" FUNCTIONS

    ∇ {r}←l Assert b;cl;cc;t;v;nr;z
      nr←1↓⎕NR 2⊃⎕SI
      cl←⎕LC[2]⊃nr  ⍝ the current line
      :If verbose ⍝ look for "verbose" in current ns or its parent
          ⎕←cl
      :EndIf
      →(l Check b)↓r←0
      t←nr[(⍳≢nr)∩⎕LC[2]-0 1 ¯1]     ⍝ search exactly these 3 lines, avoiding INDEX ERRORs
      t←('⍝(.*)'⎕S'\1'⎕OPT('Mode' 'L'))t  ⍝ search for text of comments
      cc←(¯1+cl⍳'⍝')↑cl
      v←''
      :If 60≥≢⍕l
      :AndIf 60≥≢⍕b
          v←((⎕UCS 10),' left ',{'arg = "',(⍕⍵),'", ⎕DR=',(⍕⎕DR ⍵),', rho=',⍕⍴⍵}l),⎕UCS 10
          v,←('right ',{'arg = "',(⍕⍵),'", ⎕DR=',(⍕⎕DR ⍵),', rho=',⍕⍴⍵}b),⎕UCS 10
      :EndIf
      :If ∨/z←cc=⎕AV[60]  ⍝ look for right tack as separator between reason & test (not using symbol directly )
      :OrIf ∨/z←'IfNot'⍷cc
          t←(¯1+⊃##.where z)↑cc
          t←(1⊃⎕RSI)⍎t
          (t,v)⎕SIGNAL 777
      :ElseIf 0=≢t   ⍝ no comment found on or around the crashing line
      :OrIf ∨/(1⊃t)⍷cl  ⍝ don't add comment if it is on the line of the test!
          v ⎕SIGNAL 777
      :ElseIf 0<≢1⊃t
          ((1⊃t),v)⎕SIGNAL 777
      :Else
          v ⎕SIGNAL 777
      :EndIf
    ∇


      IfNot←{
          r←~⍵
          r/⍺
      }

    ∇ r←Test args;TID;timeout;ai;nl;i;quiet
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

    ∇ XTest args;⎕TRAP;start;source;ns;files;f;z;fns;filter;verbose;LOGS;LOGSi;steps;setups;setup;DYALOG;WSFOLDER;suite;halt;m;v;sargs;overwritten;type;TESTSOURCE;extension;repeat;run;quiet;setupok;trace;matches;t;orig;nl∆;LoggedErrors;i;start0;nl;templ;base;WSFULL;msg;en;off;order;ts;timestamp;home;CoCo;r1;r2;tie;tab;ThisTestID;ignore;loglvl;logBase;logFile;log;∆OldLog;file;res;subj;j;pre;rc
      i←quiet←0
      ⍝ Not used here, but we define them test scripts that need to locate data:
      ∆OldLog←⎕SE ⎕WG'Log'
      DYALOG←2 ⎕NQ'.' 'GetEnvironment' 'DYALOG'
      WSFOLDER←⊃⎕NPARTS ⎕WSID
      ThisTestID←(,'ZI4,<->,ZI2,<->,ZI2,<->,ZI2,<:>,ZI2,<:>,ZI3'⎕FMT 1 6⍴⎕TS),' *** DTest ',2⊃Version
      LOGSi←LOGS←3⍴⊂''   ⍝ use distinct variables for initial logs and test logs
     
      (verbose filter halt quiet trace timestamp order)←args.(verbose filter halt quiet trace ts order)
      :If (,quiet)≢(,1)
          ⎕←ThisTestID  ⍝ this MUST go into the session because it marks the start of this test (useful to capture session.log later!)
      :EndIf
     
      repeat←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.repeat
      loglvl←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.loglvl
      off←{~isChar ⍵:⍵ ⋄ ⍬⍴2⊃⎕VFI ⍵}args.off
      :If halt
          ⎕TRAP←0 'S'
      :EndIf ⍝ Defeat UCMD trapping
     
      repeat←1⌈repeat
      file←''
      args.coverage_subj←null
      args.coverage_ignore←⍕⎕THIS
      WSFULL←0  ⍝ indicates if we were hit by WS FULL
      ⎕SE.DTEST_COUNTER_OF_CALLS_TO_CHECK←0
     
     
      :If 0∊⍴args.Arguments
      :AndIf 9≠#.⎕NC source←⊃args.Arguments←,⊂'Tests'
          r←'An argument is required - see ]dtest -? for more information.' ⋄ →0
      :ElseIf 9=#.⎕NC source←1⊃args.Arguments ⍝ It's a namespace
          ns←#⍎source
          TESTSOURCE←⊃1 ⎕NPARTS''
          base←source
      :Else                               ⍝ Not a namespace
          :If ⎕NEXISTS f←source           ⍝ Argument is a file
          :OrIf ⎕NEXISTS f←source,'.dyalogtest'
          :OrIf ⎕NEXISTS f←WSFOLDER,source
          :OrIf ⎕NEXISTS f←WSFOLDER,source,'.dyalogtest'
          :OrIf ⎕NEXISTS f←WSFOLDER,'Tests/',source
          :OrIf ⎕NEXISTS f←WSFOLDER,'Tests/',source,'.dyalogtest'
          :OrIf ⎕NEXISTS f←∊1 ⎕NPARTS source                     ⍝ deal with relative names for folders
          :OrIf ⎕NEXISTS f←∊1 ⎕NPARTS source,'.dyalogtest'       ⍝ or individual tests
              file←f  ⍝ assign this variable which is needed by LogError
              (TESTSOURCE z extension)←1 ⎕NPARTS f
              base←z
              'ns'⎕NS''    ⍝ create temporary namespace to run tests in
              :If 2=type←GetFilesystemType f  ⍝ it's a file
                  :If '.dyalogtest'≡lc extension ⍝ That's a suite
                      :If null≡args.suite
                          args.suite←f
                      :EndIf
                      f←¯1↓TESTSOURCE ⋄ type←1 ⍝ Load contents of folder
                  :Else                          ⍝ Arg is a source file - load it
                      :If filter≢null
                          LogTest'Can''t run test with file argument AND -filter switch!'
                          LOGSi←LOGS
                          →FAIL
                      :EndIf
                      :Trap (DEBUG∨halt)↓0
                          filter←∊LoadCode source ns
                          :If args.tests≡0
                              args.tests←filter  ⍝ transfer into tests, as filtering could be ambigous and we wouldn't want to run more than required...
                          :EndIf
                          f←¯1↓TESTSOURCE ⋄ type←1 ⍝ Load contents of folder
                      :Else
                          msg←'Error loading test from folder "',source,'"',NL
                          LogError msg,⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                          →endPrep1
                      :EndTrap
                  :EndIf
              :EndIf
     
              :If 1=type  ⍝ deal with directories in f
                  TESTSOURCE←f,(~'/\'∊⍨⊃⌽f)/⎕SE.SALTUtils.FS ⍝ use it accordingly! (and be sure it ends with dir sep)
                  files←('*.dyalog'ListFiles f)[;1]
                  files,←('*.aplf'ListFiles f)[;1]    ⍝ .aplf extension!
                  :For f :In files
                      :Trap (DEBUG∨halt)↓0
                          LoadCode f ns
                      :Else
                          msg←'Error loading code from file "',f,'"'
                          LogError msg,⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                      :EndTrap
                  :EndFor
                  ⍝:if null≡args.tests
                  ⍝ args.tests←ns.⎕nl¯3
                  ⍝ :endif
                  :If verbose
                      0 Log(⍕1↑⍴files),' file',('s'/⍨1<≢files),' loaded from ',source
                  :EndIf
                  :If null≡args.suite  ⍝ if no suite is given
                      :If null≡args.setup
                          v←('setup_'⍷↑nl)[;1]/nl←ns.⎕NL-3
                          :If 1<≢v  ⍝ are there even multiple setups?
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
              :AndIf ∧/0<∊⍴¨1↑¨(TESTSOURCE z extension)←1 ⎕NPARTS source  ⍝ did user give a file spec? then try to create it!
                  :If ~⎕NEXISTS TESTSOURCE   ⍝ does directory exist?
                      {}3 ⎕MKDIR TESTSOURCE
                  :EndIf
                  :If '.dyalogtest'≡lc extension
                      templ←('DyalogTest : ',2⊃Version)'ID         :' 'Description:' '' 'Setup   :' 'Teardown:' '' 'Test:'
                  :Else
                      templ←('r←',z,' dummy;foo')'r←''''' ':If .. Check ..'('      →0 Because ''test failed'' ⋄ :EndIf')
                  :EndIf
                  (⊂templ)⎕NPUT source
                  Log'Initialised ',source
                  →0
              :EndIf
              :If halt  ⍝ we found an error and need to stop
                  ⎕←'"',source,'" is neither a namespace nor a folder or a .dyalogtest file.'
                  (⎕LC[1]+1)⎕STOP 1⊃⎕SI
              :EndIf
              LogTest'"',source,'" is neither a namespace nor a folder or a .dyalogtest file.'
              (TESTSOURCE base)←2↑1 ⎕NPARTS source
              LOGSi←LOGS
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
                  0 Log'*** warning - test suite overridden by modifiers: ',,⍕overwritten
              :EndIf
          :EndIf
      :EndIf
     
      :If args.SuccessValue≢0
          SuccessValue←{0::⍵ ⋄ ⍎⍵}args.SuccessValue
      :EndIf
      SuccessValue←{
          'json!'≡⎕C 5↑⍵:∇ ⎕JSON 5↓⍵
          'apl!'≡⎕C 4↑⍵:∇⍎4↓⍵
          'b64!'≡⎕C 4↑⍵:∇ base64dec 4↓⍵
          ⍵
      }SuccessValue
    ⍝ Establish test DSL in the namespace
    ⍝   :If halt=0
    ⍝       ns.Check←≢   ⍝ CompCheck: ignore
    ⍝   :Else
      'ns'⎕NS'Check'
    ⍝   :EndIf
      'ns'⎕NS'Because' 'Fail' 'IsNotElement' 'RandomVal' 'tally' 'eis' 'Assert' 'IfNot' 'base64' 'base64dec' 'base64enc'
      ⍝ transfer some status vars into ns
      'ns'⎕NS'verbose' 'filter' 'halt' 'quiet' 'trace' 'timestamp' 'order' 'off'
     
      ns.Log←{⍺←{⍵} ⋄ ⍺ ##.LogTest ⍵}  ⍝ ⍺←rtack could cause problems with classic...
      :If args.tests≢0
          orig←fns←(','Split args.tests)~⊂''
          nl←ns.⎕NL ¯3
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
      :Else ⍝ No functions selected - run all named test_*
          fns←{⍵⌿⍨(⊂'test_')≡¨5↑¨⍵}ns.⎕NL-3
          :If 0=≢fns
              LogError'*** no functions match pattern "test_*"'
              LOGSi←LOGS
              →FAIL
          :EndIf
      :EndIf
      filter←{w←⍵ ⋄ ~∨/'?*'∊⍵: ⍵ ⋄ ((w='?')/w)←'.' ⋄ ((w='*')/w)←⊂'.*' ⋄ ∊⍵}filter
      :If null≢filter
      :AndIf 0∊⍴fns←(0<≢filter∘{(⍺⎕s'&')⍵}¨fns)/fns
          LogError'*** no functions match filter "',filter,'"'
          LOGSi←LOGS
          →FAIL
      :EndIf
     
      :If null≢setups←args.setup
          setups←' 'Split args.setup
      :EndIf
     
      r←''  ⍝ must be global here, is localized in the calling fn
      start0←⎕AI[3]
      :Select ,order
      :Case ,0  ⍝ order=0: random (or reproduce random from file)
          order←(('order',⍕≢fns)RandomVal 2⍴≢fns)∩⍳≢fns
      :Case ,1
          order←⍳≢fns   ⍝ 1: sequential
      :Else
          order←order{(⍺∩⍵),⍵~⍺}⍳≢fns  ⍝ numvec: validate and use that order (but make sure every test gets executed!)
      :EndSelect
      LOGSi←LOGS
      :For run :In ⍳repeat
          :If verbose∧repeat>1
              0 Log'run #',(⍕run),' of ',⍕repeat
          :EndIf
          :For setup :In (,setups)[('setups',⍕≢setups)RandomVal 2⍴≢setups]   ⍝ randomize order of setups
              steps←0
              start←⎕AI[3]
              LOGS←3⍴⊂''
              :If verbose
              :AndIf setup≢null
              :AndIf setup≢,1
                  r,←⊂'For setup = ',setup
              :EndIf
              :If ~setupok←(⊂f←setup)∊(,1)null
                  :If 3=ns.⎕NC f ⍝ function is there
                      :If verbose
                          0 Log'running setup: ',f
                      :EndIf
                      (trace/1)ns.⎕STOP f
                      :Trap (~halt∨trace)/0
                          :If 0=1 2⊃ns.⎕AT f   ⍝ niladic setup
                              f LogTest z←ns⍎f
                          :Else
                              f LogTest z←(ns⍎f)⍬
                          :EndIf
                          setupok←z≡SuccessValue
                      :Else
                          msg←'Error executing setup "',f,'": '
                          msg,←(⎕JSON ⎕OPT'Compact' 0)⎕DMX
                          :If 90=⎕EN
                              :Trap 0
                                  msg,'** Exception details: ',⍕⎕EXCEPTION
                              :EndTrap
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
              :If null≢args.coverage ⍝ if switch is set
              :AndIf (1↑1⊃⎕VFI⍕args.coverage)∨1<≢args.coverage  ⍝ and we have either numeric value for switch or a longer string
              :AndIf 0=⎕NC'CoCo'   ⍝ only neccessary if we don't have an instance yet...
                  :If 9=⎕NC'SALT_Data'
                      home←1⊃⎕NPARTS SALT_Data.SourceFile  ⍝ CompCheck: ignore
                  :Else
                      home←1⊃⎕NPARTS 50 ⎕ATX 1⊃⎕SI
                  :EndIf
                  :If 0≠⊃z←home _cita.LoadCodeCoverage(⍕⎕THIS)
                      LogError'Problem loading CodeCoverage: ',2⊃z
                      setupok←0
                      →END
                  :EndIf
                  :If null≡subj←args.coverage_subj
                      :If 0<≢subj←#.⎕NL ¯9
                          subj←∊(⊂'#.'),¨subj,¨','
                      :EndIf
                      subj,←(⍕ns),','
                      subj←¯1↓subj
                  :EndIf
                  CoCo←⎕NEW CodeCoverage(,⊂subj)
                  CoCo.Info←'Report created by DTest ',(2⊃Version),' which was called with these arguments: ',⊃¯2↑⎕SE.Input
                  :If 1<≢args.coverage
                  :AndIf (⎕DR' ')=⎕DR args.coverage
                      :If ∨/'\/'∊args.coverage  ⍝ if the argument looks like a filename (superficial test)
                          CoCo.filename←args.coverage
                      :Else                  ⍝ otherwise we assume it is the name of the instance of an already running coverag-analysis
                          CoCo.filename←(⍎args.coverage).filename
                      :EndIf
                      CoCo.NoStop←1
                  :Else
                      CoCo.filename←(739⌶0),,'</CoCoDTest_>,ZI4,ZI2,ZI2,ZI2,ZI2,ZI3'⎕FMT 1 6⍴⎕TS
                      CoCo.NoStop←0
                  :EndIf
                  :If 0=≢ignore←args.coverage_ignore
                          ⍝ignore←∊(⊂⍕⎕THIS),¨'.',¨(⎕THIS.⎕NL ¯3 4),¨','
                      ignore←∊{(⊂⍕⍵),¨'.',¨(⍵.⎕NL ¯3 4),¨','}⎕SE.input.c
                  :EndIf
                  ignore,←(((0<≢ignore)∧','≠¯1↑ignore)⍴','),¯1↓∊(⊂(⍕⎕THIS),'.ns.'),¨('Check' 'Because' 'Fail' 'IsNotElement' 'RandomVal' 'tally' 'eis' 'Log' 'Assert' 'IfNot')
                  CoCo.ignore←ignore
                  CoCo.Start ⍬
              :EndIf
     
     
              :If verbose
              :AndIf 1<≢fns
                  0 Log'running ',(⍕1↑⍴fns),' tests'↓⍨¯1×1=↑⍴fns
              :EndIf
              :For f :In fns[order]
                  steps+←1
                  :If verbose
                      0 Log'running: ',f
                  :EndIf
                  (trace/1)ns.⎕STOP f
                  :Trap (~halt∨trace)/0
                      :If 0=1 2⊃ns.⎕AT f
                          f LogTest(ns⍎f)
                      :Else
                          f LogTest((ns⍎f)⍬)    ⍝ avoid additional line with title of function
                      :EndIf
                  :Case 777 ⍝ Assertion failed
                      f LogTest'Assertion failed: ',,∊⎕DMX.DM[⍳2],¨⊂NL
                  :Else
                      en←⎕EN  ⍝ save error no before it gets overwritten
                      msg←'Error executing test "',f,'": '
                      msg,←(⎕JSON ⎕OPT'Compact' 0)⎕DMX             ⍝ CompCheck: ignore
                      :If WSFULL←en=1   ⍝ special handling for WS FULL
                          msg,←NL,'⎕WA=',(⍕⎕WA)
                          msg,←NL,'The 20 largets objects found in the workspace:',NL
                          :Trap 1
                              res←⊃⍪/{((⊂⍕⍵),¨'.',¨↓nl),[1.5]⍵.⎕SIZE nl←⍵.⎕NL⍳9}swise ns  ⍝ CompCheck: ignore
                              res←res[(20⌊1↑⍴res)↑⍒res[;2];]
                              msg←msg,∊((↑res[;1]),'CI18'⎕FMT res[;,2]),⊂NL
                          :Else
                              msg,←'Error while generating that report: ',NL,∊⎕DMX.DM,¨⊂NL
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
                      (trace/1)ns.⎕STOP f
                      :Trap (~halt∨trace)/0 777
                          :If 0=1 2⊃ns.⎕AT f
                              f LogTest(ns⍎f)
                          :Else
                              f LogTest(ns⍎f)⍬
                          :EndIf
                      :Else
                          msg←'Error executing teardown "',f,'" :'
                          msg,←(⎕JSON ⎕OPT'Compact' 0)⎕DMX             ⍝ CompCheck: ignore
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
                  r,←(quiet≡null)/⊂'   ',(((setup≢null)∧1≠1↑⍴setups)/setup,': '),(⍕steps),' test',((1≠steps)/'s'),' (=',(⍕⎕SE.DTEST_COUNTER_OF_CALLS_TO_CHECK),' calls to "Check" or "Assert") passed in ',(1⍕0.001×⎕AI[3]-start),'s'
                  1(⎕NDELETE ⎕OPT'Wildcard' 1)TESTSOURCE,'*.rng.txt' ⍝ delete memorized random numbers when tests succeeded
              :Else
                  r,←⊂' Time spent: ',(1⍕0.001×⎕AI[3]-start),'s'
              :EndIf
          :EndFor ⍝ Setup
      :EndFor ⍝ repeat
      r,←((1<≢setups)∧quiet≡null)/⊂'Total Time spent: ',(1⍕0.001×⎕AI[3]-start0),'s'
      :If ~0∊⍴3⊃LOGS
      :AndIf ~0∊⍴order
          r,←⊂'-order="',(⍕order),'"'
      :EndIf
      :If args.coverage≢null
          :If 9=⎕NC'CoCo'
            ⍝   :If 0=CoCo.⎕NC'NoStop'
            ⍝   :OrIf CoCo.NoStop=0
              CoCo.Stop ⍬ ⍝ must stop anyway, as this would gather data and write it to file
            ⍝   :EndIf
              r1←CoCo.Finalise ⍬
              ⎕EX'r2'
              :If args.coverage≡1    ⍝ if we had a "simple run" (not collected into a file)
                  r2←CoCo.(1 ProcessDataAndCreateReport filename)   ⍝ we can now process data from that run-...
              :EndIf
              tie←r1 ⎕FSTIE 0
              tab←⎕FREAD tie,10
              ⎕FUNTIE tie
              CoCo.res←res←⌊0.5+100×÷/+⌿≢¨tab[;2 4]
              r,←⊂⎕←'Coverage = ',(⍕res),'%'
              :If 2=⎕NC'r2'    ⍝ if we have processed data
                  r,←⊂']open ',r2,'     ⍝ to see coverage details...'    ⍝ let the user see it!
              :EndIf   ⍝ otherwise the calling environment will have tu use shared CoCo.AggregateCoverageDataAndCreateReport
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
              :If (⎕DR' ')=⎕DR args.testlog
              :AndIf 0<≢args.testlog
                  logFile←args.testlog
                  :If ''≡1⊃⎕NPARTS logFile
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
     
          logBase←({∊(1⊃⎕NPARTS ⍵),{⍵[⍳¯1+⍵⍳'.']}∊1↓⎕NPARTS ⍵}logFile),'.'
          :If (loglvl _hasBitSet 16)∧0<⍴3⊃LOGS
          :OrIf loglvl _hasBitSet 8
              log←⎕SE ⎕WG'Log'
              ⍝ use progressive iota to find new log in old log and remove the common parts (simple ∊ is not good enough...)
            ⍝   z←+/∧\{⍵=⍵[1]+0,⍳¯1+≢⍵}∆OldLog{((≢⍺)⍴⍋⍋⍺⍳⍺⍪⍵)⍳(≢⍵)⍴⍋⍋⍺⍳⍵⍪⍺}log
              z←∆OldLog _cita.NrOfCommonLines log
              log←z↓log
              log←∊log,¨⊂NL
     
            ⍝   :If 0<≢i←{⍵/⍳tally ⍵}ThisTestID⍷log
            ⍝       log←(i-1)↓log
            ⍝   :EndIf
              (⊂log)⎕NPUT(logBase,'session.log')1
          :EndIf
     
          :For j :In ⍳2
              :If ~0∊⍴j⊃LOGS
                  :If loglvl _hasBitSet j⊃2 4
                      (⊂i⊃LOGS)⎕NPUT logBase,(j⊃'info.log' 'warn.log')
                  :EndIf
              :EndIf
          :EndFor
     
          :If loglvl _hasBitSet 32
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
              (⊂(⎕JSON ⎕OPT('Compact' 0)('HighRank' 'Split'))res)⎕NPUT(logFile,'.json')1  ⍝ CompCheck: ignore
          :EndIf
     
          :If ~0∊⍴3⊃LOGS
          :AndIf (off>0)∨loglvl _hasBitSet 1
              ⎕←'Errors were collected - writing them to logFile',(off=1)/' before doing ⎕OFF ',⍕21+WSFULL
              :Trap 0
                  (⊂∊(3⊃LOGS),¨⊂NL)⎕NPUT logFile 1
              :Else
                  ⎕←'Error writing logFile'
                  ⎕←(⎕JSON ⎕OPT'Compact' 0)⎕DMX
              :EndTrap
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

    ∇ line←line Because msg;si;fn
     ⍝ set global "r", return branch label
      :If 0=⎕NC'r'
          r←''
      :EndIf
      si←''
      :If 0=≢fn←('((?!\d)[\wÀ-ÖØ-Ýßà-öø-üþ∆⍙\x{24b6}-\x{24cf}]+)\[\d+]'⎕S'\1')msg  ⍝ anything looking like function[lc] already in msg? (rx by AB)
      :AndIf ~3∊∊⎕NC¨fn                     ⍝ then do not include it again...
          si←(2⊃⎕SI),'[',(⍕2⊃⎕LC),']: '
      :EndIf
      r←r,((~0∊≢r)/⎕UCS 10),si,msg
    ∇

    ∇ r←expect Check got
      ⎕SE.DTEST_COUNTER_OF_CALLS_TO_CHECK+←1
      :If r←expect≢got
      :AndIf ##.halt
          ⎕←' TEST SUSPENDED! ───────────────────────────────────────────────────────────'
          ⎕←'expect≢got:'
          :If 200≥⎕SIZE'expect'
              ⎕←'expect=',,expect
          :Else
              ⎕←'expect   ⍝ left argument of "Check"-call'
          :EndIf
          :If 200≥⎕SIZE'got'
              ⎕←'got=',,got
          :Else
              ⎕←'got      ⍝ did not match right argument - examine variables or <Esc> into calling function'
          :EndIf
          :Trap 3
            ⍝ INDEX ERROR possible if we can't get the ⎕NR (for example, if called by a class member) - though this should be fixed now...
              ⎕←(2⊃⎕SI),'[',(⍕2⊃⎕LC),'] ',##.dtb(1+2⊃⎕LC)⊃↓(2⊃⎕RSI).(180⌶(2⊃⎕SI))
          :EndTrap
          (1+⊃⎕LC)⎕STOP 1⊃⎕SI ⍝ stop in next line
          ⍝ test failed! Execution suspended so that you can examine the problem...
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
          ⍝ test failed! Execution suspended so that you can examine the problem...
      :EndIf
    ∇

    ∇ R←{ctxt}RandomVal arg;rFile;r
⍝ generate random values
      :If 0=⎕NC'ctxt'
          ctxt←⎕SI[2 3]{(1⊃⍺),'_',(1⊃⍵),'_',(2⊃⍺),'_',2⊃⍵}⍕¨⎕LC[2 3]
      :EndIf  ⍝ use ⎕SI as indicator of context
      rFile←TESTSOURCE,ctxt,'.rng.txt'    ⍝ name of rng file
      :If ⎕NEXISTS rFile         ⍝ found one - so reuse those numbers (instead of creating new series)
          r←∊1⊃⎕NGET rFile
          (((⎕UCS r)∊10 13)/r)←' '
          R←2⊃⎕VFI r
      :Else
          :If 1<≢arg
              R←arg[2]?arg[1]
          :Else
              R←?arg
          :EndIf
          (⍕R)Put rFile   ⍝ "remember" the generated numbers
      :EndIf
    ∇


    ∇ res←LoadTestSuite suite;setups;lines;i;cmd;params;names;values;tmp;f;args;path
      :If 0=≢1⊃⎕NPARTS suite
          suite←TESTSOURCE,suite
      :ElseIf '.'≡1⊃1⊃⎕NPARTS suite ⍝ deal with relative paths
          :If '.'≡1⊃1⊃⎕NPARTS TESTSOURCE   ⍝ if suite and source are relative, ignore suite's relative folder and use SOURCE's...
              suite←∊(1 ⎕NPARTS TESTSOURCE),1↓⎕NPARTS suite
          :Else
              suite←∊1 ⎕NPARTS TESTSOURCE,suite
          :EndIf
      :EndIf      ⍝ default path for a suite is the TESTSOURCE folder
      :If ''≡3⊃⎕NPARTS suite
          suite←suite,'.dyalogtest'
      :EndIf   ⍝ default extension
     
      :If ⎕NEXISTS suite
          lines←⊃⎕NGET suite 1
      :Else
          args←,⊂'Test suite "',suite,'" not found.' ⋄ res←0,args ⋄ →0
      :EndIf
      lines←dtb¨↓rmcm↑lines
      args←⎕NS''
      ⎕RL←2  ⍝ CompCheck: ignore ⍝ use O/S rng
      path←1⊃1 ⎕NPARTS suite
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
                  args.coverage_subj←params
              :Case 'codecoverage_ignore'
                  args.coverage_ignore←params
              :Case 'alertifcoveragebelow'
                  args.alertifcoveragebelow←2⊃⎕VFI params
              :Case 'successvalue'
                  args.SuccessValue←params
                ⍝   ⎕←'args.SuccessValue was set to ',params
              :Else
                  Log'Invalid keyword: "',cmd,'"'
              :EndSelect
          :EndIf
      :EndFor
     
      args.tests↓⍨←1  ⍝ drop off leading comma
      res←1,args
    ∇

    :EndSection

    :Section BUILD

    ∇ {r}←Build args;file;prod;path;lines;extn;name;exists;extension;i;cmd;params;values;names;_description;_id;_version;id;v;target;source;wild;options;z;tmp;types;start;_defaults;f;files;n;quiet;save;ts;tmpPath;chars;nums;fileType;targetNames;targetName;fileContent;fileData;tmpExt;eol;halt;off;LOGS;logfile;TestClassic;production;ClassicVersion;j;synt;rfs;nam;str;wsid;command;line;TargetList;d;order;NQed;type;pars;det;loaded;Target;nosource;lib;icon;rc;oFFIssue;lst
    ⍝ Process a .dyalogbuild file
      Init 2
      oFFIssue←0    ⍝ set to 1 to repo MB's Keypress issue...
      rc←0   ⍝ returncode (if possible)   0=ok, 1=errors during Build process
      LOGS←3⍴⊂''
      r←''
      :If isChar args  ⍝ also allow the function to be called directly (not as a UCMD) with a simple string arg that we will then parse using DBuilds Parse rules:
          lst←List
          lst←lst[lst.Name⍳⊂'DBuild']
          i←lst.Parse⍳' '
          synt←(i↓lst.Parse)('nargs=',i↑lst.Parse)
          args←(⎕NEW ⎕SE.Parser synt).Parse args
          :If 19>DyaVersion
              args.nosource←0   ⍝ avoid VALUE ERROR (Parse only allow for nosource from 19 onwards...)
          :EndIf
          args.(quiet save production halt nosource)←{2⊃⎕VFI⍕⍵}¨args.(quiet save production halt nosource)  ⍝ saw a string here when we went through the Parsing above - so let's ensure these vars are numeric...
      :EndIf
      start←⎕AI[3]
      extension←'.dyalogbuild' ⍝ default extension
      i←0 ⍝ we are on "line zero" if any logging happens
     
      :If 0∊⍴args.Arguments
          args.Arguments←,⊂file←FindBuildFile ⎕WSID
          args.clear←1 ⍝ Rebuilding workspace
      :AndIf 0∊⍴file
          'Build file not named and no default found'⎕SIGNAL 22
      :EndIf
     
      file←∊1 ⎕NPARTS 1⊃args.Arguments
      :If args.production  ⍝ #11: if prod is set, quiet←1 and save←0 (unless set differently on the commandline)
          :If 0≡args.quiet
              args.quiet←1
          :EndIf
          :If 0≡args.save
              args.save←0
          :EndIf
      :EndIf
      (prod quiet save halt TestClassic Target)←args.(production quiet save halt testclassic target)
     
      (TestClassic prod save)←{2⊃⎕VFI⍕⍵}¨TestClassic prod save  ⍝ these get passed as char (but could also be numeric in case we're being called directly. So better be paranoid and ensure that we have a number)
      off←2 args.Switch'off'
      nosource←¯1 args.Switch'nosource'  ⍝ ¯1 indicates "not set"
     
      :If Target≡null
          TargetList←0 5⍴''    ⍝ List of Targets we have to build ([;1]=lineno, [;2]=params names values)
      :Else
          TargetList←1 5⍴0('target: ',Target)('wsid=',Target)(,⊂'wsid')(,⊂Target)
      :EndIf
     
      :If halt
          ⎕TRAP←0 'S'
      :EndIf ⍝ Defeat UCMD trapping
     
      Clear args.clear
      (exists file)←OpenFile file
      (path name extn)←⎕NPARTS file
     
      0 Log'DyalogBuild version ',⍕dVersion
      ('Build file not found: ',file)⎕SIGNAL exists↓22
     
      lines←1⊃⎕NGET file 1
     
      _version←0
      _id←''
      _description←''
      _defaults←'⎕ML←⎕IO←1'
      :If ~prod
          ('Type' 'I')Log'Note: Loaded files will be linked to their source - use -prod to not link'
      :EndIf
      :For i :In ⍳≢lines
          :If ~':'∊line←i⊃lines                    ⍝ if the line does not have a name value setting
          :OrIf '⍝'=⊃{(⍵≠' ')/⍵}line     ⍝ or if it's a comment
              :Continue                       ⍝ skip it!
          :EndIf ⍝ Ignore blank lines
          line←{(∧\(~2|+\⍵='''')⍲⍵='⍝')/⍵}line
          (cmd params)←':'SplitFirst whiteout line
          params←⎕SE.Dyalog.Utils.ExpandConfig params
          (names values)←↓[1]↑¯2↑¨(⊂⊂''),¨'='sSplit¨','sSplit params
          cmd←lc cmd~' ' ⋄ names←lc names
          :If (i=1)∧'dyalogbuild'≢cmd
              'First line of file must define DyalogBuild version'⎕SIGNAL 11
          :EndIf
     
          :Select cmd
          :Case 'dyalogbuild'
              :If dVersion≥_version←GetNumParam'version' ''
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
     
              :If ⎕NEXISTS path,target
                  :For f :In files←'*'ListFiles path,target
                      ⎕NDELETE f
                  :EndFor
              :Else
                  :Trap 0
                      3 ⎕MKDIR path,target ⍝ /// needs error trapping
                  :Else
                      LogError'Error while creating "',path,target,'":',∊⎕DMX.DM,¨⊂NL
                  :EndTrap
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
              d←0   ⍝ will be set to 1 if we come across errors handling assignments
              target←'#'GetParam'target'
              target←(('#'≠⊃target)/'#.'),target
              :If 0∊⍴source←GetParam'source' ''
                  'Source is required'Signal 11
              :EndIf
              :If cmd≡'ns'
                  :If 0=⎕NC target
                      target ⎕NS''
                      :Trap halt↓0
                          target⍎_defaults
                          Log'Created namespace ',target
                      :Else
                          LogError'Error establishing defaults in namespace ',target,': ',⎕JSON ⎕DMX                          ⍝ CompCheck: ignore
                      :EndTrap
                  :ElseIf 2=⎕NC target  ⍝ if target is an existing variable name
                      LogError'Can not create namespace ',target,' - a variable with that name already exists'
                  :EndIf
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
                      LogError ⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                  :EndTrap
                  :Continue
              :EndIf
     
              wild←∨/'*?'∊source
              options←(wild/' -protect'),(prod/' -nolink'),(' -source'/⍨cmd≡'data')  ⍝ protect started with Dyalog 14 (or was it 13?)
              tmpPath←path{cmd≡'lib':⍵ ⋄ ⍵,⍨⍺/⍨0∊⍴('^\[.*\]'⎕S 3)⍵}source   ⍝ CompCheck: ignore
              :If cmd≡'lib'   ⍝ find path of library...(only if >17, so we'll be using ]LINK which needs path)
                  lib←⊃0(⎕NINFO ⎕OPT('Wildcard' 1)('Recurse' 1))((2 ⎕NQ'.' 'GetEnvironment' 'DYALOG'),'/Library/',source,'.dyalog')  ⍝ CompCheck: ignore
                  lib←eis lib
                  :If 1=≢lib  ⍝ CompCheck: ignore
                      tmpPath←⊃lib
                  :ElseIf 1<≢lib  ⍝ CompCheck: ignore
                      LogError'too many matches searching library "',source,'": ',⍕lib
                      :Continue
                  :Else
                      LogError'Could not find library "',source,'"'
                      :Continue
                  :EndIf
              :EndIf
              :Trap halt↓11
                  ⍝z←⎕SE.SALT.Load tmp←tmpPath,((~0∊⍴target)/' -target=',target),options
                  loaded←options LoadCode tmpPath target cmd
⍝                  (2⊃¨loaded)←{(,⊂⍣(2=≡⍵)rtack ⍵)}¨2⊃¨loaded
              :Else
                  LogError ⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺)/'") ("',⊃⍬⍴2⌽⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')    ⍝ CompCheck: ignore
                  :Continue
              :EndTrap
     
              :If cmd≡'data'
                  target ⎕NS''
                  fileType←lc'charvecs'GetParam'format'
                  :If 'charvec'≡fileType
                      chars←'cr' 'lf' 'nel' 'vt' 'ff' 'ls' 'ps'
                      nums←'13' '10' '133' '11' '12' '8232' '8233'
                      eol←⎕UCS⍎¨(chars,nums)⎕S(,⍨nums)rtack lc'lf'GetParam'seteol'   ⍝ CompCheck: ignore
                  :EndIf
                  tmpExt←3⊃⎕NPARTS tmpPath
                  tmpExt,⍨←'='/⍨0≠⍴tmpExt
                  :If wild
                      targetNames←2⊃¨⎕NPARTS,eis(⎕SE.SALT.List tmpPath,' -extension',tmpExt,' -raw')[;2]
                  :ElseIf 1=≢loaded
                      targetNames←2⊃⎕NPARTS tmpPath
                  :ElseIf 0=≢loaded
                      LogError'LoadCode  "',tmpPath,'" did not return anything - does the file even exist?'
                      :Continue
                  :Else
                      LogError'"LoadCode" unexpectedly returned > 1 object for command "',line,'"'
                      :Continue
                  :EndIf
                  :For targetName fileContent :In loaded
                      targetName←2⊃⎕NPARTS targetName
⍝                      fileContent←⊃fileContent
                      :Select fileType
                      :Case 'charvec'
                          fileData←(-≢eol)↓∊fileContent,¨⊂eol
                      :Case 'charmat'
                          fileData←↑fileContent
                      :Case 'json'
                          fileData←0 ⎕JSON∊fileContent
                      :Case 'charvecs'
                          fileData←fileContent
                      :EndSelect
                      :Trap 0
                          :If 0=(⍎target).⎕NC targetName
                              targetName(⍎target).{⍎⍺,'←⍵'}fileData
                          :Else
                              LogError'DATA does not support overwriting of existing names (as command "',(i⊃lines),'" would do)'
                              d←1
                              :Continue
                          :EndIf
                      :Else
                          LogError'Error trying to assign "',target,'.',targetName,'": ',NL,∊⎕DMX.DM,¨⊂NL
                          d←1
                          :Continue
                      :EndTrap
                  :EndFor
                  loaded←targetNames
                  fileType,←' '
              :Else
                  fileType←''
              :EndIf
              :If ~d
                  :If 0∊⍴loaded     ⍝ no names
                      LogError'Nothing found: ',source
                  :ElseIf (,1)≡,⍴loaded ⍝ exactly one name
                      Log{(uc 1↑⍵),1↓⍵}fileType,cmd,' ',source,' loaded as ',⍕⊃loaded
                  :Else     ⍝ many names: -verbose shows complete list always, otherwise limit to ⎕PW
                      Log((⍕⍴,loaded),' ',fileType,' names loaded from ',source,' into ',(⍕target),'.'){⎕PW>12+≢⍺,⍵:⍺,⍵ ⋄ ⍺}{1=≡⍵:⍵ ⋄ '(',(¯1↓∊⍕¨⍵,¨' '),')'}loaded
                  :EndIf
              :EndIf
     
     
          :CaseList 'lx' 'exec' 'prod' 'defaults'
              :If 0∊⍴tmp←GetParam'expression' ''
                  LogError'expression missing'
              :Else
                  tmp←params ⍝ MBaas: use entire segment after ":" as argument (so that : and , can be used in these APL Expressions!)
                  :If cmd≡'lx'
                      #.⎕LX←tmp
                      Log'Latent Expression set'
                  :ElseIf prod∨cmd≢'prod' ⍝ only execute PROD command if -production specified
                      :Trap halt↓0
                          #⍎tmp
                      :Else
                          LogError,∊⎕DMX.DM,¨⊂NL
                      :EndTrap
                      :If cmd≡'defaults'
                          _defaults←_defaults,'⋄',tmp ⋄ Log'Set defaults ',tmp
                          #⍎_defaults    ⍝ apply defaults to #
                      :EndIf ⍝ Store for use each time a NS is created
                  :EndIf
              :EndIf
     
          :Case 'target'
              :If (,0)≡2 args.Switch'save'
              :AndIf (('2'GetNumParam'save')∊0 1)
                  ('Type' 'I')Log'Found TARGET-Entry with SAVE-parameter, but modifier -save=',(⍕save),' overruled it'
              :ElseIf Target≡null
                  TargetList⍪←i line params names values
              :EndIf
          :Else
              :If '⍝'≠⊃cmd ⍝ ignore commented lines
              :AndIf 0<≢cmd
                  LogError'Invalid keyword: ',cmd
              :EndIf
          :EndSelect
     
      :EndFor
     
      :If prod
          ⎕EX'#.SALT_Var_Data'
      :EndIf
      ⎕EX'loaded'   ⍝ kill possible refs (otherwise ⎕save may fail)
      :If TestClassic>0
          z←TestClassic{
              2=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic⍎⍵
              3=⎕NC ⍵:⍵{0<⍴,⍵:⍺,': ',⍵ ⋄ ''}∆TestClassic ⎕CR ⍵
              +∇¨(⊂⍵,'.'),¨(⍎⍵).⎕NL-2.1 3.1 9.1  ⍝ +∇ avoids crashes in 12.1...15
          }¨(⊂'#.'),¨#.⎕NL-2.1 3.1 3.2 9.1
          :If 0<⍴z
              LogError('Classic test found incompatible characters in following functions/variables:',NL),¯2↓∊z{('- ',⍺,⍵)/⍨×,⍴⍺}⍥1 rtack NL
          :Else
              Log'Workspace seems to be compatible with Classic Edition ',⍕{⍵>1:⍵ ⋄ 12}TestClassic
          :EndIf
      :EndIf
     
      n←≢3⊃LOGS
      :If DyaVersion≥19
          :If nosource>¯1  ⍝ if this is set
          :AndIf 0<≢GetParam'nosource'      ⍝ and the TARGET instruction also has a nosource param
          :AndIf ('2'GetNumParam'nosource')≠nosource   ⍝ and they are different
              ('Type' 'W')Log'Found TARGET-Entry with nosource=',(GetParam'nosource'),', but modifier -nosource=',(⍕nosource),' overruled it'
          :EndIf
          :If (1=GetNumParam'nosource')∧0≠2 args.Switch'nosource'
          :OrIf 1=2 args.Switch'nosource'
              {}5171⌶#
              {}5172⌶0
          :EndIf
      :Else
          :If 0<≢GetParam'nosource'
          :OrIf nosource>¯1
              ('Type' 'W')Log'Using "nosource" requires at least Version 19'
          :EndIf
      :EndIf
      :If 0=n  ⍝ if no errors were found
          :If (save≡1)∧0=1↑⍴TargetList   ⍝ save switch was set, but no target instruction given
                                    ⍝ pretend we had one which save under name of build file
              TargetList←1 5⍴0('target: ',name)('wsid=',name)(,⊂'wsid')(,⊂name)
          :EndIf
          :If save
              :For (i line params names values) :In ↓TargetList
                  :If 0∊⍴tmp←GetParam'wsid' ''
                      LogError'wsid missing'
                  :Else
                      d←1⊃⎕NPARTS tmp  ⍝ directory given?
                      :If {{~'/\'∊⍨(⎕IO+2×isWin∧':'∊⍵)⊃⍵}3↑⍵}d   ⍝ if that dir is an relative path
                          wsid←∊1 ⎕NPARTS path,tmp                  ⍝ prefix path of buildfile
                      :Else
                          wsid←tmp
                      :EndIf
                      :If ~⎕NEXISTS 1⊃⎕NPARTS wsid
                          LogError'Folder of wsid ("',(1⊃⎕NPARTS wsid),'") not found! wsid will not be set and ws not saved!'
                          :Continue
                      :EndIf
                      :If (⊂lc 3⊃⎕NPARTS wsid)∊'' '.dws'
                      :OrIf 0=≢GetParam'type'    ⍝ if type is not set, we're building a workspace
                          :If (save∊⍳2)∨99='99'GetNumParam'save'
                              ⎕WSID←wsid
                              Log'WSID set to ',wsid
                          :EndIf
                      :EndIf
                  :EndIf
     
                  :If off=2
                      off←1=GetNumParam'off' 0
                  :EndIf ⍝ only process this one if the modifier was not provided (and therefore has its default value of 2)
                  :If save∊0 2
                      :Continue
                  :EndIf
     
             ⍝ Apr 21-research found these vars referencing # (or elements of it) - get them out of the way temporarily
                  rfs←0 2⍴''
                  ⎕EX¨'⎕SE.'∘,¨'SALTUtils.spc.z' 'SALTUtils.spc.res'
                  :Trap 0
                      :For nam :In '⎕SE.'∘,¨'THIS' 'SALTUtils.cs' 'SALTUtils.c.THIS' 'SALTUtils.spc.ns.proc' 'input.c.THIS'
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
                  ⎕SIGNAL 0  ⍝ CompCheck: ignore   ⍝ reset ⎕DM, ⎕DMX to avoid problems with refs when saving
                  :Trap DEBUG↓0 ⍝ yes, all trap have a halt/ after them - this one doesn't and shouldn't.
                      :If ~0∊⍴type←GetParam'type'
                          :If DyaVersion≥19
                      ⍝ <type>     is one of 'ActiveXControl' 'InProcessServer' 'Library' 'NativeExe' 'OutOfProcessServer' 'StandaloneNativeExe'
                      ⍝ <flags>    is the sum of zero or more of the following:
                      ⍝ BOUND_CONSOLE 2
                      ⍝ BOUND_USEDOTNET 4
                      ⍝ BOUND_RUNTIME 8
                      ⍝ BOUND_XPLOOK 32
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
                              :If 0<≢∊det
                                  det←(⌽2,0.5×⍴det)⍴det
                              :Else
                                  det←0 2⍴''
                              :EndIf
                              icon←GetParam'icon'
                              :If (⊂2↑icon)∊'./' '.\'
                                  icon←path,2↓icon
                              :EndIf
                              pars←'.' 'Bind'wsid(type)(GetNumParam'flags')(GetParam'resource')(icon)('"'~⍨GetParam'cmdline')(det)
                              command←'2 ⎕NQ ',∊{''≡0↑⍵:'''',⍵,''' ' ⋄ (⍕⍵),' '}¨¯1↓pars
                              command←command,(0<≢det)/' (',(⍕⍴det),'⍴',(∊{''≡0↑⍵:'''',⍵,''' ' ⋄ (⍕⍵),' '}¨det),')'
                              2 #.⎕NQ pars
                          :Else
                              ('Type' 'E')Log'The "type" parameter of TARGET is supported on v19 and better!'
                          :EndIf
                      :Else
                          command←')SAVE ',wsid
                          0 #.⎕SAVE wsid
                      :EndIf
                      :Trap DEBUG↓0  ⍝ paranoid, but want to avoid any bugs here to trigger the save again...
                          :If ⎕NEXISTS det←wsid{''≡3⊃⎕NPARTS ⍺:⍺,⍵ ⋄ ⍺}'.dws'
                              tmp←⍕DEBUG{(~⍺)/~⍺::'???' ⋄ (ListFiles ⍵)[1;2]}det
                              Log'Saved as ',det,' (',tmp,' bytes)'
                          :EndIf
                      :EndTrap
                      command←''
                  :Case 11   ⍝ DOMAIN ERROR
                      :If 0<102⌶#   ⍝ check most likely cause: links from ⎕SE to #
                      :AndIf isWin
                          ('Type' 'E')Log'Problem creating ',wsid,':',NL,(∊⎕DMX.DM,¨⊂NL),'There might still be references from "somewhere in ⎕SE" to "something in #".',NL,'Please contact support@dyalog.com to discuss & resolve this if the enqueued keystrokes did not create the desired result.',NL,command,' ⍝ command we executed',NL
                      :Else
                          ('Type' 'E')Log'Problem creating ',wsid,':',NL,∊⎕DMX.DM,¨⊂NL
                      :EndIf
                      :If halt ⋄ (⎕LC[1]+2)⎕STOP 1⊃⎕SI
                          ⎕←'Function halted.'
                      ⍝ stop here
                      :EndIf
                  :Else
                      ('Type' 'E')Log'Problem creating ',wsid,':',∊⎕DMX.DM,¨⊂NL
                  :EndTrap
                  :If ~0∊⍴command
                      :If ⎕NEXISTS wsid,'.dws'
                      :AndIf ~'.exe'≡3⊃⎕NPARTS wsid
                          ⎕NDELETE wsid,'.dws'  ⍝ avoid prompts during )SAVE
                      :EndIf
                      :If isWin
                          {sink←2 ⎕NQ ⎕SE'keypress'⍵}¨'  )RESET',⊂'ER'
                          {sink←2 ⎕NQ ⎕SE'keypress'⍵}¨'  ',command,⊂'ER'
                          NQed←1
                          Log'Enqueued keypresses to automatically save after UCMD has completed: "',command,'"'
                      :Else
                          Log'Please execute the following command when the UCMD has finished:'
                          Log command
                      :EndIf
                  :EndIf
                  :If 0<≢rfs      ⍝ and created some refs
                      :For (nam str) :In ↓rfs   ⍝ then restore them...
                          ⍎nam,'←',str
                      :EndFor
                  :EndIf
              :EndFor
          :ElseIf 0<≢TargetList
              ('Type' 'W')Log'TARGETs were not saved because -save Switch was not set!'
          :EndIf
      :Else
          ('Type' 'W')Log'DBuild found errors during process',save/', workspace was not saved!'
          n←1  ⍝ need error count
          rc←1
      :EndIf
      ⍝:EndIf
 ⍝     :endif
     endSave:
      ('Type' 'I')Log'DyalogBuild: ',(⍕⍴lines),' lines processed in ',(1⍕0.001×⎕AI[3]-start),' seconds.'
     
      :If 0<n←≢3⊃LOGS
          ('Type' 'I')Log(0≠n)/' ',(⍕n),' error',((n>1)/'s'),' encountered.'
      :EndIf
      :For i :In ⍳3
          :If 0<n←≢i⊃LOGS
              r,←⊂((i⍴'*'),' ',((n>1)/⍕n),' ',i⊃'Info' 'Warning' 'Error'),((n>1)/'s'),':'
              r,←i⊃LOGS
          :EndIf
      :EndFor
      r←table r
      :If off=1  ⍝ careful: off∊0 1 2!
          logfile←∊(2↑⎕NPARTS file),'.log'
          1 ⎕NDELETE logfile
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
          (path file ext)←⎕NPARTS path
      :Until found←⎕NEXISTS r←path,file,'/',file,'.dyalogbuild'
      :OrIf 1≥+/r∊'/\'
      r←found/r
    ∇

    ∇ (exists file)←OpenFile file;tmp;path;extn;name
      (path name extn)←⎕NPARTS file
      :If exists←⎕NEXISTS file
          :If 1=GetFilesystemType file   ⍝ but it is a folder!
              :If exists←⎕NEXISTS tmp←file,'/',name,extension ⍝ If folder contains name.dyalogbuild
                  file←tmp ⍝ Then use the file instead
              :ElseIf 1=⍴tmp←(ListFiles(⊃1 ⎕NPARTS file),'*',extension)[;1] ⍝ if there's only a single .dyalogbuild file, use it
                  exists←⎕NEXISTS file←⊃tmp
              :ElseIf 1<⍴tmp
                  LogError'There is more than one ',(extension),' file in ',file,'. Please specify a single file.'
              :EndIf
          :EndIf
      :Else
          exists←⎕NEXISTS file←file,(0∊⍴extn)/extension
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

    LineNo←{    '[',(,'ZI3'⎕FMT ⊃,⍵),']'    }  ⍝ m19572 deals with Edit|Reformat not removing the blanks in the dfn!
    PrefixTS← {(⊃'hh:mm:ss.fff"> "'(1200⌶)1⎕DT'J'),⍵}
    ∇ {r}←{f}LogTest msg;type;i
    ⍝ this function is mapped to function "Log" that is defined in the ns in which tests are executed
    ⍝ optional f is ('Type' 'I|W|E') (or 'Info|Warning|Error', 1st char matters) and/or ('Prefix' 'any text to prefix to the msg')
    ⍝ msg is the ReturnValue of a test, traditionally we expect a text vector there, but anything that matches "SuccessValue" (empty string)
    ⍝ will not be logged whereas anything different will be logged as an error, unless specified differently through 'Type'.
      r←0 0⍴0 ⋄ type←0  ⍝ initial value...
     
      →(msg≡SuccessValue)⍴0
      :If 0=⎕NC'f'
      :AndIf (⎕DR∊msg)∊80 82 160
          f←''
          r←msg
          type←3
      :Else
          :If 2≤|≡f
              :If 2=|≡f ⍝ ONE name & value
                  f←⊂f
              :EndIf
              f←,f
              :If (≢f)≥i←(,1↑¨f)⍳⊂,⊂'Type'
                  type←'IWE'⍳⊃2⊃i⊃f
              :EndIf
              :If (≢f)≥i←(,1↑¨f)⍳⊂,⊂'Prefix'
                  f←2⊃i⊃f
              :Else
                  f←''
              :EndIf
          :EndIf
          :If type=0  ⍝ only add this information if Log came w/o explicit type
              type←3   ⍝ and the default message type is "Error"
              :If (⎕DR msg)=326
                  msg←'code returned data with unsupported ⎕DR=326'
              :ElseIf ~(⎕DR∊msg)∊80 82 160
                  msg←'code returned numeric ',((0 1⍳⍴⍴msg)⊃'scalar' 'vector'),' = ',⍕msg
                  :If SuccessValue≢''
                      msg,←' that did not match SuccessValue=',{' '=⍥⎕DR ⍵:'''',⍵,'''' ⋄ ((0 1⍳⍴⍴msg)⊃'scalar ' 'vector '),⍕⍵}SuccessValue
                  :Else
                      msg,←' when DTest expected an empty charvec to indicate success'
                  :EndIf
              :Else
                  msg←'code returned character value = "',(¯1↓,msg,⎕UCS 10),'"'
                  :If SuccessValue≢''
                      msg,←' that did not match SuccessValue=',{' '=⍥⎕DR ⍵:'''',⍵,'''' ⋄ 'num ',((0 1⍳⍴⍴msg)⊃'scalar ' 'vector '),⍕⍵}SuccessValue
                  :Else
                      msg,←' when DTest expected an empty charvec to indicate success'
            ⍝   ⎕←msg
                  :EndIf
              :EndIf
          :EndIf
          :If 2=⎕NC'timestamp'
          :AndIf timestamp=1
              f←PrefixTS f
          :EndIf
          msg←(f,(~0∊⍴f)/': ')∘,¨eis msg
     
      :EndIf
      :If verbose
      :AndIf quiet=0
          ⎕←msg
      :EndIf
      :If quiet≠1
      :OrIf type=3
          LOGS[type],←⊂eis msg
      :EndIf
    ∇

    ∇ {pre}Log msg;type;j
    ⍝ no ⍺ or  ⍺=1: prefix log with lineno.
    ⍝ alternatively pre can also be a VTV with Name/Value pairs ('Prefix' 'foo')('Type' 'I')
      type←1    ⍝ Info
      →(0=≢msg)/0
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
              :If (≢pre)≥j←(,1↑¨pre)⍳⊂,⊂'Type'
                  type←'IWE'⍳⊃2⊃j⊃pre
              :EndIf
              :If (≢pre)≥j←(,1↑¨pre)⍳⊂,⊂'Prefix'
                  pre←2⊃j⊃pre
              :Else
                  pre←''
              :EndIf
          :Else
              pre←''
          :EndIf
      :EndIf
      :If 2=⎕NC'timestamp'
      :AndIf timestamp=1
          pre←PrefixTS pre
      :EndIf
      pre←pre,(∧/(0<≢pre),' '≠(¯1↑pre),1⊃msg)⍴' '   ⍝ optionally insert a blank to separate prefix and msg
      :If 0=⎕NC'LOGS'
          LOGS←3⍴⊂''
      :EndIf  ⍝ may happen during Clean...
      :If quiet≠1
      :OrIf type=3
          LOGS[type],←⊂eis pre,msg
      :EndIf
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
      Init 1   ⍝ make sure _Version is available...
      r←⎕NS¨3⍴⊂''
      r.Group←⊂'DEVOPS'
      r.Name←'DBuild' 'DTest' 'GetTools4CITA'
      r.Desc←'Run one or more DyalogBuild script files (.dyalogbuild)' 'Run (a selection of) functions named test_* from a namespace, file or directory' 'Load tools to run CITA tests'
      :If 14>1⊃DyaVersion
          r.Parse←'1S -production -quiet[∊]0 1 2 -halt -save[∊]0 1 2 -off[=]0 1 -clear[=] -target= -testclassic' '1 -clear[=] -tests= -testlog[=] -filter= -setup[=] -teardown[=] -suite= -verbose -quiet -halt -loglvl= -trace -ts -timeout= -repeat= -order= -init -off[=]0 1 2 -SuccessValue=' ''
      :ElseIf 19>DyaVersion
          r.Parse←'1S -production -quiet[∊]0 1 2 -halt -save[∊]0 1 2 -off[=]0 1 -clear[=] -target= -testclassic' '999s -clear[=] -tests= -testlog[=] -filter= -setup[=] -teardown[=] -suite= -verbose -quiet -halt -loglvl= -trace -ts -timeout= -repeat= -order= -init -off[=]0 1 2 -coverage[=]  -SuccessValue=' ''
      :Else
          r.Parse←'1S -production -quiet[∊]0 1 2 -halt -nosource[∊]0 1 2 -save[∊]0 1 2 -off[=]0 1 -clear[=] -target= -testclassic' '999s -clear[=] -tests= -testlog[=] -filter= -setup[=] -teardown[=] -suite= -verbose -quiet -halt -loglvl= -trace -ts -timeout= -repeat= -order= -init -off[=]0 1 2 -coverage[=]  -SuccessValue=' ''
      :EndIf
    ∇

    ∇ Û←Run(Ûcmd Ûargs)
     ⍝ Run a build
      Init 1
      ('UCMD "',Ûcmd,'" requires at least Dyalog v18.0')⎕SIGNAL(DyaVersion<18)/11
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
      Init 1
      :Select Cmd
      :Case 'DBuild'
          r←⊂'Run one or more DyalogBuild script files (.dyalogbuild) | Version ',2⊃Version
          r,←⊂'    ]',Cmd,' <files> [-clear[=NCs]] [-production] [-quiet[=0|1|2]] [-halt] ',((19≤DyaVersion)/'[-nosource[=0|1]] '),'[-save[=0|1|2]] [-off[=0|1]] [-TestClassic] -target=Target'
          :Select level
          :Case 0
              r,←⊂']',Cmd,' -?? ⍝ for more details about command line and modifiers'
              r,←⊂']',Cmd,' -??? ⍝ for description of the DyalogBuild script format'
              r,←⊂'see https://github.com/Dyalog/DBuildTest/wiki/DBuild for more information'
          :Case 1
              r,←'' 'Argument is:'
              r,←⊂'    files           name of one or more .dyalogbuild files'
              r,←'' 'Optional modifiers are:'
              r,←⊂'    -clear[=NCs]    expunge all objects, optionally of specified nameclasses only'
              r,←⊂'    -halt           halt on error rather than log and continue'
              :If 19≤DyaVersion
                  r,←⊂'    -nosource       do not preserve "source-as-typed" (neccessary if you want to create workspaces'
                  r,←⊂'                    that can be used on Classic and Unicode Editions!)'
              :EndIf
              r,←⊂'    -production     remove links to source files (and execute code given in PROD instructions in buildfile)'
              r,←⊂'    -quiet[=n]      only output actual errors (quiet=2 only writes them to log, not into session)'
              r,←⊂'    -save[=0|1|2]   save the build workspace (overwrites TARGET''s save option). Note: we only save if no errors were logged during Build process. save=2: do NOT save, but set ⎕WSID (according to TARGET Instruction in buildfile)'
              r,←⊂'    -off[=0|1]      )OFF after completion (if errors were logged, logfile will be created)'
              r,←⊂'    -target=Target  override target spec from dyalogbuild file'
              r,←⊂'    -TestClassic    check imported code for compatibility with classic editions (character set, not language features)'
              r,←⊂''
              r,←⊂']',Cmd,' -??? ⍝ for description of the DyalogBuild script format'
              r,←⊂'see https://github.com/Dyalog/DBuildTest/wiki/DBuild for more information'
          :Case 2
              r,←⊂''
              r,←⊂'each non empty line of a DyalogBuild script has the following syntax:'
              r,←⊂'INSTRUCTION:  argument[, Parameter1=value1, Parameter2=value2,...]'
              r,←⊂'              Everything after "INSTRUCTION:" may reference configuration parameters using syntax $MyParam or %MyParam% or ${MyParam}.'
              r,←⊂'              You can continue with any non alphabetic chars immediately following the name of the parameter, otherwise leave a blank. For example, with FOO="C:\TEMP" and Git="c:\git\", you can do'
              r,←⊂'                  "$Foo\Goo" => "C:\TEMP\Goo", "$Git MyDir" => "c:\git\MyDir", "$Git MyDir" => "c:\git\ MyDir", "${Git}MyDir" => "c:\git\MyDir"'
              r,←⊂''
              r,←⊂'INSTRUCTION may be one of the following:'
              r,←⊂'  DYALOGBUILD:  nnn                                                     This instruction must be included and be the first one. "nnn" specifies the minimum version required to run this script.'
              r,←⊂'  ID:           name[, Version=nnn]                                     This instruction is purely informational and causes a log entry of "Building name" or "Building name version nnn" where "nnn" is a number.'
              r,←⊂'  COPY:         path1, Target=path2                                     Copies one or more files from path1 to path2.'
              r,←⊂'  NS:           pathname[, Target=namespace]                            Loads the APL object(s) defined in the file(s) matching the pattern "pathname" into "namespace" (default is #), establishing the namespace if it does not exist.'
              r,←⊂'  {CLASS|APL}:  pathname[, Target=namespace]                            Loads the APL object defined in "pathname" into "namespace" (default is #).'
              r,←⊂'  LIB:          name[, Target=namespa                                   Loads the library utility "name" into "namespace" (default is #).'
              r,←⊂'  CSV:          pathname, Target=matname[, ColTypes=spec]               Loads the CSV file "pathname" as a matrix called "matname". "spec" corresponds to the third element of ⎕CSV''s right argument; for details, see ',⎕SE.UCMD'Tools.Help ⎕CSV -url' ⍝ CompCheck: ignore
              r,←⊂'  DATA:         pathname, Target=namespace[, Format=type[, SetEOL=nl]]  Loads the contents of the file(s) matching the pattern "pathname" into one or more variables in "namespace" (default is #). The variable(s) will be named with the base filename(s). "type" dictates how the file content of each file is interpreted, and may be one of:'
              r,←⊂'      charvec   meaning as a simple character vector. If SetEOL=nl is specified, the lines will be separated by the chosen line ending sequence; one or more of the leftmost character codes or the corresponding decimal numbers of:'
              r,←⊂'                  LF   Line Feed            ⎕UCS 10 (default)'
              r,←⊂'                  VT   Vertical Tab         ⎕UCS 11'
              r,←⊂'                  FF   Form Feed            ⎕UCS 12'
              r,←⊂'                  CR   Carriage Return      ⎕UCS 13'
              r,←⊂'                  NEL  New Line             ⎕UCS 133'
              r,←⊂'                  LS   Line Separator       ⎕UCS 8282'
              r,←⊂'                  PS   Paragraph Separator  ⎕UCS 8233'
              r,←⊂'      charvecs  meaning as a vector of character vectors'
              r,←⊂'      charmat   meaning as a character matrix'
              r,←⊂'      json      meaning as json. The variable will be a numeric scalar, a vector, or a namespace in accordance with the JSON code in the file.'
              r,←⊂'  LX:           expression                                              Sets the workspace''s ⎕LX to "expression".'
              r,←⊂'  EXEC:         expression                                              Executes the APL expression "expression".'
              r,←⊂'  PROD:         expression                                              Executes the APL expression "expression" only if ]',Cmd,' was called with the -production modifier'
              r,←⊂'  DEFAULTS:     expression                                              Executes the APL expression "expression" in each namespace created or accessed by the NS instruction.'
              r,←⊂'  TARGET:       wsname.dws                                              Sets the WSID to wsname.dws so the workspace is ready to )SAVE.'
              r,←⊂'    Supports optional parameters:'
              r,←⊂'    save=0|1 (Default 0): save the workspace after a successful (=no errors were logged) build'
              r,←⊂'    off=0|1  (Default=0): )OFF after completion of Build. If errors were logged, a logfile (same name as the .dyalogbuild file with .log extension) will be created and exit code 1 will be set.'
              r,←⊂''
              r,←⊂'see https://github.com/Dyalog/DBuildTest/wiki/DBuild for more information'
          :EndSelect
     
      :Case 'DTest'
          r←⊂'Run (a selection of) functions named test_* from a namespace, file or directory | Version ',2⊃Version
          r,←⊂'    ]',Cmd,' {<ns>|<file>|<path>} [-halt] [-filter=string] [-off] [-quiet] [-repeat=n] [-loglvl=n] [-setup[=fn]] [-suite=file] [-teardown[=fn]] [-testlog=logfile] [-tests=] [-ts] [-timeout=t] [-trace] [-verbose] [-clear[=n]] [-init] [-order={0|1|"NumVec"}]'
          :Select level
          :Case 0
              r,←⊂']',Cmd,' -?? ⍝ for more info'
          :Case 1
              r,'' 'Argument is one of:'
              r,←⊂'    ns                    namespace in the current workspace'
              r,←⊂'    file                  .dyalog file containing a namespace or a test function'
              r,←⊂'    path                  path to directory containing functions in .dyalog files'
              r,←'' 'Optional modifiers are:'
              r,←⊂'    -clear[=n]            clear ws before running tests (optionally delete nameclass n only)'
              r,←⊂'    -coverage             enable analysis of code coverage'
              r,←⊂'    -filter=string        only run functions whose name start with filter'
              r,←⊂'    -halt                 halt on error rather than log and continue'
              r,←⊂'    -init                 if specified test file wasn''t found, it will be initialised with a template'
              r,←⊂'    -loglvl               control which log files we create (if value of "-off" > 0)'
              r,←⊂'                            1={base}.log: errors'
              r,←⊂'                            2={base}.warn.log warnings'
              r,←⊂'                            4={base}.warn.log info'
              r,←⊂'                            8={base}.session.log'
              r,←⊂'                           16={base}.session.log ONLY if test failed'
              r,←⊂'                           32={base}.log.json: machine readable results'
              r,←⊂'                              Creating such a log is the ONLY way to get data on performance and memory usage of tests!'
              r,←⊂'                              (Values are bit flags and can be added)'
              r,←⊂'    -order={0|1|"NumVec"}  control sequence of tests: 0:random (default); 1:sequential; "NumVec":given order'
              r,←⊂'    -off[=0|1|2]          )OFF after running the tests'
              r,←⊂'                            0=do not )OFF after tests'
              r,←⊂'                            1=)OFF after tests - creates {base}.log if errors found AND {warn|info}.log if warnings of info msgs were created (Note: depends on -loglvl)'
              r,←⊂'                            2=do not )OFF, but create .log files (see -loglvl)'
              r,←⊂'    -quiet                QA mode: only output actual errors'
              r,←⊂'    -repeat=n             repeat tests n times'
              r,←⊂'    -setup[=fn]           run the function fn before any tests'
              r,←⊂'    -successvalue=string  defines an alternate value that indicates successfull execution of test (default is empty string)'
              r,←⊂'                           (Note: this can be tricky when you want to use 0 - see wiki for details.)'
              r,←⊂'    -suite=file           run tests defined by a .dyalogtest file'
              r,←⊂'    -teardown[=fn]        run the function fn after all tests'
              r,←⊂'    -testlog=             force name of logfile(s) (default name of testfile)'
              r,←⊂'    -tests=               comma separated list of tests to run'
              r,←⊂'    -timeout[=t]          sets a timeout. Seconds after which test(suite)s will be terminated. (Default is 0: no timeout)'
              r,←⊂'    -ts                   add timestamp (no date) to logged messages'
              r,←⊂'    -trace                set stop on line 1 of each test function'
              r,←⊂'    -verbose              display more status messages while running'
              r,←⊂''
              r,←⊂'see https://github.com/Dyalog/DBuildTest/wiki/DTest for more information'
          :Case 'GetTools4CITA'
              r←⊂'Primarily an internal tool for testing with CITA | Version ',2⊃Version
              r,←⊂'    ]',Cmd,' [ns]'
              :Select
              :Case 0
                  r,←⊂']',Cmd,' -?? ⍝ for more info'
              :Case 1
                  r,←⊂'This copies a few tools from the DTest namespace into `⎕se._cita` and some into the namespace passed as argument (default is #)'
                  r,←⊂''
                  r,←⊂'- SetupCompatibilityFns'
                  r,←⊂'- DyaVersion  numeric variable holding {major}.{minor} Version of current interpreter'
                  r,←⊂'- APLVersion  actually identifies the platform with value *nix|Win|Mac'
                  r,←⊂'- isChar ⍵    returns boolean value if argument is char'
                  r,←⊂'- isWin       niladic function returning boolean to indicate if running on Windows'
                  r,←⊂'- ⍺ Split ⍵   split string ⍵ on positions that have value ⍺'
                  r,←⊂'- Init        establishes additional functions'
                  r,←⊂'- GetDOTNETVersion - returns 4 elements to describe .NET Version that is in use:'
                  r,←⊂'                     R[1] = 0/1/2: 0=nothing, 1=.net Framework, 2=NET CORE'
                  r,←⊂'                     R[2] = Version (text vector)'
                  r,←⊂'                     R[3] = Version (identifiable x.y within [2] in numerical form)'
                  r,←⊂'                     R[4] = Textual description of the framework'
                  r,←⊂'- _FileTime_to_TS - legacy from the days w/o ⎕NINFO'
                  r,←⊂'- Nopen      - helps dealing with native files'
                  r,←⊂'...and a few others as well as:'
                  r,←⊂'- base64enc'
                  r,←⊂'- base64dec'
                  r,←⊂'- base64 (subfn used by the last 2)'
                  r,←⊂'to encode/decode a string using base64.'
                  r,←⊂'The last three as well as the "DSL":'
                  r,←⊂'- Because'
                  r,←⊂'- Fail'
                  r,←⊂'- Check'
                  r,←⊂'- IfNot'
                  r,←⊂'- IsNotElement'
                  r,←⊂'- eis'
                  r,←⊂'- Assert'
                  r,←⊂' will also be copied into the ns passed as argument (# by default)'
              :EndSelect
          :EndSelect
      :EndSelect
    ∇

    :namespace _cita

        ∇ Write2Log txt;file
      ⍝ needs name of test
          file←GetCITA_Log 1
          (⊂txt)⎕NPUT file 2
        ∇

        ∇ R←GetCITA_Log signal;z
        ⍝ signal: should we ⎕SIGNAL an error if no config file is found? (default=1)
          :If 4=⍴R←⎕SE.Dyalog.Utils.ExpandConfig'.log',⍨2 ⎕NQ'.' 'GetEnvironment' 'CITA_LOG'
            ⍝   ⎕←2 ⎕NQ'.' 'GetCommandLineArgs'   ⍝ spit out commandline into the session - maybe it help diagnosing the problem...
              :If 1∊z←∊⎕RSI{0::0 ⋄ 2=⍺.⎕NC ⍵:0<⍺⍎⍵ ⋄ 0}¨⊂'CITA_LOG'    ⍝ CompCheck: ignore   / search calling environment for variable CITA_LOG
                  R←((z⍳2)⊃⎕RSI).CITA_LOG                                ⍝ CompCheck: ignore
              :Else
              ⍝ alternatively use name of test
                  :If 0<≢R←2 ⎕NQ'.' 'GetEnvironment' 'CITATEST'
                      R←∊(2↑⎕NPARTS R),'.CITA.log'
                  :Else
                      :If signal
                          'Found no CITA_LOG in Environment - this dws is supposed to be called from CITA which should have passed the right commandline'⎕SIGNAL 11
                      :EndIf
                  :EndIf
              :EndIf
          :EndIf
        ∇

        ∇ {file}←{msg}_LogStatus status;file;⎕ML;rc;t;log;z;l2
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
⍝ logging a status will save the session log AND ⎕OFF (returncode as given in status[2] OR 31=success, 32=failure, 33=error)
⍝ returncode=¯42 will NOT off (but will write the log file!)
          ⎕ML←1
          :If 0=⎕NC'msg' ⋄ msg←'' ⋄ :EndIf
          file←∊2↑⎕NPARTS GetCITA_Log 1
          :If 1<⍴,status
          :AndIf 0={⎕ML←0 ⋄ ∊⍵}2⊃status
              (status MYrc)←status
          :EndIf
          :If isChar status  ⍝ decode status from string
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
              status←1⊃1↑status  ⍝ ensure we have a numeric scalar
              status←status×status∊¯1 1
              rc←(2+status)⊃33 32 31
              status←(2+status)⊃'err' 'fail' 'ok'
          :EndIf
          :If 2=⎕NC'MYrc'
              rc←MYrc
          :EndIf
    ⍝ we're intentionally not passing ⍵[2]as 1 to force overwrite - because this is supposed to be called once only!
    ⍝ So if it crashes...that is well deserved...
    ⍝ write status file
          file←file,'.',status
          ⎕←'"',msg,'"_LogStatus"',status,'"'
          ⎕←'called by ',(2⊃⎕SI),'[',(⍕2⊃⎕LC),']'
          ⎕←'file=',file
          :If ⎕NEXISTS file
              ⎕←'exists, writing '
              (⊂msg)⎕NPUT ⎕←file,'-exists',⍕1+≢⊃0(⎕NINFO ⎕OPT'Wildcard' 1)(file,'*')
          :Else
              (⊂msg)⎕NPUT file
          :EndIf
         
          :If 2=⎕NC'⎕se._cita._memStats'
              :Trap 0
                  t←{0::((1 3⍴0 ¯1 0)⎕FSTAC t)⊢t←⍵ ⎕FCREATE 0 ⋄ ⍵ ⎕FSTIE 0}(1⊃⎕NPARTS file),'MemRep'
                  ⎕SE._cita._memStats ⎕FAPPEND t
                  ⎕SE._cita.∆cpu ⎕FAPPEND t
                  ⎕FUNTIE t
              :Else
                  ⎕←'Caught error writing mem stats into ',(1⊃⎕NPARTS file),'MemRep:'
                  ⎕←(⎕JSON ⎕OPT'Compact' 0)⎕DMX
              :EndTrap
          :EndIf
         
        ⍝ write the logfile
          :Trap 0
              log←⎕SE ⎕WG'Log'
              :Trap 1
                  :If 2=⎕SE.⎕NC'RunCITA∆OldLog'
                      z←⎕SE.RunCITA∆OldLog NrOfCommonLines log
                      log,←⊂'Old log and new log have ',(⍕z),' common lines that were ignored!'
⍝                      z←0  ⍝ TODO: remove this
                  :Else
                      z←0
                      ⎕←log,←⊂'Did not find ⎕se.RunCITA∆OldLog - not ignoring anything from the old log'
                  :EndIf
                  log←z↓log
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
              log,←'TS.End=',⍕⎕TS
              file←(1⊃⎕NPARTS file),({(2>+\⍵='.')/⍵}2⊃⎕NPARTS file),'.txt'
              (⊂log)⎕NPUT file 1
          :Else
              ⎕←'*** Error while attempting to write sessionlog to a file:'
              ⎕←(⎕JSON ⎕OPT'Compact' 0)⎕DMX
              ⎕←'file=',file
              ⎕←'log=',log
              ⎕←'si' ⋄ ⎕←⍕⎕SI,[1.5]⎕LC
          :EndTrap
      ⍝    :If rc≠¯42
          ⎕←'Wrote the log (file="',file,'"), now we will call ⎕OFF ',⍕|rc
          ⎕←'⎕tnums=',⎕TNUMS
          ⎕OFF(|rc)
       ⍝   :EndIf
          ⍝1300⌶77  ⍝ Andy
        ∇

⍝ Define Success'blablabla' and Failure'blabla' and Error'blasbla'as shortcuts to 'blabla'_LogStatus 1|0|¯1
        Success←_LogStatus∘1
        Failure←_LogStatus∘0
        Error←_LogStatus∘¯1


        ∇ {R}←{AddPerf}RecordMemStats suffix;facts;pFmt;r;f
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
              r,←⊂f,(2000⌶)1⊃f
          :EndFor
          r,←⊂¯1 'APLVersion'(2⊃'.'⎕WG'aplversion')
         
          R,←⊂'Memory manager statistics',((0<≢suffix)⍴' '),suffix,':'
          R,←r
          :If 0=⎕NC'⎕se._cita._memStats'
              ⎕SE._cita._memStats←R
          :Else
              ⎕SE._cita._memStats,←R
          :EndIf
        ∇


        NrOfCommonLines←{+/∧\{⍵=⍵[1]+¯1+⍳≢⍵}⍺{((≢⍺)⍴⍋⍋⍺⍳⍺⍪⍵)⍳(≢⍵)⍴⍋⍋⍺⍳⍵⍪⍺}⍵}

        ∇ R←home LoadCodeCoverage ref;f;t;ccv;homeccv
⍝ loads CodeCoverage from home[/folder] into ns "ref"
⍝ name of folder must contain "aplteam-CodeCoverage-" and a version number that is configured below
⍝ (if we find apl-dependencies.txt, we search it for "aplteam-CodeCoverage" and use version given there.
⍝  But currently it is not required to be there)
          R←0 ''
          :Trap 0
              ccv←'0.9.2'   ⍝ version of CodeCoverage
              home←{⍵,(~∨/'\/\'=⊢/⍵)/⎕SE.SALT.FS}home  ⍝ make it is a folder
              :If ⎕NEXISTS f←home,'apl-dependencies.txt'
                  t←1⊃⎕NGET f
                  ccv←⊃('aplteam-CodeCoverage-(.*)$'⎕S'\1')t
              :EndIf
              homeccv←home,'aplteam-CodeCoverage-',ccv
              :If {0 2∊⍨10|⎕DR ⍵}ref  ⍝ this is "isChar", but we can't use that (dunno where it might be...)
                  ref←⍎ref
              :EndIf
              :If ~⎕NEXISTS f←homeccv,'/CodeCoverage.aplc'   ⍝ look for it in a subfolder
              :AndIf ~⎕NEXISTS f←home,'/CodeCoverage.aplc'   ⍝ or in the home folder
                  R←0('Could not find CodeCoverage source in "',f,'"')
              :EndIf
              2 ref.⎕FIX'file://',f
          :Else
              R←1(⎕←,1(⎕JSON⍠'Compact' 0)⎕DMX)
          :EndTrap
        ∇
    :EndNamespace
    :EndSection
:EndNamespace ⍝ DyalogBuild  $Revision$
