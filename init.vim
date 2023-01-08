"CONFIGURACIONES BASICAS

syntax on
set number 				"muestra los numeros de cada linea en la parte izquierda 
set relativenumber 			"la distribucion de los numeros en lineas de manera relativa
set mouse=a 				"permite la interaccion con el mouse
set noshowmode				"me deja de mostrar el modo en el que estamos 'normal, insert, visual, etc'
syntax enable 				"activa el coloreado de sintaxis en algunos tipos de archivos como html, c, c++
set encoding=utf-8 			"permite setear la codificación de archivos para aceptar caracteres especiales
set sw=2 				"la indentación genera 2 espacios
set nowrap				"el texto en una linea no baja a la siguiente, solo continua en la misma hasta el infinito.
"set noswapfile				"para evitar el mensaje que sale al abrir algunos archivos sobre swap.
set clipboard=unnamed			"para poder utilizar el portapapeles del sistema operativo 'esto permite poder copiar y pegar desde cualquier parte a nvim y viceversa.


"INSTALACION DE PLUGGINS

call plug#begin('~/AppData/Local/nvim/plugged') 	"directorio donde se van a instalar los plugins

"plugins
Plug 'joshdick/onedark.vim' 		  "tema
Plug 'Yggdroot/indentLine' 		    "indentacion
Plug 'mattn/emmet-vim' 			      "emmet para diseño web
Plug 'vim-airline/vim-airline'		"diseño de la barra en la cual se muestran los modos, la linea, etc.
Plug 'vim-airline/vim-airline-themes'	"temas para el vim-airline
Plug 'preservim/nerdtree'		      "gestor de archivos en forma de arbol.
Plug 'christoomey/vim-tmux-navigator'	"poder navegar entre archivos abiertos
Plug 'jiangmiao/auto-pairs'		    "autocompletado de llaves, corchetes, etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}	"autocompletado inteligente
Plug 'ray-x/web-tools.nvim'       "Live-Server para Neovim

call plug#end() 			"cerramos el llamado de los plugins


"CONFIGURACIONES	

"configuracion del tema
set termguicolors 			"activa el true color en la terminal
colorscheme onedark 			"activar el tema onedark


"configuracion de emmet-vim
let g:user_emmet_leader_key=',' 	"mapeando la tecla lider por una coma, con esto se completa los tag con doble coma.


"configuracion de vim-airline
let g:airline#extensions#tabline#enabled = 1	"muestra la linea de pestaña en la que estamos buffer
let g:airline#extensions#tabline#formatter = 'unique_tail'	"muestra solo el nombre del archivo que estamos modificando
let g:airline_theme='onedark'	"el tema de airline


"configuracion de nerdtree
"mapeando el abrir y cerrar de nerdtree con nerdtreetoggle vemos los archivos en el arbol y podemos cerrarlo a la vez, map es la C mayuscula representa el
"control y -n la tecla n lo que indica que realizará la siguiente funcion de excribir el comando NERDTreeToggle y CR significa ENTER.
map <C-n> :NERDTreeToggle<CR>


"configuracion por defecto de coc
" TextEdit fallara si no se establece hidden.
set hidden

" Algunos servidores tienen problemas con los archivos de copia de seguridad, véase #649.
set nobackup
set nowritebackup

" Ofrece más espacio para mostrar mensajes.
set cmdheight=2

" Si el tiempo de actualización es más largo (por defecto es 4000 ms = 4 s), se notarán más 
" retrasos y una mala experiencia de usuario.
set updatetime=300

" No pasa mensajes a |ins-completion-menu|.
set shortmess+=c

" Mostrar siempre la columna de signos, de lo contrario se desplazaría el texto
" cada vez que aparezcan/se resuelvan diagnósticos.
if has("patch-8.1.1564")
  " Neovim fusiona la columna de signos y la columna de números en una sola.
  set signcolumn=number
else
  set signcolumn=yes
endif

" Utiliza el tabulador para completar el disparo con caracteres por delante y navegar.
" NOTA: Usa el comando ':verbose imap <tab>' para asegurarte de que el tabulador no está mapeado por
" otro plugin antes de poner esto en la configuración.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Usa <c-space> para activar la finalización.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Hacer <CR> auto-seleccionar el primer elemento de finalización y notifica coc.nvim a
" al entrar, <cr> podría ser reasignado por otro plugin de vim.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Usa `[g` and `]g` para navegar por los diagnósticos
" Usa `:CocDiagnostics` para obtener todos los diagnósticos del buffer actual en la lista de ubicaciones.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Navegación por el código GoTo.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Usa K para mostrar la documentación en la ventana de vista previa.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Resalta el símbolo y sus referencias cuando se mantiene el cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Renombrar símbolos.
nmap <leader>rn <Plug>(coc-rename)

" Dar formato al código seleccionado.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Configurar formateo xpr tipo(s) de archivo(s) especificado(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Actualiza la ayuda de firma en marcador de posición de salto.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Aplica codeAction a la región seleccionada.
" Ejemplo: `<leader>aap` para el párrafo actual
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Reasigna teclas para aplicar codeAction al buffer actual.
nmap <leader>ac  <Plug>(coc-codeaction)
" Aplica AutoFix al problema en la línea actual.
nmap <leader>qf  <Plug>(coc-fix-current)

" Función Map y objetos de texto de clase
" NOTA: Requiere soporte 'textDocument.documentSymbol' del servidor de idiomas.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Reasignar <C-f> y <C-b> para ventanas flotantes de desplazamiento/ventanas emergentes.
" Nota coc#float#scroll funciona en neovim >= 0.4.0 o vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Asignación exclusiva de NeoVim para el desplazamiento en modo visual
" Útil en la firma, ayuda después del salto del marcador de posición de expansión fragmento
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Usa CTRL-S para los rangos de selección.
" Requiere el soporte 'textDocument/selectionRange' del servidor de idiomas.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Añade el comando `:Format` para formatear el buffer actual.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Añade el comando `:Fold` para plegar el buffer actual.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Añade el soporte nativo de la línea de estado de (Neo)Vim.
" NOTA: Por favor, mira `:h coc-status` para integraciones con plugins externos que
" proporcionan líneas de estado personalizadas: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Asignaciones para CoCList
" Muestra todos los diagnósticos.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Gestiona extensiones.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Muestra los comandos.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Busca el símbolo del documento actual.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Busca los símbolos del espacio de trabajo.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Realiza la acción por defecto para el siguiente elemento.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Realiza la acción por defecto para el elemento anterior.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Reanudar la última lista de coc.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
