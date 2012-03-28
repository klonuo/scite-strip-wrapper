This is one possible wrapper to SciTE Strip ![dialog feature](www.scintilla.org/SciTELua.html) (explained at the botom of linked page)

**StripDlg()** function initializes dialog elements passed to it from SciTE Tool action.

Example Tool action can be:

```
command.name.24.*=Lookfor
command.mode.24.*=subsystem:lua,savebefore:no
<<<<<<< HEAD
command.24.*=StripDlg func=Lookfor dlg='Lookfor:'[](&Go)\n'Package:'[](&Help)
```

StripDlg() function transforms arguments to key=value pairs. Minimum requirement is "func" key, which can be used later for defining custom action
=======
command.24.*=StripDlg func=Lookfor label2=Package button2=Help
```

From which StripDlg() will initialize:  
 - StripFunc global variable set to "Lookfor", which can be conditioned later in StripExec() function  
 - 2 labels: "Lookfor" and "Package"  
 - 2 list input boxes  
 - 2 buttons: "Go" and "Help"  

>>>>>>> 43da8273a0de70a27a23678b8fc7dd5bb7d83496

**OnStrip()** function is SciTE provided interface to strip dialog feature.
Number of dialog widgets is retrieved in StripDlg() in variable w/2 which is used for enumeration of existing dialog widgets and possible values.


<<<<<<< HEAD
At last **StripExec()** function executes action:

+ action can be executed on buffer text, or buffer selection
+ "val1" is text from first inputbox, "val2" is text from second inputbox (or "nil" if it doesn't exist), c is dialog control action
+ global StripFunc variable is conditioned for appropriate action
=======
At last **StripExec()** function executes action:  
 - action can be executed on buffer text, or buffer selection, or without both  
 - "val1" is text from first inputbox, "val2" is text from second inputbox (or "nil" if it doesn't exist), c is dialog control action  
 - global StripFunc variable is conditioned for appropriate action  
>>>>>>> 43da8273a0de70a27a23678b8fc7dd5bb7d83496


Above example in action:

![screen-shot](http://i.imgur.com/mtaMg.png)
