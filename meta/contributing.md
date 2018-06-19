# Contributing


These are instructions for the writers. The contents of this page will not be rendered in the output. 

> Because this file is not part of the book and a simple compilation of notes, it is written in Markdown, to facilitate reading and previewing.

## Requirements
Python requirements are included in `requirements.txt`.
Use `pip install -r requirements.txt` to install the pre-requisites for compiling and translating the book.


## About translations (NOT WORKING, DON'T DO THIS)

Translations are done using `sphinx-intl`. I followed the instructions 
on this page to get started: [http://www.sphinx-doc.org/en/master/intl.html#quick-guide](http://www.sphinx-doc.org/en/master/intl.html#quick-guide)
I listed the basic steps below for reference, but I hope this to be a one time thing (Windows). Please see the summary after that.  
  1. Run `make gettext`
     It creates a new folder `build/gettext`, in which the source files are converted to `.pot` files. `.pot` and `.po` files are specific of translation workflows. The `.pot` file contains the "message IDs" for each translatable content.

     * **We dont't need to edit the `.pot` files.**
     * We must re-run `make gettext` if new content is created in English.
       This workflow seems to be optimized for projects in which the first language is finished first :).
       
  2. Run `sphinx-intl update -p _build/gettext -l pt_BR`  Use **pt_BR**
     This creates `/source/locale/pt_BR/`, plus a folder `LC_MESSAGES`, which holds the `.po` files.   
     ** We make the translations in the `.po` files, by editing `msgstr` for each message. For example, after step 1, the file `index.po` will have an entry as follows:
     ```
     #: ../../source/index.rst:17
     msgid "Compositions"
     msgstr ""
     ```

  3. Build for that language (Windows)      
     `sphinx-intl update -p _build/gettext -l pt_BR`
     `make.bat html`
  4. Check output