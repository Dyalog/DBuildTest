# DBuild

## List of changes

* Added `-halt`-switch to DBuild (to stop on errors)

* DBuild: `LX`, `EXEC`, `PROD`, `DEFAULTS` will interpret their entire argument as APL-Code (so there is no problem using ":" or "," in code)

* DBuild: new parameter "`off`" for `TARGET`: is 0 or 1 and indicates if we should )OFF after building. (Is prepared to return 13 if errors were logged (see {BuildFile}.log for messages!), 0 otherwise - but this requires a fix of Mantis 17479 to enable ⎕SAVE 
when ⎕SE-fns are on the stack)

  off=1 will also make the system write a logfile with the same name as the .dyalogbuild-file and extension .log
  Also optional parameter "save=1" now works. Commandline-modifiers -save=0|1/-off=0|1 can be used to overwrite this behaviour.

* DBuild: new command-line switch "`TestClassic`" to test compatibility of build ws with classic editions (requires V16 or greater!)
  NB: this will only test compatibility of the charset, not of APL-Features (ie. will not detect `⎕NPUT` in v12.0 etc.)

* DBuild now upports `$EnvVar` (for all arguments/parameters in a .dyalogbuild-file). NB: the first blank AFTER any EnvVar is consumed
  by the replacement (this is neccessary so the resulting code is not "polluted" with spaces needed to separate the Var from
  surrounding text, ie "`$GitDir DyalogBuild" → "C:\Git\DyalogBuild`")

## Using the tools with Dyalog v12.0, v12.1 and v13.0

Due to problems with SALT, we can't run the tools as user-commands under these old version. So you need to bring them in with `]Load` and then pass arguments to the differently.
Follow these examples:

⍝ adjust path as appropriate:

`]load C:\Git\DBuild\DyalogBuild.dyalog`

⍝ set flags as appropriate:

`ns←⎕ns'' ⋄ ns.Arguments←,⊂'FileOrDir with dyalogtest' ⋄ ns.(verbose filter halt quiet trace repeat suite tests setup teardown)←1 0 0 0 0 0 0 0 0 0  ⋄ #.DyalogBuild.Test ns`

⍝ nb: do not save! (first `)erase #.DyalogBuild`!)

`ns←⎕NS'' ⋄ ns.Arguments←,⊂'FileOrDir with build-file' ⋄ ns.(production quiet save clear halt checklassic)←1 0 0 0 1 0 ⋄ #.DyalogBuild.Build ns`
