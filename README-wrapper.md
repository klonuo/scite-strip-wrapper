This ([simple-strip-wrapper.lua](https://github.com/klonuo/scite-strip-wrapper/blob/master/simple-strip-wrapper.lua)) is one possible wrapper to SciTE Strip [dialog feature](http://www.scintilla.org/SciTELua.html) (explained at the bottom of linked page)

**StripDlg()** function initializes dialog elements passed to it from SciTE Tool action.

Example Tool action can be:

```
command.name.24.*=Lookfor
command.mode.24.*=subsystem:lua,savebefore:no
command.24.*=StripDlg func=Lookfor dlg='Lookfor:'[](&Go)\n'Package:'[](&Help)
```

StripDlg() function transforms arguments to key=value pairs. Minimum requirement is "func" key, which can be used later for defining custom action

**OnStrip()** function is SciTE provided interface to strip dialog feature.
Number of dialog widgets is retrieved in StripDlg() in variable w/2 which is used for enumeration of existing dialog widgets and possible values.


At last **StripExec()** function executes action:

+ action can be executed on buffer text, or buffer selection
+ "val1" is text from first inputbox, "val2" is text from second inputbox (or "nil" if it doesn't exist), c is dialog control action
+ global StripFunc variable is conditioned for appropriate action


Above example in action:

![screen-shot](http://i.imgur.com/mtaMg.png)
