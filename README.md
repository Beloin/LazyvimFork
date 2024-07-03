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
