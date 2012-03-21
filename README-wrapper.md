This is one possible wrapper to SciTE Strip dialog feature. Looking the source should be easier than me explaining but here is simple documentation:


**StripDlg()** function initializes all needed dialog elements if not already passed to it from SciTE Tool action.

Example Tool action can be:

```
command.name.24.*=Lookfor
command.mode.24.*=subsystem:lua,savebefore:no
command.24.*=StripDlg func=Lookfor label2=Package button2=Help
```

From which StripDlg() will initialize:

 - StripFunc global variable set to "Lookfor", which can be conditioned later in StripExec() function
 - 2 labels: "Lookfor" and "Module"
 - 2 list input boxes
 - 2 buttons: "Go" and "Help"


**OnStrip()** function is SciTE provided interface to strip dialog feature.
Number of dialog widgets can't be retrieved, and if user tries to enumerate non-existing widget, SciTE will crash.
In this situation, as user can set widgets in different ways, we loop 4 widgets for possible inputbox values, as there will be at least 4. This also covers, case of two input boxes with default layout.

Later, text entered in inputbox is passed to StripExec() function, together with user action which is tracked by SciTE in variable named "control"


At last **StripExec()** function executes action:

+ action can be executed on buffer text, or buffer selection, or without both
+ "val1" is text from first inputbox, "val2" is text from second inputbox (or "nil" if it doesn't exist), c is dialog control action
+ global StripFunc variable is conditioned for appropriate action


Above example in action:

![screen-shot](http://i.imgur.com/mtaMg.png)
