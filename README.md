# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Languages

## C/C++

Straightforward, starts from `LazyVim` extras.

If still has some things to match, see [this link](https://igorlfs.github.io/neovim-cpp-dbg) 

### Make

1. Use `bear -- make`, this creates metadata in `compile_commands.json`

### CMake

1. For now generate compile_commands using cmake and copy to outer folder using this commands: 
  - `cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1`
  - `ln -s build/compile_commands.json compile_commands.json`


## Python

1. Install pyvim: `python3 -m pip install pynvim --upgrade`

## Java

1. Default `Lazy.vim` Java extra
2. Install maven 
3. In Mason:
  - `jdtls` -- Already should be installed by lazyvim
  - `google-java-format`


## Flutter

Basically using flutter-tools.nvim and installing TS with `TSInstall dart`.

# DAP

Can have more informations [here](https://github.com/NormalNvim/NormalNvim/blob/a1c48324fe8e410118a546514259fb5fdd9809e4/lua/plugins/4-dev.lua#L337).

# Optionals

## Plantuml

Packages:
1. [Plantuml](https://gitlab.com/itaranto/plantuml.nvim) 
2. [SoilUml](https://github.com/javiorfo/nvim-soil) 

- Install deps `sudo pacman -S plantuml imv feh`

# Tests

Already defaults on Lazy.extras
