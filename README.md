# Definitely not Vim

This is definitely not the Vim configuration you're looking for.

```text
                     .
     ##############..... ##############
    _#| |####/  _(_).....(_) |#####| |#   _
   / _` |/ _ \ |#| | '_ \| | __/ _ \ | | | |
  | (_| |  __/  _| | | | | | |#  __/ | |_| |
   \__,_|\___|_|#|_|_| |_|_|\__\___|_|\__, |
       ##########_...._##| ###..      |___/
       ######| '_ \./ _ \| __|.....
     ..######| |#| | (#) | |_.........
   ....######|_|#|_|\___/#\__|..........
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

Fully XDG base directory spec complaint ".vimrc" (definitely not vimrc)
configuration aiming for a small footprint, self-contained, declarative and most
important CLEAN `$HOME`. "Tidy $HOME, Tidy Mind"

Definitely not Vim is a modern adaptation of [spf13/spf13-vim](https://github.com/spf13/spf13-vim).
Including XDG base directory, updated [plugins](plugins.vim) sources and the
best plugin manager out there: [Dein.vim](https://github.com/Shougo/dein.vim)

## Installation

Clone this repository to your XDG base configuration home

```bash
git clone https://github.com/macunha1/definitely-not-vim \
    ${XDG_CONFIG_HOME}/vim
```

TL;DR instructions from [Dein.vim's README](https://github.com/Shougo/dein.vim#quick-start).

```bash
git clone https://github.com/Shougo/dein.vim \
    ${XDG_CONFIG_HOME}/vim/plugins/dein.vim
```

Edit mainly the [before file](before.vim) with your customization, you can pick
some premade "plugin groups" with generic configurations (e.g. programming
languages or "infra" tools). More info at [plugins](plugins.vim).

Once you finish your tweaks with the configuration files, open `vim` anywhere
to load the initial setup (create folders, downloads plugins and load stuff).
Additionally, `Dein.vim` will inspect changes in plugins list and install the
delta every time `vim` starts.

Lastly, let `vim` know where you're hiding the configuration changing `VIMINIT`
environment variable value to

``` bash
export VIMINIT="source ${XDG_CONFIG_HOME}/vim/init.vim" # or anywhere else
```

Make sure you persist this environment variable in your profile (e.g.
`.bash_profile`, `.zprofile`) to automatically load for future sessions

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
