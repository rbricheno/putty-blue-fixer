# putty-blue-fixer.ps1
# (c) 2016 Rob Bricheno licensed under the terms of the WTFPL [ http://www.wtfpl.net/txt/copying/ ].
# Save as "putty-blue-fixer.ps1" and right-click -> "Run with Powershell"
#
# PuTTY [ http://www.chiark.greenend.org.uk/~sgtatham/putty/ ] on Microsoft Windows stores all of its settings under this registry key:
$key = 'HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\Sessions'
#
# The default "ANSI Blue" in PuTTY appears too dark to read when using a terminal with a black background.
# Eventually you will become bored of this, and want to fix the default settings [ http://serverfault.com/a/12297 ]:
#
# 1. Start putty, and before you do anything,
# 2. Make settings changes (i.e. Window -> Colours -> ANSI BLUE change to 85,85,187)
# 3. Then click on "Default Settings" under "Load, save or delete a stored session" (in the "Session" category) to select it.
# 4. Then click "Save."
#
# This will cause a new session called "Default%20Settings" to be created in the registry containing your default settings.
# These can now be modified like any other session. "Default Settings" will be used as a template for each session you subsequently create.
#
# Now you are left with a bunch of old sessions that you created which you need to fix. That's what this script does.
# This will fix the default blue colour in all your existing PuTTY sessions to be brighter.

# We will take a copy of the key, modify the blue value, and then reimport the key.
# First, create the temporary directories we will use (if they don't exist already).
$tempFolderRoot = 'C:\temp\'
$tempFolder = 'C:\temp\putty-blue-fixer\'
if ((Test-Path -path $tempFolderRoot) -ne $True) { New-Item $tempFolderRoot -type directory; }
if ((Test-Path -path $tempFolder) -ne $True) { New-Item $tempFolder -type directory; }

# Now export the key:
reg export $key "$tempFolder\putty-current.reg"

# Colour14 is the ANSI Blue colour which appears too dark by default when using a terminal with a black background.
# Replace every Colour14 definition with a lighter colour than the default:
(Get-Content ("$tempFolder\putty-current.reg")) | Foreach-Object {$_ -replace '^"Colour14".+', ('"Colour14"="85,85,187"')} | Set-Content  ("$tempFolder\putty-fixed-blues.reg")

# Now re-import the fixed registry entries (actually, reimport all of the exported registry including the fixed lines).
# Wait for the command to finish before continuing, so the file is not in use when we continue.
regedit /s "$tempFolder\putty-fixed-blues.reg" | Out-Null
 
# Finally remove our temp folder and its contents.
Remove-Item $tempFolder -Force -Recurse
