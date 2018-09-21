# Vim-Whelp

Keep track of what you've looked up in vim's help.

## Overview

You know how some people highlight words they've looked up in the dictionary? I'm not one of those people. But on a whim, I did write this little plugin to keep track of things you've looked up in vim's help. Every time you run `:h something` or `:help something`, vim-whelp records it in a text file. You can then later open that file and browse around and even reopen the help entry.

## Requirements

I'm not exactly sure . . . I'm guessing this works best with vim 7.4 and later, but I haven't feature checked.

## Installation

If you don't have a preferred installation method, I really like vim-plug and recommend it.

#### Manual

Clone this repository and copy the files in plugin/, autoload/, and doc/ to their respective directories in your vimfiles, or copy the text from the github repository into new files in those directories. Make sure to run `:helptags`.

#### Plug (https://github.com/junegunn/vim-plug)

Add the following to your vimrc, or something sourced therein:

```vim
Plug 'tandrewnichols/vim-whelp'
```

Then install via `:PlugInstall`

#### Vundle (https://github.com/gmarik/Vundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
Plugin 'tandrewnichols/vim-whelp'
```

Then install via `:BundleInstall`

#### NeoBundle (https://github.com/Shougo/neobundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
NeoBundle 'tandrewnichols/vim-whelp'
```

Then install via `:BundleInstall`

#### Pathogen (https://github.com/tpope/vim-pathogen)

```sh
git clone https://github.com/tandrewnichols/vim-whelp.git ~/.vim/bundle/vim-whelp
```

## Usage

TODO

## Contributing

I always try to be open to suggestions, but I do still have opinions about what this should and should not be so . . . it never hurts to ask before investing a lot of time on a patch.

## License

See [LICENSE](./LICENSE)
