# DBuild

DBuild is a tool to build a distributeable version of your code (currently: a workspace) from source-code in files. DTest supports unit tests. More doc in the [wiki](https://github.com/Dyalog/DBuildTest/wiki).
The only file that is required to run DBuild or DTest is DBuildTest.dyalog, the file TACIT.json is used to manage the testing of the repository.

## Using the tools with Dyalog v12.0, v12.1 and v13.0

Due to problems with SALT, we can't run the tools as user-commands under these old version. So you need to bring them in with `]Load` and then pass arguments to the differently.
Follow these examples:

⍝ adjust path as appropriate:

`]load C:\Git\DBuild\DyalogBuild.dyalog`

⍝ set flags as appropriate:

`ns←⎕ns'' ⋄ ns.Arguments←,⊂'FileOrDir with dyalogtest' ⋄ ns.(verbose filter halt quiet trace repeat suite tests setup teardown)←1 0 0 0 0 0 0 0 0 0  ⋄ #.DyalogBuild.Test ns`

⍝ nb: do not save! (first `)erase #.DyalogBuild`!)

`ns←⎕NS'' ⋄ ns.Arguments←,⊂'FileOrDir with build-file' ⋄ ns.(production quiet save clear halt checklassic)←1 0 0 0 1 0 ⋄ #.DyalogBuild.Build ns`
