## Installation

```bash
$ git clone git@github.com:chrishunt/dot-files.git
$ git submodule init
$ git submodule update
$ ln -s .vim/vimrc .vimrc
$ ln -s .vim/gvimrc .gvimrc
```

## Updating

```bash
$ git pull
$ git submodule foreach git pull origin master
```
