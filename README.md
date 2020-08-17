# Definitely not Vim

This is definitely not the Vim configuration you're looking for.

```text
     ##############..... ##############
     ##############......##############
      ###########._ ......_###########
    __| |####/  _(_).....(_) |#####| |_   _
   / _` |/ _ \ |#| | '_ \| | __/ _ \ | | | |
  | (_| |  __/  _| | | | | | |#  __/ | |_| |
   \__,_|\___|_|#|_|_| |_|_|\__\___|_|\__, |
       ##########.......########      |___/
       ##########_...._##| |###..
       ######| '_ \./ _ \| __|.....
     ..######| |#| | (#) | |_.........
   ....######|_|#|_|\___/ \__|..........
     ..################JJJ............
       ################.............
       ##############.JJJ.JJJJJJJJJJ
       ############...JJ...JJ..JJ  JJ
       ##########....JJ...JJ..JJ  JJ
       ########......JJJ..JJJ JJJ JJJ
       ######    .........
                   .....
                     .
```

Fully XDG base directory spec complaint ".vimrc" (definitely not) configuration
aiming for a small footprint and clean $HOME.

Most of this repository came from [spf13/spf13-vim](https://github.com/spf13/spf13-vim).
However, it's worth mentioning that spf13-vim itself is abandoned,
as well as the Vundle (plugin manager) used in the setup.

For a modern setup I suggest replacing Vundle with [Neobundle](https://github.com/Shougo/neobundle.vim), plus
a refactor in the bundles.vim.

## Installation

Clone this repository to your XDG base configuration home

```bash
git clone https://github.com/macunha1/definitely-not-vim \
    ${XDG_CONFIG_HOME}/vim
```

TL;DR instructions at [Vundle's README](https://github.com/VundleVim/Vundle.vim#quick-start).

```bash
git clone https://github.com/VundleVim/Vundle.vim \
    ${XDG_CONFIG_HOME}/vim/bundle/vundle
```

Edit mainly the [before](before.vim) with your customization, you can pick
some premade "bundle groups" with generic configurations (e.g. programming
languages or "infra" tools). More info at [bundles](bundles.vim).

Once you finish your tweaks, open `vim` anywhere to load the initial setup
(create folders and load stuff) then run `:BundleInstall`.

## License

This is free and unencumbered software released into the public domain.
Unlicensed under [The Unlicense](UNLICENSE).

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

## Credits

Thanks to [spf13](https://github.com/spf13/) for the work at
[spf13-vim](https://github.com/spf13/spf13-vim).
