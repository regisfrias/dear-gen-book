# Dear Data Book

This is where we write about our adventures with the [Dear Data](https://github.com/regisfrias/dear-gen).

## Compile

### PDF

Install Pandoc:

```
brew install pandoc
```

Then:

`pandoc -i src/*.md -s --toc -o dist/SCHEIDL_FRIAS_dear-data-book.pdf`

### Gitbook

Install [GitBook](https://toolchain.gitbook.com/setup.html).

Then:

1. `cd src`
2. `sh _gitbook.sh`
3. `cd path/to/dist`
4. Run
    `gitbook serve`
5. Build
    `gitbook build`
