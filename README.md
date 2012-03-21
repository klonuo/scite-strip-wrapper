Two Lua functions are provided, which can be pasted in SciTE (>3.04) Lua start-up script. First is simple wrapper around SciTE strip dialog feature, and other is applied shell wrapper (variant on first script), which could be handy for Linux users.

First script is "documented" in "README-wrapper.md" file - check it out.  
I'll try to explain second one here, which provides 3 tools to help SciTE user in everyday tasks:

  
- **Shell action** (which is shell-pipe more precisely)

Current SciTE selection, or if there is not selection - whole text in current tab (buffer), is piped to `sh` through "here-document" and output printed in SciTE output pane. stderr is also redirected there

<a href="http://i.imgur.com/3b0gM.png">![Simple hexdump on selection](http://i.imgur.com/3b0gMs.png)</a>
  
  
- **Python action**

Similarly, SciTE selection or whole buffer if piped to Python interpreter, which stores it as string variable under name "scite" and allows user, one-liner Python freedom on this object.

<a href="http://i.imgur.com/D0BKi.png">![Word frequency](http://i.imgur.com/D0BKis.png)</a>

Also, something like [pyline](http://code.activestate.com/recipes/437932-pyline-a-grep-like-sed-like-command-line-tool/) can be used instead, in Shell Strip dialog, depending on user preference
  
  
- **Terminal action**

This action doesn't use piping but literally executes command entered in strip dialog inputbox, and outputs on SciTE output pane

<a href="http://i.imgur.com/KDiPZ.png">![Recursive grep](http://i.imgur.com/KDiPZs.png)</a>
  
  
- **History**

All this actions, have "history" feature - there are (+) and (-) buttons which allow saving current snippet or removing it from history. History is stored in a file in user's home folder

![History feature](http://i.imgur.com/Pz1us.png)
  
---

**Known Issues:**

- focus is currently not initially on inputbox
- hitting Enter, while focused on inputbox, does not execute "Go" button, but "Go" button needs to be pressed explicitly. Even more, hitting Enter executes first button (in this case (+)) and adds current snippet to history!

