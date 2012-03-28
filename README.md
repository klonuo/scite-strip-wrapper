This is extension to [example wrapper](scite-strip-wrapper/blob/master/README-wrapper.md) function around SciTE dialog, which could be handy for Linux users

It provides 2 tools to help SciTE user in everyday tasks:

- **Shell action** (which is shell-pipe more precisely)

Current SciTE selection, or if there is not selection - whole text in current tab (buffer), is piped to `sh` through "here-document" and output printed in SciTE output pane. stderr is also redirected there

<a href="http://i.imgur.com/oJcX2.png">![screen-shot](http://i.imgur.com/oJcX2s.png "shell action")</a>

- **Python action**

Similarly, SciTE selection or whole buffer if piped to Python interpreter, which stores it as string variable under name "scite" and allows user, one-liner Python freedom on this object.

<a href="http://i.imgur.com/sZZUs.png">![screen-shot](http://i.imgur.com/sZZUss.png "python action")</a>

Also, something like [pyline](http://code.activestate.com/recipes/437932-pyline-a-grep-like-sed-like-command-line-tool/) can be used instead, in Shell Strip dialog, depending on user preference

- **History**

All this actions, have "history" feature - (+) and (-) buttons which allow saving current snippet or removing it from history. History is stored in a file in user's home folder