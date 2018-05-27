## Compile

### PDF/Word

Install [Pandoc](http://pandoc.org/installing.html).

Then:

`pandoc -i *.md -s --csl=chicago-note-bibliography.csl --filter pandoc-crossref --bibliography references.bib --toc -o ../dist/SCHEIDL_FRIAS_dear-gen-book.docx`

or:

`pandoc -i *.md -s --csl=chicago-note-bibliography.csl --filter pandoc-crossref --bibliography references.bib --toc -o ../dist/SCHEIDL_FRIAS_dear-gen-book.pdf`

### Gitbook

Install [GitBook](https://toolchain.gitbook.com/setup.html).

Then:

1. `cd src`
2. `sh _gitbook.sh`
3. `cd path/to/dist/gitbook`
4. Run

    `gitbook serve`

5. Build

    `gitbook build`

