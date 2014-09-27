# Fusion.vim

TODO: One or two lines of intro
TODO: add a gif somewhere

## Background

TODO: describe vim-projectionist

## Usage

TODO:
:Unite projection-categories
:Unite projection-files
:Unite projection-files <type>
Navigation categories-> files
Navigation files-> categories (to be implemented)

## Example

TODO

## Mapping

TODO

## Installation

**Fusion.vim** depends on [Vim-Projectionist][1] and [Unite][2] plugins.
Use your favourite plugin manager to install the plugins:

### [Pathogen][3]:

  ```
  git clone https://github.com/Shougo/unite.vim ~/.vim/bundle/unite.vim
  git clone https://github.com/tpope/vim-projectionist ~/.vim/bundle/vim-projectionist
  git clone https://github.com/RomainEndelin/fusion.vim ~/.vim/bundle/fusion.vim
  ```

### [Vundle][4]

  ```
  Plugin 'tpope/vim-projectionist'
  Plugin 'Shougo/unite.vim'
  Plugin 'RomainEndelin/fusion.vim'
  ```

### [NeoBundle][5]

  ```
  NeoBundle 'tpope/vim-projectionist'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'RomainEndelin/fusion.vim', {'depends': ['Shougo/unite.vim',
            \ 'tpope/vim-projectionist']}
  ```

## License

Copyright (c) Romain Endelin. Distributed under the same terms as Vim itself.
See `:help license`.


[1]: https://github.com/tpope/vim-projectionist
[2]: https://github.com/Shougo/unite.vim
[3]: https://github.com/tpope/vim-pathogen
[4]: https://github.com/gmarik/vundle
[5]: https://github.com/Shougo/neobundle.vim
