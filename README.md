# Fusion.vim

[Fusion.vim][7] is a Project-Navigation plugin for vim. It stands on top of two genius projects, from two of the greatest Vim Masters: Tim Pope's [Vim-Projectionist][1] and Shougo's [Unite][2].

In practice it is a simple adapter for Vim-Projectionist into Unite.vim interface, but it ends up being extremely powerful, extensible AND user-friendly.

## Background

Vim-projectionist is a hidden gem from Tim Pope. It isn't that popular as compared to Vim-Rails, but it is basically an abstraction of Vim-Rails' navigation features, that can be configured for any project structure. Its strength is to be generic: once a structure has been define, Projectionist will automatically recognize any project using this structure.

TODO: Continue

## Usage

TODO:
:Unite projection-categories
:Unite projection-files
:Unite projection-files <type>
Navigation categories-> files

TODO: COMPLETE

## Example

TODO add a gif

## Mapping

Fusion.vim doesn't come with any predefined mappings, feel free to add your owns in your vimrc. For example:

    nnoremap goo :Unite projection-categories -start-insert<cr>
    nnoremap goa :Unite projection-files -start-insert<cr>
    nnoremap gom :Unite projection-files -custom-category=model<cr>
    nnoremap goc :Unite projection-files -custom-category=controller<cr>
    nnoremap gov :Unite projection-files -custom-category=view<cr>

TODO more automatic

## Installation

**Fusion.vim** depends on [Vim-Projectionist][3] and [Unite][2] plugins.
TPope's vim-projectionist is not compatible yet with fusion.vim, you will need to use [my fork][3].

Use your favourite plugin manager to install the plugins:

### [Pathogen][4]:

  ```
  git clone https://github.com/Shougo/unite.vim ~/.vim/bundle/unite.vim
  git clone https://github.com/RomainEndelin/vim-projectionist ~/.vim/bundle/vim-projectionist
  git clone https://github.com/RomainEndelin/fusion.vim ~/.vim/bundle/fusion.vim
  ```

### [Vundle][5]

  ```
  Plugin 'RomainEndelin/vim-projectionist'
  Plugin 'Shougo/unite.vim'
  Plugin 'RomainEndelin/fusion.vim'
  ```

### [Vim-Plug][8]

  ```
  Plug 'RomainEndelin/vim-projectionist'
  Plug 'Shougo/unite.vim'
  Plug 'RomainEndelin/fusion.vim'
  ```

### [NeoBundle][6]

  ```
  NeoBundle 'RomainEndelin/vim-projectionist'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'RomainEndelin/fusion.vim', {'depends': ['Shougo/unite.vim',
            \ 'RomainEndelin/vim-projectionist']}
  ```

## License

Copyright (c) Romain Endelin. Distributed under the same terms as Vim itself.
See `:help license`.


[1]: https://github.com/tpope/vim-projectionist
[2]: https://github.com/Shougo/unite.vim
[3]: https://github.com/RomainEndelin/vim-projectionist
[4]: https://github.com/tpope/vim-pathogen
[5]: https://github.com/gmarik/vundle
[6]: https://github.com/Shougo/neobundle.vim
[7]: https://github.com/RomainEndelin/fusion.vim
[8]: https://github.com/junegunn/vim-plug
