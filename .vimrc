syntax enable                   " Enable syntax highlighting

set background=dark
colorscheme solarized           " Use Solarized color scheme

set backspace=indent,eol,start  " Set Backspace behavior
set ruler                       " Show ruler
set showmode                    " Show current mode
set showmatch                   " Highlight matching delimiters

set number                      " Show line numbers
set showcmd                     " Show current command

set tabstop=4                   " How many columns are displayed for a tab
set softtabstop=4               " How many columns to indent when Tab is pressed
set shiftwidth=4                " How many columns to indent with reindent operations
set expandtab                   " Replace tabs with spaces

set autoindent                  " Copy indentation from previous line
set smartindent                 " Add additional indentation for certain statements

set incsearch                   " Perform incremental searches
set hlsearch                    " Highlight search results
set ignorecase                  " Case-insensitive searches when no capital letter present
set smartcase                   " Case-sensitive searches when capital letter present

set foldenable                  " Enable folding
set foldmethod=indent           " Fold based on indentation
set foldlevelstart=99           " Open all folds when opening a file
set foldnestmax=10              " Maximum number of nested folds
