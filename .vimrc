" ========================
" Opciones Básicas
" ========================
set number              " Mostrar números de línea absolutos
set relativenumber      " Mostrar números relativos para navegación
set tabstop=4           " Número de espacios que representa una tabulación
set shiftwidth=4        " Número de espacios al usar autoindent
set expandtab           " Convierte tabs en espacios
set autoindent          " Indentación automática
set smartindent         " Indentación inteligente
set clipboard=unnamedplus  " Usa el portapapeles del sistema
set cursorline          " Resalta la línea actual
set nowrap              " No hacer wrap de líneas largas
set noswapfile          " No crear archivos de intercambio
set nobackup            " No crear archivos de backup
set undofile            " Habilita archivo de undo persistente
set incsearch           " Búsqueda incremental
set ignorecase          " Ignora mayúsculas en búsquedas
set smartcase           " Respeta mayúsculas si las usas en la búsqueda
syntax on               " Habilita el resaltado de sintaxis
filetype plugin indent on " Habilita detección de tipo de archivo y plugins
set mouse=a "Activa el mouse

" ========================
" Mapeos de teclas
" ========================
inoremap <C-q> <Esc>                  " Salir del modo insert con Ctrl+q
nnoremap <C-q> :q<CR>                 " Salir de Vim con Ctrl+q
nnoremap <C-s> :w<CR>                 " Guardar archivo con Ctrl+s
tnoremap <Esc> <C-\><C-n>            " Esc para salir del modo terminal
tnoremap <C-q> <C-\><C-n>            " Ctrl+q para salir del terminal
vnoremap y "+y<CR>                      " Copiar al portapapeles del sistema
nnoremap // :nohlsearch<CR>         " Borrar resaltado de búsqueda
