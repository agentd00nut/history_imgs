History Imgs
============

wkhtmltoimage powered tool to save image of each page in your browsers history.
Easily find that page you can't remember the name of by browsing images of your history!

Currently only works on osx install since i haven't looked up the default paths for the history
file locations on other distros.  Sounds looks like that'd be a great thing for someone to do!

How to Install
==============

Follow the /setup README.md.  Basically you just need to install wkhtmltoimage for your system...
You also need to have sqlite3, awk, curl, and probably grep.
You probably have those things.

How to Use it
=============

Run `fetch_history.sh`.  This is a jenky little script that will try and dump your chrome and firefox histories to a digestable format in the /data folder.

If you see `Error: table is locked` or a similar message make sure to *QUIT* your firefox / chrome application.
Don't just close the thing, right click, quit (osx).

If it all goes well then you can cat in a data file into `img_saver.sh` make sure to give it the `-o` flag to specify the output dir.

Flags
======

*img_saver.sh*

`-o` The output directory for the saved images... otherwise it saves to the run dir of the script

`-s` Optional.  Seperator string to place between the url and the imgs save path.

`-t` Optional.  Timeout... if a url doesn't respond in under this amount of time just skip it.  Recommended.

Examples
========

Getting images for firefox history while saving the url and image name with a goofy seperator to a file.
`./fetch_history.sh`
`cat ./data/ff_default_history.data | ./img_saver.sh -o "/img/ff" -s "~what_a_uniq_seperator~" -t 1 > my_img_index`

TODO
====

Save the title of the web page along with the url when pulling data from the web browsers.
    Use this title in the name of the imgs and increment the name when there are duplicates.

