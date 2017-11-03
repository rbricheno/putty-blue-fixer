# putty-blue-fixer

This script helps you update [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/)'s registry settings to fix ANSI Blue to be lighter in colour.

PuTTY on Microsoft Windows stores all of its settings under this registry key:

`$key = 'HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\Sessions'`

The default "ANSI Blue" in PuTTY appears too dark to read when using a terminal with a black background.
Eventually you will become bored of this, and want to fix the [default settings](http://serverfault.com/a/12297):

1. Start PuTTY, and before you do anything,
2. Make settings changes (i.e. `Window` -> `Colours` -> `ANSI BLUE` change to `85,85,187`)
3. Then click on `Default Settings` under `Load, save or delete a stored session` (in the `Session` category) to select it.
4. Then click `Save.`

This will cause a new session called `Default%20Settings` to be created in the registry containing your default settings.
These can now be modified like any other session. `Default Settings` will be used as a template for each session you subsequently create.

Now you are left with a bunch of old sessions that you created which you need to fix. **That's what this script does.**
This will fix the default blue colour in all your existing PuTTY sessions to be brighter.

Save as `putty-blue-fixer.ps1` and right-click -> `Run with Powershell`
