" ======================================================================================
" File         : .vimrc
" Author       : cpiger@qq.com
" Last Change  : 
" Description  : 
" ======================================================================================
"/////////////////////////////////////////////////////////////////////////////
" Init
"/////////////////////////////////////////////////////////////////////////////
set nocompatible         " Use Vim settings, rather then Vi settings (much better!). This must be first, because it changes other options as a side effect.
function! OSX()
    return has('macunix')
endfunction
function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction

" always use English menu
" NOTE: this must before filetype off, otherwise it won't work
set langmenu=none
" use English for anaything in vim-editor. 
if WINDOWS()
    silent exec 'language english'
elseif OSX()
    silent exec 'language en_US' 
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        " in mac-terminal
        silent exec 'language en_US' 
    else
        " in linux-terminal
        silent exec 'language en_US.utf8' 
    endif
endif

" try to set encoding to utf-8
set fileencodings=ucs-bom,utf-8,gbk,gb2312,gb18030,cp936,latin1
if WINDOWS()
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has('multi_byte')
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        set termencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        " setglobal fileencoding=utf-8
        set fileencoding=chinese
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        " set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
        set fileencodings=ucs-bom,utf-8,gbk,gb2312,gb18030,cp936,latin1
    endif
else
    " set default encoding to utf-8
    set encoding=utf-8
    set fileencoding=utf-8
    set termencoding=utf-8
endif
scriptencoding utf-8

if has('win32') || has('win64')
    let &shell='cmd.exe'
endif

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if WINDOWS()
    let g:exvim_custom_path=$VIM
    " set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set runtimepath=$VIM/vimfiles
    set runtimepath+=$VIMRUNTIME
    set runtimepath+=$VIM/vimfiles/after
    set runtimepath+=$HOME/.vim/after
    set runtimepath+=$VIM/vimfiles
    set runtimepath+=$VIM/tools
    let g:ex_tools_path = g:exvim_custom_path.'/tools/'
endif
let g:ex_usr_name = "yang"
let g:ex_dir_prefix = '.exvim'
" let g:mapleader=","
let g:mapleader="\<Space>"

" setup back and swap directory
set backup " make backup file and leave it around 
" set noswf
set undofile
let data_dir = $HOME.'/.data/'
let backup_dir = data_dir . 'backup' 
let swap_dir = data_dir . 'swap' 
let undo_dir = data_dir . 'undo' 

if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
if finddir(undo_dir) == ''
    silent call mkdir(undo_dir)
endif
set backupdir=$HOME/.data/backup " where to put backup file 
set directory=$HOME/.data/swap " where to put swap file 
set undodir  =$HOME/.data/undo " where to put undo file 
" unlet data_dir
unlet backup_dir
unlet swap_dir
unlet undo_dir

"/////////////////////////////////////////////////////////////////////////////
" Bundle steup
"/////////////////////////////////////////////////////////////////////////////
filetype plugin indent on " required
syntax on " required

call plug#begin('$VIM/vimfiles/plugged')
" ------------------------------------------------------------------
Plug 'cpiger/a.vim'         
" ------------------------------------------------------------------
" Plug 'mileszs/ack.vim'
" ------------------------------------------------------------------
" Plug 'rking/ag.vim'
" ------------------------------------------------------------------
" noremap <F3> :LAck <C-r>=expand('<cword>')<CR><CR> 
" vmap <F3> <C-C>:LAck <C-R>='"'.substitute(escape(@*,'\/'),'\n','\\n','g').'"'<CR><CR>
" let g:ackprg = 'ag --nogroup --nocolor --column'
" or:
" let g:ackprg = 'ag --vimgrep'
" let g:ag_lhandler="lopen"
let g:ag_lhandler="lopen"
" let g:ag_lhandler="belowright lopen"
" noremap <leader>ag :LAg  <C-r>=expand('<cword>')<CR><CR>
" noremap <F3> :LAg  <C-r>=expand('<cword>')<CR><CR>
" ------------------------------------------------------------------
" Plug 'w0rp/ale'
" ------------------------------------------------------------------
Plug 'skywind3000/asyncrun.vim', {'on': 'AsyncRun' }
" ------------------------------------------------------------------
Plug 'itchyny/calendar.vim', { 'on': 'Calendar'}
" ------------------------------------------------------------------
Plug 'Shougo/context_filetype.vim'
" ------------------------------------------------------------------
" Plug 'kien/ctrlp.vim'
" ------------------------------------------------------------------
" let g:ctrlp_working_path_mode = ''
" let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
" nnoremap <unique> <leader>bs :CtrlPBuffer<CR>
" ------------------------------------------------------------------
Plug 'cpiger/DirDiff.vim'       
" ------------------------------------------------------------------
" let g:DirDiffExcludes = "roc,CVS,*.lo,*.in,*.am,*.deps,*.libs,*.class,*.exe,.*.swp,.svn,*svn*,*.a,*.so,*.o,.quick_gen_project_*,.vimfiles*,*.vimentry,app-3110e"
let g:DirDiffExcludes = "*.git,*.d,*.lst,*.obj,*.Opt,*.Uv2,*.plg,CVS,*.lo,*.cmd,*.ko,*.symvers,*.order,*.mod,*.mod.c,*.save,*.cache,*.deps,*.libs,*.class,*.exe,.*.swp,.svn,*svn*,*.a,*.so,*.o,.quick_gen_project_*,.vimfiles*,*.vimentry,app-3110e"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
" let g:DirDiffAddArgs = "-b -w -B" 
" let g:DirDiffAddArgs = "-b" 
let g:DirDiffAddArgs = "-w" 
" let g:DirDiffAddArgs = "-B" 
" let g:DirDiffSort = 1
" let g:DirDiffWindowSize = 14
" let g:DirDiffIgnoreCase = 0 
let g:DirDiffEnableMappings = 1
" ------------------------------------------------------------------
Plug 'vim-scripts/DoxyGen-Syntax'
Plug 'vim-scripts/DoxygenToolkit.vim'
" ------------------------------------------------------------------
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns   "
" let g:DoxygenToolkit_blockHeader="---------------------------------"
" let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="cpiger"
let g:DoxygenToolkit_licenseTag="license"
" ------------------------------------------------------------------
Plug 'mattn/emmet-vim'
" ------------------------------------------------------------------
" make sure emmet only enable in html,css files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" ------------------------------------------------------------------
Plug 'cpiger/ex-aftercolors'
" ------------------------------------------------------------------
Plug 'cpiger/ex-colorschemes'
" ------------------------------------------------------------------
Plug 'cpiger/ex-config'
" ------------------------------------------------------------------
let g:ex_update_async = 1
let g:ex_update_bwipe = 0
nnoremap <silent><leader>up :Update<CR>
nnoremap <silent><F6>   :Update<CR>
" ------------------------------------------------------------------
Plug 'exvim/ex-cref'
" ------------------------------------------------------------------
Plug 'cpiger/ex-cscope'
Plug 'joereynolds/gtags-scope'
" Plug 'cpiger/gtags.vim'
let GtagsCscope_Auto_Load = 0
let CtagsCscope_Auto_Map = 0
let GtagsCscope_Quiet = 1
" ------------------------------------------------------------------
let g:ex_cscope_winsize = 15
let g:ex_symbol_select_cmd = 'CScopeSelect'
" ------------------------------------------------------------------
" Desc: ex-cscope
" c: Find functions calling this function
" d: Find functions called by this function
" e: Find this egrep pattern
" f: Find this file         (NO NEED USE THIS FUNCTION)
" g: Find this definition
" i: Find files #including this file
" s: Find this C symbol
" t: Find this text string  (NO NEED USE THIS FUNCTION)
" ------------------------------------------------------------------
let g:excs_backto_editbuf = 0
let g:excs_close_when_selected = 0
let g:excs_window_direction = 'bel'
let g:excs_window_width = 48

set cscopequickfix=s-,c-,d-,i-,t-,e-
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" ------------------------------------------------------------------
Plug 'cpiger/ex-macrohl'
Plug 'cpiger/ex-easyhl'
" ------------------------------------------------------------------
"  Desc:
" ------------------------------------------------------------------
hi ex_easyhl_cursorhl gui=none guibg=White term=none cterm=none ctermbg=white 
hi EX_HL_label1 gui=none guibg=Green term=none cterm=none ctermbg=lightcyan
" hi ex_easyhl1 gui=none guibg=LightCyan term=none cterm=none ctermbg=lightcyan
hi ex_easyhl2 gui=none guibg=LightMagenta term=none cterm=none ctermbg=lightmagenta
hi ex_easyhl3 gui=none guibg=LightRed term=none cterm=none ctermbg=lightred
hi ex_easyhl4 gui=none guibg=LightGreen term=none cterm=none ctermbg=lightgreen
nnoremap <unique> <silent><leader>s12 :%s/<c-r>q/<c-r>w/g<CR><c-o>
vnoremap <unique> <silent><leader>s12  :s/<c-r>q/<c-r>w/g<CR><c-o>
" ------------------------------------------------------------------
Plug 'cpiger/ex-gsearch'
" ------------------------------------------------------------------
let g:ex_gsearch_winsize = 15
" ------------------------------------------------------------------
Plug 'cpiger/ex-hierarchy'
" ------------------------------------------------------------------
nnoremap <unique> <leader>hv :EXHierarchyCWord<CR>
" ------------------------------------------------------------------
Plug 'cpiger/ex-mark'
" ------------------------------------------------------------------
nmap <unique> <a-y> <Plug>MarkSet
xmap <unique> <a-y> <Plug>MarkSet
nmap <unique> <Leader>R <Plug>MarkRegex
xmap <unique> <Leader>R <Plug>MarkRegex
nmap <unique> <A-u> <Plug>MarkClear

nmap <unique> <Leader>M* <Plug>MarkSearchCurrentNext
nmap <unique> <Leader>M# <Plug>MarkSearchCurrentPrev
nmap <unique> <Leader>M/ <Plug>MarkSearchAnyNext
nmap <unique> <Leader>M? <Plug>MarkSearchAnyPrev
nmap <unique> * <Plug>MarkSearchNext
nmap <unique> # <Plug>MarkSearchPrev
" ------------------------------------------------------------------
let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingPalette = 'maximum'
" let g:mwDefaultHighlightingNum = 9
" ------------------------------------------------------------------
Plug 'cpiger/ex-marksbrowser'
" ------------------------------------------------------------------
nnoremap <unique> <leader>ms :ExmbToggle<CR>
nnoremap <unique> <a-m> :ExmbToggle<CR>
let g:ex_mb_winsize = 15
let g:exmb_backto_editbuf = 0
let g:exmb_close_when_selected = 0
let g:exmb_window_direction = 'bel'
" ------------------------------------------------------------------
Plug 'cpiger/ex-matchit'
" ------------------------------------------------------------------
" Plug 'cpiger/ex-minibuf'
" Plug 'fholgado/minibufexpl.vim'
" ------------------------------------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1
" nnoremap <buffer> <TAB>   :call search('\[[0-9]*:[^\]]*\]')<CR>:<BS>
" nnoremap <buffer> <S-TAB> :call search('\[[0-9]*:[^\]]*\]','b')<CR>:<BS>
let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines) 
let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.  
"g:miniBufExplUseSingleClick=1则导致跟vimshell patch 被输入':if bufname("%") == "-MiniBufExplorer-" <bar> call <SID>MBEClick() <bar> endif <CR>'冲突 TODO:
" let g:miniBufExplMaxSize = 1 " <max lines: default 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers. 
let g:miniBufExplMaxSize = 1
" let g:miniBufExplMaxSize = <max width: 0> 
" comment out this, when we open a single file by we, we don't need minibuf opened. Minibu always open in exDev mode, in EnvironmentUpdate 
let g:miniBufExplorerMoreThanOne = 2 " Setting this to 0 will cause the MBE window to be loaded even

"let g:miniBufExplForceSyntaxEnable = 1 " There is a VIM bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplMapWindowNavArrows = 1

function Exec_3G()
    let aline = line(".")
    if aline <= 2
        exec   "normal 3G" 
    endif 
endfunction
autocmd BufReadPost,BufAdd,BufCreate,BufWinEnter,WinEnter __Tag_List__,__Tagbar__.1 call Exec_3G()
" autocmd VimEnter * silent GtagsCscope
autocmd CursorMoved __Tag_List__,__Tagbar__.1 call Exec_3G()
" ------------------------------------------------------------------
Plug 'cpiger/ex-project'
" ------------------------------------------------------------------
let g:ex_project_stay_after_select = 0
let g:ex_project_winpos='right'
noremap <silent><F9> :call ToggleProjectExplorer()<CR>
function ToggleProjectExplorer()
    let project_name = vimentry#get('project_name')
    if project_name == ''
        silent exec "NERDTreeToggle"
    else
        silent exec "NERDTreeClose"
        silent exec "EXProjectToggle"
    endif
endfunction

nnoremap <unique> <leader>ve :call exconfig#edit_cur_vimentry ()<CR>
hi default link ex_pj_tree_line NonText
Plug 'cpiger/ex-qfix'
" ------------------------------------------------------------------
let g:ex_qfix_winsize=15
nnoremap <silent> <F1> :EXQFixToggle<CR>
inoremap <silent> <F1> <ESC>:EXQFixToggle<CR>
" nnoremap <silent> <F1> :QFix<CR>
" ------------------------------------------------------------------
Plug 'cpiger/ex-searchcompl'
" ------------------------------------------------------------------
" ------------------------------------------------------------------
Plug 'cpiger/ex-showmarks'
" ex-showmarks: invoke by m... or <leader>mm, <leader>ma
" ------------------------------------------------------------------
" Desc: ShowMarks
"       <Leader>mt  - Toggles ShowMarks on and off.
"       <Leader>mo  - Turns ShowMarks on, and displays marks.
"       <Leader>mh  - Clears a mark.  or <leader>mc
"       <Leader>ma  - Clears all marks.
"       <Leader>mm  - Places the next available mark.
" ------------------------------------------------------------------
" TODO: bootleq/ShowMarks on github is well organized in code, but have lots 
" bugs, consider merge his code and fixes the bugs 
let g:showmarks_enable = 1
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:showmarks_ignore_type = 'hqm' " Ignore help, quickfix, non-modifiable buffers
" Hilight lower & upper marks
" Ignore help, quickfix, non-modifiable buffers
" Hilight lower & upper marks
let g:showmarks_textlower=">"
" let g:showmarks_textupper="*"
" let g:showmarks_textother="-"
let showmarks_hlline_lower = 1
" let showmarks_hlline_lower = 0
let showmarks_hlline_upper = 1 
" let showmarks_hlline_upper = 0 
" 禁用showmark的色彩
" hi default ShowMarksHLl ctermfg=white    ctermbg=blue   guifg=wheat    guibg=peru
" hi default ShowMarksHLu ctermfg=darkblue ctermbg=blue   cterm=bold     guifg=blue guibg=lightblue gui=bold
" hi default ShowMarksHLm ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72  guifg=Black
" hi default ShowMarksHLo ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF  guifg=Black 
" 禁用showmark的色彩 for molokai 用molokai 的nomal颜色,好像不设置这4个
" 颜色ShowMarksHLo ShowMarksHLm ShowMarksHLu ShowMarksHLl，就可以
" hi default ShowMarksHLo ctermfg=none ctermbg=234  guibg=#272822 
" hi default ShowMarksHLm ctermfg=none ctermbg=234  guibg=#272822
" hi default ShowMarksHLu ctermfg=none ctermbg=234  guibg=#272822
" hi default ShowMarksHLl ctermfg=none ctermbg=234  guibg=#272822
" ------------------------------------------------------------------
Plug 'cpiger/ex-symbol'
" ------------------------------------------------------------------
let g:ex_symbol_select_cmd = 'TS'
" ------------------------------------------------------------------
" DISABLE: use tagbar instead
" ------------------------------------------------------------------
Plug 'cpiger/ex-taglist'
" Plug 'cpiger/ex-tagbar'
" Plug 'majutsushi/tagbar' "cause cursor lag
" autocmd FileType tagbar setlocal nocursorline nocursorcolumn
" ------------------------------------------------------------------
nnoremap <unique> <silent> <F2> :Tlist<CR>:call Exec_3G()<CR>
nnoremap <unique> <silent> <S-F2> :Tlist<CR>:call Exec_3G()<CR>
" nnoremap <unique> <silent> <S-F2> :TagbarToggle<CR>:call Exec_3G()<CR>
" nnoremap <unique> <silent> <F2> :TagbarToggle<CR>:call Exec_3G()<CR>

if has("win32")
    " let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool 
    " let Tlist_Ctags_Cmd = 'c:\WINDOWS\system32\ctags.exe' " location of ctags tool 
    " let Tlist_Ctags_Cmd = $VIM.'\bin\ctags.exe' " location of ctags tool 
    let Tlist_Ctags_Cmd = $VIM.'\tools\bin\ctags.exe' " location of ctags tool 
endif
let Tlist_Show_Menu = 0
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself 
let Tlist_Use_Right_Window = 0 " split to the right side of the screen 
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_BackToEditBuffer = 1 " If no close on select, let the user choose back to edit buffer or not
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 35 
let Tlist_Compact_Format = 1 " do not show help. Remove extra information and blank lines from the taglist window.
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

" let taglist support shader language as c-like language
let tlist_hlsl_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;v:variable;f:function'

" let g:tagbar_map_preview = '<CR>'
let g:tagbar_map_jump = '<CR>'
if has('gui_running')
    let g:tagbar_map_close = '<Esc>' 
else
    let g:tagbar_map_close = '<leader><Esc>' 
endif
" let g:tagbar_map_zoomwin = '<Space>' 
let g:tagbar_map_zoomwin = 'z' 
let g:tagbar_left = 1
let g:tagbar_width = 35
let g:tagbar_zoomwidth = 80
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0
let g:tagbar_sort = 0
" let g:tagbar_compact = 1
" let g:tagbar_expand = 1
let g:tagbar_foldlevel = 1
" let g:tagbar_autoshowtag = 1
" let g:tagbar_updateonsave_maxlines = 10000
" let g:tagbar_systemenc = 'cp936'
if has ("unix")
    let g:tagbar_iconchars = ['?', '▼'] " (default on Linux and Mac OS X)
endif
" let g:tagbar_iconchars = ['?', '?']
" let g:tagbar_iconchars = ['?', '◢']
" let g:tagbar_iconchars = ['+', '-']  (default on Windows)
let g:tagbar_singleclick = 1

" use command ':TagbarGetTypeConfig lang' change your settings 
let g:tagbar_type_javascript = {
            \ 'ctagsbin': 'ctags',
            \ 'kinds' : [
            \ 'v:global variables:0:0',
            \ 'c:classes',
            \ 'p:properties:0:0',
            \ 'm:methods',
            \ 'f:functions',
            \ 'r:object',
            \ ],
            \ }
let g:tagbar_type_c = {
            \ 'kinds' : [
            \ 'd:macros:0:0',
            \ 'p:prototypes:0:0',
            \ 'g:enums',
            \ 'e:enumerators:0:0',
            \ 't:typedefs:0:0',
            \ 's:structs',
            \ 'u:unions',
            \ 'm:members:0:0',
            \ 'v:variables:0:0',
            \ 'f:functions',
            \ ],
            \ }
let g:tagbar_type_cpp = {
            \ 'kinds' : [
            \ 'd:macros:0:0',
            \ 'p:prototypes:0:0',
            \ 'g:enums',
            \ 'e:enumerators:0:0',
            \ 't:typedefs:0:0',
            \ 'n:namespaces',
            \ 'c:classes',
            \ 's:structs',
            \ 'u:unions',
            \ 'f:functions',
            \ 'm:members:0:0',
            \ 'v:variables:0:0',
            \ ],
            \ }
let g:tagbar_type_vimwiki = {
            \ 'ctagstype' : 'vimwiki',
            \ 'kinds'     : [
            \ 'h:header',
            \ ],
            \ 'sort'    : 0
            \ }

Plug 'cpiger/ex-tags'
" ------------------------------------------------------------------
let g:ex_tags_winsize = 15
" DISABLE: nnoremap <unique> <leader>] :exec 'ts ' . expand('<cword>')<CR>
" ------------------------------------------------------------------
Plug 'cpiger/ex-utility'
" ------------------------------------------------------------------
nnoremap <unique> <silent> <Leader>bd :EXbd<CR>:bprev<CR>
nnoremap <unique> <silent> <C-l> :EXbn<CR>
nnoremap <unique> <silent> <C-h> :EXbp<CR>
" nnoremap <unique> <silent> <C-Tab> :EXbalt<CR>
" nnoremap <unique> <silent> <Leader><Tab> :EXsw<CR>
nnoremap <unique> <silent> <Leader><Tab> :EXbalt<CR>
nmap <unique> <silent> <Leader><Esc> :EXgp<CR><ESC>

vnoremap <unique> <Leader><F10> :call ex#InsertRemoveExtend()<CR>
" Desc: Insert '#if 0' and '#endif' between the selection
vnoremap <unique> <S-F10> :call ex#InsertIFZero()<CR>
nnoremap <unique> <S-F10> :call ex#RemoveIFZero()<CR>
" ------------------------------------------------------------------
Plug 'cpiger/ex-vimentry'
" ------------------------------------------------------------------
Plug 'cpiger/ex-visincr'
" ------------------------------------------------------------------
Plug 'mbbill/fencview'
" ------------------------------------------------------------------
nnoremap <silent> <Leader>fa :FencAutoDetect <CR>
let g:fencview_autodetect = 0    "会导致<leader>gg 出问题？
" ------------------------------------------------------------------
Plug 'cpiger/vim-l9'
Plug 'cpiger/FuzzyFinder'
" ------------------------------------------------------------------
"noremap <F3> :MRU<cR>
"let MRU_Max_Entries =200 
"let MRU_Auto_Close = 0 
function GotoMainEditBuffer()
    if &modifiable
        return
    endif
    let win_count = winnr('$')
    for i in range(1, win_count)
        wincmd w
        if &modifiable
            return
        endif
    endfor
endfunction

if has('win32') || has('win64')
    " let g:fuf_coveragefile_external_cmd = 'es.exe'
    let g:fuf_coveragefile_external_cmd = 'fd -t f'
else
    let g:fuf_coveragefile_external_cmd = 'fd -t f'
endif
let g:fuf_cmd_prefix = 'F'
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|ilk|pdb|lib|exp|user)$|(GPATH|GRTAGS|GTAGS|macrohl)$|(^|[/\\])\.(hg|git|bzr|exvim.*)($|[/\\])'
  let g:fuf_ignoreCase = 1
  " let g:fuf_ignoreCase = 0
let g:fuf_keySwitchMatching = '<C-\><C-\>'
" let g:fuf_keySwitchMatching = '<C-Tab>'
" let g:fuf_patternSeparator = ';'
let g:fuf_patternSeparator = ' '
let g:fuf_previewHeight = 0
let g:fuf_modesDisable = []
let g:fuf_maxMenuWidth = 168
" let g:fuf_mrucmd_maxItem = 400
let g:fuf_mrufile_maxItem = 100
let g:fuf_enumeratingLimit = 50

" let g:fuf_splitPathMatching = 1
" let g:fuf_promptHighlight = 'Question'
" let g:fuf_fuzzyRefining = 0

noremap <silent> <S-F8> :FRenewCache<CR>
let g:fuf_taggedfile_cache_dir = '~/.vim-fuf-cache/taggedfile'

function! GetAllVimCommands()
    redir => commands
    silent command
    redir END
    return map((split(commands, "\n")[3:]),
                \      '":" . matchstr(v:val, ''^....\zs\S*'')')
endfunction
command! -range -bang -narg=? FCmd :call fuf#givencmd#launch('', 0, '>Command>', GetAllVimCommands())
nnoremap <silent> <A-c> :FCmd<CR>
nnoremap <silent> <leader>fc :FCmd<CR>

noremap  <silent> <leader>ag :FAg <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent> <leader>fb :FBuffer<CR>
nnoremap <silent> <A-b>      :FBuffer<CR>
nnoremap <silent> <A-t>      :FBufferTag<CR>
nnoremap <silent> <A-T>      :FBufferTagAll<CR>
nnoremap <silent> <A-e>      :FLine<CR>
nnoremap <silent> <leader>fl :FLine<CR>
nnoremap <silent> <A-f>      :FCoverageFile<CR>
nnoremap <silent> <A-F>      :FRenewCache<CR>:FufCoverageFile<CR>
nnoremap <silent> <leader>fd :FDir<CR>
nnoremap <silent> <leader>mr :FMruFile<CR>
nnoremap <silent> <leader>:  :FMruCmd<CR>
function! FufTaggedFile_exVim(args)
    let project_name = vimentry#get('project_name')
    if project_name == ''
        call ex#error("No exvim project.")
        return
    endif
    exe "FTaggedFile ".a:args
endfunction
command! -nargs=* -complete=file FTaggedFileExVim call FufTaggedFile_exVim(<q-args>)
nnoremap <silent><leader>tf :FTaggedFileExVim<cr>
" ------------------------------------------------------------------
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fzf'
let g:fzf_history_dir = data_dir.'fzf-history'
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
let g:fzf_layout = { 'down': '~30%' }
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
tnoremap <c-q> <c-w><c-c>
command! -bang -nargs=* Rg 
            \call fzf#vim#grep(
            \'rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
            \.shellescape(<q-args>), 1, <bang>0)
" ------------------------------------------------------------------
Plug 'gregsexton/gitv'
" ------------------------------------------------------------------
Plug 'vim-scripts/hexHighlight.vim'
" ------------------------------------------------------------------
" ------------------------------------------------------------------
"Plug 'davidhalter/jedi-vim'
" ------------------------------------------------------------------
" Plug itchyny/lightline.vim
" ------------------------------------------------------------------
Plug 'eagletmt/neco-ghc'
" ------------------------------------------------------------------
Plug 'ujihisa/neco-look'
" ------------------------------------------------------------------
" Plug 'Shougo/neocomplete.vim'
"------------------------------------------------------------------  
" Plug 'cpiger/vgdb-vim'
Plug 'cpiger/NeoDebug'
let g:neodbg_debugger = 'gdb'
let g:neodbg_ballonshow_with_print = 0
let g:neodbg_debuginfo = 0
map <silent> <C-F5> :NeoDebug<cr>
" ca gdb VGdb
" ca Gdb VGdb
" let g:vgdb_uselibcall=1
" nmap <silent> <C-F5> :VGdb<cr>
" noremap <silent> <F5> <ESC>
"------------------------------------------------------------------  
" ------------------------------------------------------------------
Plug 'neomake/neomake'
" ------------------------------------------------------------------
Plug 'scrooloose/nerdcommenter'
" ------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCustomDelimiters = {
            \ 'vimentry': { 'left': '--' },
            \ }

let g:NERDSpaceDelims = 1
" let NERD_java_alt_style=1
let NERDCreateDefaultMappings=0
map <F4> <plug>NERDCommenterToggle
map <Leader>cC <plug>NERDCommenterComment
map <Leader>cM <plug>NERDCommenterMinimal
map <Leader>cN <plug>NERDCommenterNested
map <Leader>c$ <plug>NERDCommenterToEOL
map <Leader>cI <plug>NERDCommenterInvert
map <Leader>cS <plug>NERDCommenterSexy
map <Leader>cy <plug>NERDCommenterYank
map <Leader>cA <plug>NERDCommenterAppend
map <Leader>cL <plug>NERDCommenterAlignLeft
map <Leader>cB <plug>NERDCommenterAlignBoth
map <Leader>cU <plug>NERDCommenterUncomment
map <Leader>ca <plug>NERDCommenterAltDelims
"切换 // 与  /**/
let g:EnhCommentifyIdentString=''
let g:EnhCommentifyFirstLineMode='yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyUseBlockIndent='yes'
let g:EnhCommentifyAlignRight = 'yes'
let g:EnhCommentifyPretty = 'yes'
let g:EnhCommentifyBindInNormal = 'no'
let g:EnhCommentifyBindInVisual = 'no'
let g:EnhCommentifyBindInInsert = 'no'
" ======================================================== 
"  add new languages for comment
" ======================================================== 
function EnhCommentifyCallback(ft)
    " for hlsl, swig, c
    if a:ft =~ '^\(hlsl\|swig\|c\)$' " NOTE: we have to rewrite the c comment behavior. 
        let b:ECcommentOpen = '//'
        let b:ECcommentClose = ''
    elseif a:ft == 'snippet' " for snippet
        let b:ECcommentOpen = '#'
        let b:ECcommentClose = ''
    elseif a:ft == 'maxscript' " for maxscript
        let b:ECcommentOpen = '--'
        let b:ECcommentClose = ''
    endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'
" ------------------------------------------------------------------
Plug 'cpiger/nerdtree'
" ------------------------------------------------------------------
let g:NERDTreeMouseMode = 1
let g:NERDTreeMapToggleZoom = 'z' 
let g:NERDTreeWinSizeIncreament=30
"let NERDChristmasTree=1
let NERDTreeAutoCenter=1
" let NERDTreeBookmarksFile='~/.vim/NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
"let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=35
" let NERDTreeIgnore=['\.vim$', '\~$','\.dsp$','\.aps$','\.dsw$','\.opt$','\.ncb$']
" let NERDTreeIgnore=['\.vim$', '\~$','\.dsp$','\.aps$','\.dsw$','\.opt$','\.ncb$']

" Open and close the NERD_tree.vim separately
noremap <S-F9> :EXProjectClose<CR>:NERDTreeToggle<CR>
" ------------------------------------------------------------------
" Plug 'roxma/nvim-completion-manager'
" ------------------------------------------------------------------
Plug 'shawncplus/phpcomplete.vim'
" ------------------------------------------------------------------
Plug 'vim-scripts/Pydiction'
" ------------------------------------------------------------------
Plug 'fsouza/pythoncomplete.vim'
" ------------------------------------------------------------------
" DISABLE: au FileType python set completeopt=menuone,preview
" NOTE: the preview can show the internal document in a preview window, but I don't think it have too much help
au FileType python set completeopt=menuone
" ------------------------------------------------------------------
" Plug 'python-mode/python-mode'  "case ultisnip bug
" ------------------------------------------------------------------
Plug 'hdima/python-syntax'
" ------------------------------------------------------------------
" Plug 'artoj/qmake-syntax-vim'
" ------------------------------------------------------------------
Plug 'fedorenchik/qt-support.vim'
" ------------------------------------------------------------------
Plug 'cpiger/vim-rooter'
" ------------------------------------------------------------------
let g:rooter_manual_only = 1
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_load_gtags = 0 "cause frequently call vimrun.exe
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', '.ycm_extra_conf.py', '.qmake.stash', 'Rooter'] 
" ------------------------------------------------------------------
Plug 'vim-scripts/sketch.vim'
" ------------------------------------------------------------------
noremap <C-F7> :call ToggleSketch()<CR>
" ------------------------------------------------------------------
Plug 'vim-scripts/DrawIt'
" ------------------------------------------------------------------
" noremap <C-F7> :DIstart<CR>
" noremap <C-F7> :DIstop<CR>
" ------------------------------------------------------------------
Plug 'chrisbra/SudoEdit.vim'
" ------------------------------------------------------------------
" Plug 'vim-syntastic/syntastic'
" ------------------------------------------------------------------
" let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" let g:syntastic_c_compiler='gcc'
let g:syntastic_c_compiler='clang'
" let g:syntastic_c_compiler='arm-hisiv200-linux-gcc'
" let g:syntastic_c_compiler_options = '-Wall -Wno-unused -Wno-comment -D_GNU_SOURCE  -DHAVE_STRNCASECMP -D__KERNEL_STRICT_NAMES -D__SYS_TIME_H -DCFG_MUTECTL_SUPPORT=0x39 -ffunction-sections -fdata-sections  -fsigned-char  -DTUNER_MXL203 -DFP_TM1618A -DCFG_CMWIFI_ETH2 -DHAVE_PORTING_DEBUG -DTF_USING -DCHIP_TYPE_hi3716mv101 -DBOARD_TYPE_hi3716mdmo3bvera -DSDK_MV300A1 -I/home/yang/GCIJob/HS3716_GD_SM_SMTF/include -I/home/yang/GCIJob/HS3716_GD_SM_SMTF/include/cas -I/home/yang/GCIJob/HS3716_GD_SM_SMTF/include/gci -I/home/yang/GCIJob/HS3716_GD_SM_SMTF/SDK/MV300A1/include '
let g:syntastic_java_javac_classpath="./:/mdata/mspace/SS01E17A/bin/classes:/opt/android-sdk/platforms/android-17/*.jar"
let g:syntastic_java_javac_config_file_enabled=1 
" this will make html file by Angular.js ignore errors
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ------------------------------------------------------------------
"let g:syntastic_check_on_open = 1
"" let g:syntastic_cpp_include_dirs = ['/usr/include/']
"let g:syntastic_cpp_include_dirs = ['E:/mspace/fltkinstall/include/']
"let g:syntastic_cpp_remove_include_errors = 1
"let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
""set error or warning signs
"let g:syntastic_error_symbol = ''
"let g:syntastic_warning_symbol = ''
""whether to show balloons
"let g:syntastic_enable_balloons = 1
" ------------------------------------------------------------------
" Plug 'godlygeek/tabular'
" ------------------------------------------------------------------
" let g:tabular_loaded = 1
nnoremap <silent> <leader>= :call g:Tabular(1)<CR>
xnoremap <silent> <leader>= :call g:Tabular(0)<CR>
function! g:Tabular(ignore_range) range
    let c = getchar()
    let c = nr2char(c)
    if a:ignore_range == 0
        exec printf('%d,%dTabularize /%s', a:firstline, a:lastline, c)
    else
        exec printf('Tabularize /%s', c)
    endif
endfunction
" ------------------------------------------------------------------
Plug 'ternjs/tern_for_vim', { 'on': 'TernType' }
" ------------------------------------------------------------------
Plug 'vim-scripts/TeTrIs.vim'
" ------------------------------------------------------------------
Plug 'tomtom/tlib_vim'
" ------------------------------------------------------------------
" Plug 'jiazhoulvke/ultilocate'
" let g:ultilocate_has_fuzzyfinder=1
" ------------------------------------------------------------------
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'}
" ------------------------------------------------------------------
noremap <leader>ut :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1
let g:undotree_WindowLayout = 4
" ------------------------------------------------------------------
" Plug 'Shougo/unite.vim'
" ------------------------------------------------------------------
let g:unite_split_rule='bel'
let g:unite_winheight=15
" ------------------------------------------------------------------
" Plug 'osyo-manga/unite-quickrun_config'
" ------------------------------------------------------------------
" Plug 'joonty/vdebug'
" ------------------------------------------------------------------
Plug 'MarcWeber/vim-addon-mw-utils'
" ------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ------------------------------------------------------------------
" let g:airline_exclude_filenames = ['','11','12','13','14','15'] " see source for current list
" let g:airline#extensions#tabline#excludes = ['/tmp/']
" let g:airline_exclude_filetypes = [c] " see source for current list
let g:airline#extensions#tabline#enabled = 0
if has('gui_running')
    let g:airline_powerline_fonts = 1
    let g:Powerline_cache_enabled = 1
    let g:Powerline_symbols = 'fancy'
    " let Powerline_symbols = 'compatible' 
    " let g:Powerline_theme = 'skwp'
    " let g:Powerline_colorscheme = 'default'
else
    let g:airline_powerline_fonts = 0
endif

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" let g:airline#extensions#tabline#show_splits = 0
" let airline#extensions#tabline#middle_click_preserves_windows = 1

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#excludes = ["[fuf]","[fuf]", "__FUF__","__FUF__"]

" let g:airline_section_b = "%{fnamemodify(bufname('%'),':p:.:h').'/'}"
" let g:airline_section_c = '%t'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
if WINDOWS()
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif
if has('unix')
    let g:airline_left_sep = '⮀'
    let g:airline_left_alt_sep = '⮁'
    let g:airline_right_sep = '⮂'
    let g:airline_right_alt_sep = '⮃'
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif

" let g:airline_theme="wombat"
" let g:airline_theme="solarized"
" let g:airline_theme="molokai"
let g:airline_theme="powerlineish"
" let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#checks = []
let g:airline#extensions#syntastic#enabled = 0

" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

"let g:airline_section_warning = airline#section#create(['syntastic'])
" ------------------------------------------------------------------
Plug 'Chiel92/vim-autoformat'
noremap <A-F10> :Autoformat<CR>
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'
let g:formatters_cpp = ['allman']
let g:formatters_c = ['allman']
" autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=\"{BasedOnStyle:\ WebKit,\ BraceWrapping:\ {AfterNamespace:\ true}}\"
" LLVM, Google, Chromium, Mozilla, WebKit
" setlocal equalprg=clang-format\ -style=\"\{BasedOnStyle:\ llvm,\ IndentWidth:\ 4\}\" 
" ------------------------------------------------------------------
Plug 'MattesGroeger/vim-bookmarks'
" ------------------------------------------------------------------
let g:bookmark_no_default_key_mappings=1
" call unite#custom#profile('source/vim_bookmarks', 'context', {
" \   'winheight': 13,
" \   'direction': 'botright',
" \   'start_insert': 0,
" \   'keep_focus': 1,
" \   'no_quit': 1,
" \ })
" ------------------------------------------------------------------
Plug 'cpiger/vim-buftabline'
"------------------------------------------------------------------  
let g:buftabline_numbers = 1
let g:buftabline_indicators=1
let g:buftabline_separators=0
let g:buftabline_plug_max=20
hi BufTabLineCurrent ctermfg=22 ctermbg=148 guifg=#005f00 guibg=#afd700
hi BufTabLineActive  ctermfg=232 ctermbg=8 guifg=#080808 guibg=Grey50
hi BufTabLineHidden  ctermfg=247 ctermbg=233 guifg=#9e9e9e guibg=#121212
hi BufTabLineFill    ctermfg=247 ctermbg=233 guifg=#9e9e9e guibg=#121212

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" nnoremap <tab> <c-^>
nnoremap <silent> <tab> :<C-U>call QuickBufferSwitch(v:count)<CR>
let g:buftabline_excludes = ["[fuf]","[fuf]", "__FUF__","__FUF__"]
function! QuickBufferSwitch(num)
    let l:origBuf  = bufnr('%')

    if g:buftabline_numbers == 2
        let s:bufnr = get(buftabline#user_buffers(), a:num-1)
        if 0 != s:bufnr
            exec "normal " . s:bufnr . "\<C-^>"
        endif
    endif

    if g:buftabline_numbers == 1
        if a:num == 0
            try
                exec "normal " .a:num. "\<C-^>"
            catch /^Vim\%((\a\+)\)\=:E23/
                silent echohl ModeMsg
                echomsg "No alternate file."
                silent echohl None
            endtry
        else
            if -1 != index(g:BufTablineList, a:num) 
                exec "normal " .a:num. "\<C-^>"
            else
                silent echohl ModeMsg
                echomsg 'Do not switch to buffer ' . (bufname(a:num) == '' ? 'number: '.a:num : 'name:'.fnamemodify(bufname(a:num), ":t")) .' .'
                silent echohl None
            endif
        endif
    endif
endfunction  
" ------------------------------------------------------------------
Plug 'asins/vimcdoc'
" ------------------------------------------------------------------
Plug 'taku-o/vim-chardet'
" ------------------------------------------------------------------
Plug 'kchmck/vim-coffee-script'
" ------------------------------------------------------------------
Plug 'altercation/vim-colors-solarized'
" ------------------------------------------------------------------
Plug 'vim-jp/vim-cpp'
Plug 'octol/vim-cpp-enhanced-highlight'
" ------------------------------------------------------------------
" Plug 'skammer/vim-css-color'
" ------------------------------------------------------------------
" Plug 'chrisbra/vim-diff-enhanced'
" ------------------------------------------------------------------
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ea <Plug>(EasyAlign)
xmap <c-e> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ea <Plug>(EasyAlign)
nmap <c-e> <Plug>(EasyAlign)
" ------------------------------------------------------------------
Plug 'duggiefresh/vim-easydir'
" ------------------------------------------------------------------
Plug 'cpiger/vim-easygrep'      
" ------------------------------------------------------------------
Plug 'Lokaltog/vim-easymotion'
" ------------------------------------------------------------------
map <leader><leader>/ <Plug>(easymotion-sn)
omap <leader><leader>/ <Plug>(easymotion-tn)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" ------------------------------------------------------------------
Plug 'eagle0701/vim-escalt'
" ------------------------------------------------------------------
Plug 'terryma/vim-expand-region'
" ------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
" ------------------------------------------------------------------
Plug 'clones/vim-genutils'
" ------------------------------------------------------------------
if has ("unix")
    Plug 'airblade/vim-gitgutter' "win下慢
endif
" ------------------------------------------------------------------
let g:gitgutter_max_signs=50000
" ------------------------------------------------------------------
" Plug 'fatih/vim-go'
let g:go_bin_path = $GOPATH.'/bin'
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" let g:go_list_type = "quickfix"

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
" Call YCM GoTo or vim-go GoTo depending on file type. 
function! GoToDef()
    if &ft == 'go'
        call go#def#Jump()
    else
        execute 'YcmCompleter GoTo'
    endif
endfunction
" nnoremap <leader>] :call GoToDef()<CR>

" Plug 'fatih/vim-go-tutorial'
" ------------------------------------------------------------------
" Plug 'roxma/vim-hug-neovim-rpc'
" ------------------------------------------------------------------
Plug 'rust-lang/rust.vim'
" ------------------------------------------------------------------
Plug 'nathanaelkane/vim-indent-guides'
" ------------------------------------------------------------------
let g:indent_guides_guide_size = 1
" ------------------------------------------------------------------
Plug 'suan/vim-instant-markdown'
" ------------------------------------------------------------------
" Plug 'artur-shaik/vim-javacomplete2'
" ------------------------------------------------------------------
Plug 'pangloss/vim-javascript'
" ------------------------------------------------------------------
Plug 'maksimr/vim-jsbeautify'
" ------------------------------------------------------------------
let g:html_indent_inctags = "html,body,head,tbody" 
command JSBT :call JsBeautify()
" ------------------------------------------------------------------
Plug 'groenewege/vim-less'
" ------------------------------------------------------------------
Plug 'thinca/vim-logcat'
" ------------------------------------------------------------------
" Plug 'vim-utils/vim-man'
" ------------------------------------------------------------------
map K <Nop>
map <leader>k <Plug>(Man)
" man.vim: invoked by :Man {name}
" source $VIMRUNTIME/ftplugin/man.vim
" noremap <leader>k :Man  3 <C-r>=expand('<cword>')<CR><CR>
" noremap <s-f11> :Man  3 <C-r>=expand('<cword>')<CR><CR>
" ------------------------------------------------------------------
Plug 'plasticboy/vim-markdown'
" ------------------------------------------------------------------
let g:vim_markdown_initial_foldlevel=9999
" ------------------------------------------------------------------
Plug 'terryma/vim-multiple-cursors'
" ------------------------------------------------------------------
Plug 'sheerun/vim-polyglot'
" ------------------------------------------------------------------
" Plug 'peterhoeg/vim-qml'
" ------------------------------------------------------------------
Plug 'tpope/vim-rails'
" ------------------------------------------------------------------
Plug 'tpope/vim-repeat'
" ------------------------------------------------------------------
Plug 'vim-ruby/vim-ruby'
" ------------------------------------------------------------------
Plug 'wavded/vim-stylus'
" ------------------------------------------------------------------
Plug 'tpope/vim-surround'
" ------------------------------------------------------------------
" 'sb' for block
" 'si' for an if statement
" 'sw' for a with statement
" 'sc' for a comment
" 'sf' for a for statement
" ------------------------------------------------------------------
xmap s   <Plug>VSurround

" DISABLE { 
" let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
" let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
" let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
" let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
" let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
" } DISABLE end 
" ------------------------------------------------------------------
Plug 'blockloop/vim-swigjs'
" ------------------------------------------------------------------
Plug 'triglav/vim-visual-increment'
" ------------------------------------------------------------------
Plug 'vimwiki/vimwiki'
" ------------------------------------------------------------------
" noremap <silent><unique> <Leader>wt <Plug>VimwikiTabGoHome
" noremap <silent><unique> <Leader>wq <Plug>VimwikiUISelect
" noremap <silent><unique> <Leader>ww <Plug>VimwikiGoHome
let g:vimwiki_list = [ 
            \ {'path': 'D:/exVim/vimwiki'},
            \ {"path": "D:/exVim/vimwikimd/", 
            \ "syntax": "markdown",
            \ "ext": ".md"} 
            \ ]

let tlist_vimwiki_settings = 'wiki;h:Headers'
" vimwiki file process
au FileType vimwiki command! W call exUtility#SaveAndConvertVimwiki(0)
au FileType vimwiki command! WA call exUtility#SaveAndConvertVimwiki(1)
au FileType rst command! W call exUtility#SphinxMake('html')

let g:vimwiki_camel_case = 0
let g:vimwiki_hl_headers = 1
" ------------------------------------------------------------------
" call python2, will block python3 for ultisnip
" Plug 'cpiger/visual_studio.vim' 
" ------------------------------------------------------------------
Plug 'othree/xml.vim'
" ------------------------------------------------------------------
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" ------------------------------------------------------------------
Plug 'sukima/xmledit'
" ------------------------------------------------------------------
"  Desc: YouCompleteMe : invoke by 
"  Desc: YCM-Generator: invoke by 
"  Desc: ultisnips: invoke by 
"  Desc: vim-snippets: invoke by 
" ------------------------------------------------------------------
Plug 'cpiger/ultisnips', { 'on': [] }
" ------------------------------------------------------------------
Plug 'rdnetto/YCM-Generator', {'on': 'YcmGenerateConfig'}
" ------------------------------------------------------------------
Plug 'honza/vim-snippets'
" ------------------------------------------------------------------
Plug 'Valloric/YouCompleteMe', { 'on': [] }
" ------------------------------------------------------------------
augroup load_us_ycm
    autocmd!
    autocmd InsertEnter *\(__FUF__\)\@<! call plug#load('ultisnips', 'YouCompleteMe')
                \| autocmd! load_us_ycm
augroup END
let g:EclimCompletionMethod = 'omnifunc'  "for java
" 允许 vim 加载 .ycm_extra_conf.py 文件,不再提示
let g:ycm_confirm_extra_conf=0
" Note that YCM's diagnostics UI is only supported for C-family languages.
let g:ycm_show_diagnostics_ui = 1
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_disable_for_files_larger_than_kb = 5000
" 补全内容不以分割子窗口形式出现,只显示补全列表
set completeopt-=preview
let g:ycm_auto_trigger = 1
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=1
let g:ycm_use_ultisnips_completer = 1
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" let g:ycm_key_invoke_completion = '<M-;>'  
let g:ycm_key_invoke_completion = '<M-.>'  
let g:ycm_filetype_whitelist = { '*': 1 }
" \ 'java' : 1,
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1
            \ }
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1,
      \}
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_semantic_triggers =  {
            \   'c': ['->', '.'],
            \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
            \            're!\[.*\]\s'],
            \   'ocaml': ['.', '#'],
            \   'cpp,cuda,objcpp': ['->', '.', '::'],
            \   'perl': ['->'],
            \   'php': ['->', '::'],
            \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
            \   'ruby,rust': ['.', '::'],
            \   'lua': ['.', ':'],
            \   'erlang': [':'],
            \ }
" let g:ycm_semantic_triggers =  {
            " \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            " \ 'cs,lua,javascript': ['re!\w{2}'],
            " \ }
" ------------------------------------------------------------------
" ji jc jd
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>

" nnoremap <BS> <c-o>
nnoremap <F10> :YcmCompleter GoTo<CR>

" let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']
" let g:ycm_global_ycm_extra_conf =$VIM.'/tools/ycmconf/tdmgcc_ycm_extra_conf.py'
fun SetYCMParas(A,L,P)
    let paralist = ["tdmgcc", "msys", "msvc", "qtmsvc", "qtmingw"]
    let completelist = []

    if !len(a:A)
        return paralist
    endif

    let pat = a:A
    for pa in paralist
        if pa =~ pat
            call add(completelist, pa)
        endif
    endfor
    return completelist
endfun

function! SetYCM(args)
    if a:args == ""
        let g:ycm_global_ycm_extra_conf
        return
    else
        let g:ycm_global_ycm_extra_conf =$VIM.'/tools/ycmconf/'. a:args . '_ycm_extra_conf.py'
        YcmRestartServer
        let g:ycm_global_ycm_extra_conf
        return
    endif
endfunction
command! -complete=customlist,SetYCMParas -nargs=?  SetYCM call SetYCM(<q-args>)

func ToggleYCM()
    let g:ycm_auto_trigger = !g:ycm_auto_trigger
    if 1 == g:ycm_auto_trigger
        call ex#hint("Turn on YCM.")
    else
        call ex#hint("Turn off YCM.")
    endif
endf
command YcmAutoTrigger call ToggleYCM()
" ------------------------------------------------------------------
"  ultisnips
" ------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsExpandTrigger="<a-k>"
let g:UltiSnipsJumpForwardTrigger="<a-d>"
let g:UltiSnipsJumpBackwardTrigger="<a-s>"
let g:UltiSnipsListSnippets="<a-e> "
let g:UltiSnipsUsePythonVersion = 3

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
if WINDOWS()
let g:UltiSnipsSnippetsDir= $VIM . "/tools/UltiSnips"
else
    let g:UltiSnipsSnippetsDir= $HOME . "/.vim/tools/UltiSnips"
endif
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" ------------------------------------------------------------------
let g:snips_author = g:ex_usr_name
fun! GetSnipsInCurrentScope()
    let snips = {}
    for scope in [bufnr('%')] + split(&ft, '\.') + ['_']
        call extend(snips, get(s:snippets, scope, {}), 'keep')
        call extend(snips, get(s:multi_snips, scope, {}), 'keep')
    endfor
    return snips
endf 

" DISABLE: Slow to open big css file
" ------------------------------------------------------------------
" ex-cref: invoke by <leader>cr
" ------------------------------------------------------------------
" this is modified for default c syntax highlight settings 
" make it don't highlight error pattern
let c_gnu = 1
let c_no_curly_error = 1
let c_no_bracket_error = 1
" ------------------------------------------------------------------
Plug 'leafgarland/typescript-vim'
" ------------------------------------------------------------------
" ------------------------------------------------------------------
call plug#end()

" When writing a buffer (no delay).
" call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
" call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)
" ------------------------------------------------------------------
" exEnvironmentSetting post update
" NOTE: this is a post update environment function used for any custom environment update 
" function g:exES_PostUpdate()
function g:Exvim_post_init()

    let g:ex_gsearch_engine = vimentry#get('gsearch_engine')
    let g:ex_project_cwd  = vimentry#get('project_cwd')
    let g:ex_project_name = vimentry#get('project_name')
    if g:ex_project_name == ''
        let g:ex_project_exdir = './'
        let g:ex_qfix_file = './error.qfix'
        let g:ex_filenametags= &tags
        " let g:ex_error_file = './error.err'
        call ex#hint("No project name, Use ./ .")
    else
        let g:ex_project_exdir = './'.g:ex_dir_prefix.'.'.g:ex_project_name
        let g:ex_qfix_file = g:ex_project_exdir.'/error.qfix'
        let g:ex_filenametags =fnameescape(g:ex_project_cwd.'/'.g:ex_dir_prefix.'.'.g:ex_project_name.'/filenametags')
        " let g:ex_error_file = g:ex_project_exdir.'/error.err'
    endif

    call exqfix#set_qfix_file(g:ex_qfix_file)

    let sub_project_refs = vimentry#get('sub_project_refs')
    if empty(sub_project_refs)
    else
        for sub_project in sub_project_refs
            let sub_cwd = fnamemodify(sub_project, ":p:h")
            let sub_name= fnamemodify(sub_project, ":t:r")
            let sub_folder = fnameescape(sub_cwd.'/'.g:ex_dir_prefix.'.'.sub_name)
            let g:ex_filenametags .= ','.fnameescape(sub_folder.'/filenametags')
            let &tags .= ','.fnameescape(sub_folder.'/tags')
        endfor
    endif

    let project_maker = vimentry#get('project_maker')
    let g:ex_project_maker = vimentry#get('project_maker')
    if project_maker == ''
        " call ex#hint("Use default makeprg.")
    else
        let &makeprg = project_maker
    endif

    let project_cflags = vimentry#get('project_cflags')
    if project_cflags != ''
        let g:c_cflags = project_cflags
    endif

    let project_syntastic_cpp_flags = vimentry#get('project_syntastic_cpp_flags')
    if project_syntastic_cpp_flags != ''
        let g:syntastic_c_compiler_options = project_syntastic_cpp_flags
        let g:syntastic_cpp_compiler_options = project_syntastic_cpp_flags
        " let g:clang_user_options = g:clang_user_options . g:syntastic_c_compiler_options
        " let g:clang_user_options = g:clang_user_options . g:syntastic_c_compiler_options
    endif

    let project_syntastic_java_javac_classpath = vimentry#get('project_syntastic_java_javac_classpath')
    if project_syntastic_java_javac_classpath!= ''
        let g:syntastic_java_javac_classpath = project_syntastic_java_javac_classpath 
        " let g:JavaComplete_LibsPath = project_syntastic_java_javac_classpath
        let g:java_classpath = project_syntastic_java_javac_classpath
        " let $CLASSPATH=project_syntastic_java_javac_classpath
    endif

    " let project_debuger = vimentry#get('project_debuger')
    " if project_debuger != ''
    " let &gdbprg = project_debuger
    " else
    " let &gdbprg = gdb
    " endif

    " set tag file path
    if exists( 'g:exES_Tag' )
        "let &tags = &tags . ',' . g:exES_Tag
        let &tags = escape(g:exES_Tag, " ")
    endif

    " set vimwiki
    if exists( 'g:exES_wikiHome' )
        " clear the list first
        if exists( 'g:vimwiki_list' ) && !empty(g:vimwiki_list)
            silent call remove( g:vimwiki_list, 0, len(g:vimwiki_list)-1 )
        endif

        " assign vimwiki pathes, 
        " NOTE: vimwiki need full path.
        let g:vimwiki_list = [ { 'path': fnamemodify(g:exES_wikiHome,":p"), 
                    \ 'path_html': fnamemodify(g:exES_wikiHomeHtml,":p"),
                    \ 'html_header': fnamemodify(g:exES_wikiHtmlHeader,":p") } ]

        " create vimwiki files
        " call exUtility#CreateVimwikiFiles ()
    endif

    let &dict = &dict . ',' . g:ex_project_exdir . '/symbols'
endfunction
" noremap <a-r>  :call g:exES_PostUpdate()<cr>
noremap <leader>rs :call g:Exvim_post_init()<cr>
"/////////////////////////////////////////////////////////////////////////////
" General setup
"/////////////////////////////////////////////////////////////////////////////
" set guiheadroom=-20
set ambiwidth=double
set path=.
" set path=.,/usr/include/*,, " where gf, ^Wf, :find will search 
" set path=.,/usr/include/*,, " where gf, ^Wf, :find will search   default on Unix: ".,/usr/include,," 

" set tags+=./tags,./../tags,./**/tags,tags " which tags files CTRL-] will find 

function SetENV_C()
    set dictionary=$VIM/tools/dicts/cpp.dict
    set dictionary+=$VIM/tools/dicts/dict.dict
    set dictionary+=$VIM/tools/dicts/mfc.dict
endfunction
function SetENV_JAVA()
    set dictionary=$HOME/.vim/tools/dicts/java.dict
    set dictionary+=$HOME/.vim/tools/dicts/dict.dict
endfunction
function SetENV_PYTHON()
    set dictionary=$VIM/tools/dicts/python.dict
    set dictionary+=$VIM/tools/dicts/dict.dict
    set dictionary+=$VIM/vimfiles/plugged/pydiction/complete-dict
endfunction
autocmd FileType c,cpp silent call SetENV_C()
autocmd FileType java silent call SetENV_JAVA()
autocmd FileType python silent call SetENV_PYTHON()
let g:pydiction_location=$VIM.'\vimfiles/plugged/pydiction/complete-dict'

" Redefine the shell redirection operator to receive both the stderr messages and stdout messages
set shellredir=>%s\ 2>&1
set maxmempattern=1000 " enlarge maxmempattern from 1000 to ... (2000000 will give it without limit)
set nomore
" set more
set nrformats=alpha,octal,hex

" 防止退出时终端乱码
" 这里两者都需要。只前者标题会重复，只后者会乱码
set t_fs=(B
set t_IE=(B
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
" set t_k1=O*P
" set t_k2=O*Q
" set t_k3=O*R
" set t_k4=O*S
" set t_k5=O*S [15~

set selection=old

behave xterm  " set mouse behavior as xterm
if &term =~ 'xterm'
    set mouse=a
endif

"/////////////////////////////////////////////////////////////////////////////
" Variable settings ( set all )
"/////////////////////////////////////////////////////////////////////////////
set completeopt=menu,longest
" set complete-=i  " Don't scan include files
" set complete=.,w,b,u,U,k,s,i,d,t
set complete=.,w,b,u,k,s,i,t
set magic
set noerrorbells
set novisualbell
set t_vb=
set mat=2    "How many tenths of a second to blink
set winaltkeys=no
set smarttab
set cursorline
set history=5000     "Sets how many lines of history VIM har to remember
filetype on " enable file type detection 
filetype plugin on  "Enable filetype plugin
filetype indent on
set updatetime=1000 " default = 4000
set autoread        " auto read same-file change ( better for vc/vim change )
set textwidth=120   "设置最大列数，超出后自动换行
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci-c:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175  
"Have the mouse enabled all the time:
set mouse=a
" set autochdir
" set guitablabel=%N/\ %t\ %M
" set bg=dark
syntax enable  "Enable syntax hl
autocmd FileType python setlocal et sta sw=4 sts=4
set tabstop=4            " Set tabstop to 4 characters
set expandtab            " Set expandtab on, the tab will be change to space automaticaly
set softtabstop=4    
set ve=block             " In Visual Block Mode, cursor can be positioned where there is no actual character
set diffopt=filler,context:9999
set hid                  " allow to change buffer without saving 
set showfulltag          " show tag with function protype.
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions+=acit    "不用弹出对话框窗口的交互模式，只在命令行交互，3x 百合仙子
"set noic               "Ignore case in search patterns.  Also used when searching in the tags file.  Also see 'smartcase'.
set clipboard=unnamed
set fo=croqn2mM1 " set formatoptions+=rmM
" set statusline+=%F%m%r%h%w\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]
" set statusline=%n\ %<%f\ %L行\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%=\ 0x%-4.4B\ \ \ \ %-14.(%l,%c%V%)\ %P  “仙子的
"Tab complete now ignores these file types

" set sb
set wildignore=*.o,*.obj,*.bak,*.exe,*~
set so=7                "Set 7 lines to the curors - when moving vertical..  minimal number of screen lines to keep above and below the cursor 
"set whichwrap+=<,>,h,l     "Bbackspace and cursor keys wrap to
set modeline        " au FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.
set showmode
set imcmdline
"set ghr=400
set ghr=0 " nvim hung
" NOTE: viminfo
" for MS-DOS, Windows and OS/2: '20,<50,s10,h,rA:,rB:,
" for Amiga: '20,<50,s10,h,rdf0:,rdf1:,rdf2:
" for others: '20,<50,s10,h
set viminfo+=! " make sure it can save viminfo 
"set isk+=$,%,#,- " none of these should be word dividers 
" --------------------------------------------------------------------------------- 
" Desc: Visual
" --------------------------------------------------------------------------------- 
let g:molokai_original = 1
if has('gui_running')
    set background=dark
    colorscheme solarized
    colorscheme molokai
else
    colorscheme default
    hi CursorLine  ctermbg=5   cterm=none
endif
" hi Identifier term=underline cterm=bold ctermfg=11 guifg=#FD971F
" hi vimVar     term=underline cterm=bold ctermfg=11 guifg=#FD971F

set matchtime=0 " 0 second to show the matching paren ( much faster )
set nu " show line number
set scrolloff=0 " minimal number of screen lines to keep above and below the cursor 
set nowrap " do not wrap text
" only supoort in 7.3 or higher
if v:version >= 703
    set noacd " no autochchdir
endif
" set default guifont
if has('gui_running')
    augroup ex_gui_font
        " check and determine the gui font after GUIEnter. 
        " NOTE: getfontname function only works after GUIEnter.  
        au!
        au GUIEnter * call s:set_gui_font()
    augroup END

    " set guifont
    function! s:set_gui_font()
        if has('gui_gtk2')
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ 12
            else
                set guifont=Luxi\ Mono\ 12
            endif
        elseif has('x11')
            " Also for GTK 1
            set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
        elseif OSX()
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h15
            endif
        elseif WINDOWS()
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT  
                " set guifont=AAA_Yahei_Mono_Monaco_Powerline:h11:cANSI:qDRAFT 
                " set rop=type:directx,gamma:1.0,contrast:0.0,geom:1,renmode:5,taamode:1,level:0.5
                set guifontwide=AAA_Yahei_Mono_Monaco_Powerline:h11:cANSI:qDRAFT 
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h11:cANSI
            elseif getfontname( 'Consolas' ) != ''
                set guifont=Consolas:h11:cANSI " this is the default visual studio font
            else
                set guifont=DejaVu Sans Mono for Powerline 10  
            endif
        endif
    endfunction
endif
" --------------------------------------------------------------------------------- 
" Desc: Vim UI
" --------------------------------------------------------------------------------- 
set wildmenu          " turn on wild menu, try typing :h and press <Tab>
set showcmd           " display incomplete commands
set cmdheight=1       " 1 screen lines to use for the command-line
set ruler             " show the cursor position all the time
set hidden            " allow to change buffer without saving
set shortmess=aoOtTI  " shortens messages to avoid 'press a key' prompt
set lazyredraw        " do not redraw while executing macros (much faster)
set display+=lastline " for easy browse last line with wrap text
set laststatus=2      " always have status-line
if version >= 700
    au InsertEnter * hi StatusLine guibg=#818D29 guifg=#FCFCFC gui=none
    au InsertLeave * hi StatusLine guibg=#EEEEEE guifg=#363636 gui=none
endif
set titlestring=%t\ (%{expand(\"%:p:.:h\")}/)

" set window size (if it's GUI)
if has('gui_running')
    " set window's width to 130 columns and height to 40 rows
    if exists('+lines')
        set lines=40
    endif
    if exists('+columns')
        set columns=130
    endif

    " DISABLE
    " if WINDOWS()
    "     au GUIEnter * simalt ~x " Maximize window when enter vim
    " else
    "     " TODO: no way right now
    " endif
endif
" --------------------------------------------------------------------------------- 
" Desc: Text edit
" --------------------------------------------------------------------------------- 
" set ai " autoindent 
" set si " smartindent 
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" indent options
" see help cinoptions-values for more details
" set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30,N-s
set	cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b1,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30,N-s
" default '0{,0},0),:,0#,!^F,o,O,e' disable 0# for not ident preprocess
" set cinkeys=0{,0},0),:,!^F,o,O,e
set cindent shiftwidth=4 " set cindent on to autoinent when editing c/c++ file, with 4 shift width

" set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
" --------------------------------------------------------------------------------- 
" Desc: Fold text
" --------------------------------------------------------------------------------- 
set nofen                "Enable folding, I find it very useful
" set foldcolumn=2          "导致vim左边多一个白色的边
" set foldmethod=syntax  fdn=6
set foldmethod=manual
set foldmethod=marker foldmarker={,} foldlevel=9999
" --------------------------------------------------------------------------------- 
" Desc: Search
" --------------------------------------------------------------------------------- 
set showmatch " show matching paren 
set incsearch " do incremental searching
set hlsearch " highlight search terms
set ignorecase " set search/replace pattern to ignore case 
set smartcase " set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.
" set this to use id-utils for global search
set grepprg=lid\ -Rgrep\ -s
set grepformat=%f:%l:%m

" official diff settings
set diffexpr=g:MyDiff()
function! g:MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

"/////////////////////////////////////////////////////////////////////////////
" Auto Command
"/////////////////////////////////////////////////////////////////////////////
" --------------------------------------------------------------------------------- 
" Desc: Only do this part when compiled with support for autocommands.
" --------------------------------------------------------------------------------- 
if has('autocmd')

    augroup ex
        au!
        " --------------------------------------------------------------------------------- 
        " Desc: Buffer
        " --------------------------------------------------------------------------------- 
        " when editing a file, always jump to the last known cursor position.
        " don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
        au BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
        au BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full) 
        au BufNewFile,BufRead *.avs set syntax=avs " for avs syntax file.

        " DISABLE { 
        " NOTE: will have problem with exvim, because exvim use exES_CWD as working directory for tag and other thing
        " Change current directory to the file of the buffer ( from Script#65"CD.vim"
        " au   BufEnter *   execute ":lcd " . expand("%:p:h") 
        " } DISABLE end 

        " --------------------------------------------------------------------------------- 
        " Desc: file types 
        " --------------------------------------------------------------------------------- 
        au FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters.
        au FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.

        " disable auto-comment for c/cpp, lua, javascript, c# and vim-script
        au FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:// 
        au FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f:// 
        au FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
        au FileType lua set comments=f:--

        " if edit python scripts, check if have \t. ( python said: the programme can only use \t or not, but can't use them together )
        au FileType python,coffee call s:check_if_expand_tab()
    augroup END

    function! s:check_if_expand_tab()
        let has_noexpandtab = search('^\t','wn')
        let has_expandtab = search('^    ','wn')

        "
        if has_noexpandtab && has_expandtab
            let idx = inputlist ( ['ERROR: current file exists both expand and noexpand TAB, python can only use one of these two mode in one file.\nSelect Tab Expand Type:',
                        \ '1. expand (tab=space, recommended)', 
                        \ '2. noexpand (tab=\t, currently have risk)',
                        \ '3. do nothing (I will handle it by myself)'])
            let tab_space = printf('%*s',&tabstop,'')
            if idx == 1
                let has_noexpandtab = 0
                let has_expandtab = 1
                silent exec '%s/\t/' . tab_space . '/g'
            elseif idx == 2
                let has_noexpandtab = 1
                let has_expandtab = 0
                silent exec '%s/' . tab_space . '/\t/g'
            else
                return
            endif
        endif
        if has_noexpandtab == 1 && has_expandtab == 0  
            echomsg 'substitute space to TAB...'
            set noexpandtab
            echomsg 'done!'
        elseif has_noexpandtab == 0 && has_expandtab == 1
            echomsg 'substitute TAB to space...'
            set expandtab
            echomsg 'done!'
        else
            " it may be a new file
            " we use original vim setting
        endif
    endfunction
endif

"/////////////////////////////////////////////////////////////////////////////
" Key Mappings
"/////////////////////////////////////////////////////////////////////////////
" NOTE: F10 looks like have some feature, when map with F10, the map will take no effects

" Don't use Ex mode, use Q for formatting
map Q gq  

" define the copy/paste judged by clipboard
if &clipboard ==# 'unnamed'
    " fix the visual paste bug in vim
    " vnoremap <silent>p :call g:()<CR>
else
    " general copy/paste.
    " NOTE: y,p,P could be mapped by other key-mapping
    map <leader>y "*y
    map <leader>p "*p
    map <leader>P "*P
endif

" copy folder path to clipboard, foo/bar/foobar.c => foo/bar/
nnoremap <silent> <leader>y1 :let @*=fnamemodify(bufname('%'),":p:h")<CR>

" copy file name to clipboard, foo/bar/foobar.c => foobar.c
nnoremap <silent> <leader>y2 :let @*=fnamemodify(bufname('%'),":p:t")<CR>

" copy full path to clipboard, foo/bar/foobar.c => foo/bar/foobar.c 
nnoremap <silent> <leader>y3 :let @*=fnamemodify(bufname('%'),":p")<CR>

" DISABLE: though nohlsearch is standard way in Vim, but it will not erase the 
"          search pattern, which is not so good when use it with exVim's <leader>r 
"          filter method
" nnoremap <F8> :nohlsearch<CR>
" nnoremap <leader>/ :nohlsearch<CR>
nnoremap <silent> <leader>/ :let @/=""<CR>
nnoremap <F8> :let @/=""<CR>

" map Ctrl-Tab to switch window
nnoremap <S-Up> <C-W><Up>
nnoremap <S-Down> <C-W><Down>
nnoremap <S-Left> <C-W><Left>
nnoremap <S-Right> <C-W><Right>
nnoremap <A-k> <C-W><Up>
nnoremap <A-j> <C-W><Down>
nnoremap <A-h> <C-W><Left>
nnoremap <A-l> <C-W><Right>
nnoremap <leader>gk <C-W><Up>
nnoremap <leader>gj <C-W><Down>
nnoremap <leader>gh <C-W><Left>
nnoremap <leader>gl <C-W><Right>

" easy buffer navigation
" NOTE: if we already map to EXbn,EXbp. skip setting this
if !hasmapto(':EXbn<CR>') && mapcheck('<C-l>','n') == ''
    nnoremap <C-l> :bn<CR>
endif
if !hasmapto(':EXbp<CR>') && mapcheck('<C-h>','n') == ''
    noremap <C-h> :bp<CR>
endif

" easy diff goto
noremap <C-k> [c
noremap <C-j> ]c

" enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap < <gv
vnoremap > >gv

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <Up> gk
noremap <Down> gj

" TODO: I should write a better one, make it as plugin exvim/swapword
" VimTip 329: A map for swapping words
" http://vim.sourceforge.net/tip_view.php?tip_id=
" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <silent> <leader>sw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>
" noremap <silent><leader>rs :source ~/.vimrc<cr>   
if has ("unix")
    noremap <leader>ee :e! ~/.vimrc<cr>
else
    noremap <leader>ee :e! $VIM\_vimrc<cr>
endif
" autocmd! bufwritepost .vimrc silent source ~/.vimrc "When .vimrc is edited, reload it

" source $VIMRUNTIME/vimrc_example.vim
behave xterm  " set mouse behavior as xterm
"/////////////////////////////////////////////////////////////////////////////
" Functions
"/////////////////////////////////////////////////////////////////////////////
let g:ex_project_maker = 'make'
let g:ex_qfix_file = './error.qfix'
function IMake()
    if WINDOWS()
        exec "!".g:ex_project_maker. " > ".g:ex_qfix_file. " 2>&1 "
    elseif has ("unix")
        exec "!".g:ex_project_maker. " 2>&1 |tee ".g:ex_qfix_file
        " exec "!".g:ex_project_maker. " 2>&1 |tee ".g:ex_error_file
    endif

    exec "cgetfile ".g:ex_qfix_file
    exec "copen" 
    let qfixlist = getbufline(bufnr('%'), 1, "$")
    call writefile(qfixlist, g:ex_qfix_file)
    exec "close"
    silent exec 'QFix '. g:ex_qfix_file
endfunction
function IMakeClean()
    exec "!start ".g:ex_project_maker." clean "
endfunction
noremap <unique> <silent> <leader><F1>  :call IMake()<cr>
noremap <unique> <silent> <S-F1>  :call IMakeClean()<cr>

function! LMGrep(args)
    execute "silent! lgrep " . a:args
    botright lopen
    exec "redraw!"
endfunction

function! LMGrepAdd(args)
    execute "silent! lgrepadd " . a:args
    botright lopen
    exec "redraw!"
endfunction

command! -nargs=* -complete=file LMGrep call LMGrep(<q-args>)
command! -nargs=* -complete=file LMGrepAdd call LMGrepAdd(<q-args>)
" --------------------------------------------------------------------------------- 
" NOTE: F10 looks like have some feature, when noremap with F10, the noremap will take no effects
" Don't use Ex mode, use Q for formatting
" noremap Q gq    
" Fold close & Fold open
noremap <unique> <kPlus> zo
noremap <unique> <kMinus> zc

" perforce key mapping
" TODO: should go to exSourceControl someday. { 
" let g:proj_run1='!p4 edit %f'
" nnoremap <Leader>po :silent !p4 edit %<CR>
" nnoremap <Leader>pr :silent !p4 revert %<CR>
command Checkout silent exec '!p4 edit ' . fnamemodify( bufname('%'), ':p' )
command Revert silent exec '!p4 revert ' . fnamemodify( bufname('%'), ':p' )
command Add silent exec '!p4 add ' . fnamemodify( bufname('%'), ':p' )
command Delete silent exec '!p4 delete ' . fnamemodify( bufname('%'), ':p' )
command Changelist :silent !p4 change
command ShowChangelist :!p4 changes -s pending -u jwu
" } TODO end 

" --------------------------------------------------------------------------------- 
" Desc: file types 
" --------------------------------------------------------------------------------- 
" VimTip 311: Open the folder containing the currently open file
" http://vim.sourceforge.net/tip_view.php?tip_id=
" 
" Occasionally, on windows, I have files open in gvim, that the folder for 
" that file is not open. This key noremap opens the folder that contains the 
" currently open file. The expand() is so that we don't try to open the 
" folder of an anonymous buffer, we would get an explorer error dialog in 
" that case.
" 
" DISABLE: auto highlight cursor word
" let g:ex_auto_hl_cursor_word = 1

" set exvim language noremap
" newexvim call exUtility#AddLangMap ( 'exvim', 'javascript', ['as'] )
" newexvim call exUtility#AddLangMap ( 'exvim', 'maxscript', ['ms'] )
" To let the extension language works correctly, you need to put tools/ctags/.ctags into your $HOME directory
" set ctags language noremap
" newexvim call exUtility#AddLangMap ( 'ctags', 'maxscript', ['ms'] )
" --------------------------------------------------------------------------------- 
map <Leader><F12> :call HexHighlight()<CR>

let g:user_zen_leader_key = '<c-z>'
"------------------------------------------------------------------  
let maplocalleader = '\'
"------------------------------------------------------------------  
noremap <leader>Q :qa<CR>

"noremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
" -------------------------------------------------------------------
"  ctags
" -------------------------------------------------------------------
" let g:ctags_options='--c-kinds=+lpx --c++-kinds=+lpx --fields=+ialS --extra=+qf --languages=c,c++,c#,java,python,vim,matlab,make,sh,XML, --langmap=c++:+.,c:+.C,c++:+.H,c++:+.inl,c++:+.ipp,python:+.pyw,c:+.hlsl,c:+.vsh,c:+.psh,c:+.fx,c:+.fxh,c:+.cg,c:+.shd,c:+.glsl, -I EXTERN=extern -I __nonull -I __dead2 -I __pure2 -I __unused -I __packed -I __aligned -I __section -I __always_inline -I __nonnull -I __wur -I __THROW'
let g:ctags_options='--tag-relative=no --c-kinds=+lpx --c++-kinds=+lpx --fields=+ialS --extra=+qf  -I EXTERN=extern -I __nonull -I __dead2 -I __pure2 -I __unused -I __packed -I __aligned -I __section -I __always_inline -I __nonnull -I __wur -I __THROW'

" autocmd VimLeave * :!echo -ne "\e]12;green\007"
" autocmd VimLeave * :!echo -ne "\e]12;black\007"

" au BufEnter *.txt setlocal ft=txt
" au BufEnter *.wiki set nocursorline

let g:TypesFileDoNotGenerateTags = 1
" let b:TypesFileIncludeLocals = 1

let g:Myalign_def = {
            \   'css': ['WP0p1l:', ':\@<=', 'v \v^\s*/\*|\{|\}'],
            \ }
" 对齐命令[[[2
function Lilydjwg_Align(type) range
    try
        let pat = g:Myalign_def[a:type]
    catch /^Vim\%((\a\+)\)\=:E716/
        echohl ErrorMsg
        echo "对齐方式" . a:type . "没有定义"
        echohl None
        return
    endtry
    call Align#AlignPush()
    call Align#AlignCtrl(pat[0])
    if len(pat) == 3
        call Align#AlignCtrl(pat[2])
    endif
    exe a:firstline.','.a:lastline."call Align#Align(0, '". pat[1] ."')"
    call Align#AlignPop()
endfunction
function Lilydjwg_Align_complete(ArgLead, CmdLine, CursorPos)
    return keys(g:Myalign_def)
endfunction

command -nargs=1 -range -complete=customlist,Lilydjwg_Align_complete LA <line1>,<line2>call Lilydjwg_Align("<args>")

" let g:TypesFileDoNotGenerateTags = 1
" let g:TypesCTagsFile =string(eval(g:exES_VimfilesDirName).'/tags_type')
" let g:TypesFileIncludeLocals = 1

function! QtCppIndent()
    " Patterns used to recognise labels and search for the start
    " of declarations
    let labelpat='signals:\|slots:\|public:\|protected:\|private:\|Q_OBJECT'
    let declpat='\(;\|{\|}\)\_s*.'
    " If the line is a label, it's a no brainer
    if match(getline(v:lnum),labelpat) != -1
        return 0
    endif
    " If the line starts with a closing brace, it's also easy: use cindent
    if match(getline(v:lnum),'^\s*}') != -1
        return cindent(v:lnum)
    endif
    " Save cursor position and move to the line we're indenting
    let pos=getpos('.')
    call setpos('.',[0,v:lnum,1,0])
    " Find the beginning of the previous declaration (this is what
    " cindent will mimic)
    call search(declpat,'beW',v:lnum>10?v:lnum-10:0)
    let prevlnum = line('.')
    " Find the beginning of the next declaration after that (this may
    " just get us back where we started)
    call search(declpat,'eW',v:lnum<=line('$')-10?v:lnum+10:0)
    let nextlnum = line('.')
    " Restore the cursor position
    call setpos('.',pos)
    " If we're not after a label, cindent will do the right thing
    if match(getline(prevlnum),labelpat)==-1
        return cindent(v:lnum)
        " It will also do the right thing if we're in the middle of a
        " declaration; this occurs when we are neither at the beginning of
        " the next declaration after the label, nor on the (non-blank) line
        " directly following the label
    elseif nextlnum != v:lnum && prevlnum != prevnonblank(v:lnum-1)
        return cindent(v:lnum)
    endif
    " Otherwise we adjust so the beginning of the declaration is one
    " shiftwidth in
    return &shiftwidth
endfunc
"这个会导致c++ public关键字缩进有问题
" set indentexpr=QtCppIndent()
" --------------------------------------------------------------------------------
" 二进制 vim -b 二进制文件
" 十六进制 先以二进制打开文件，再在命令模式键入 :%!xxd
" command TOBIN silent exec '%!xxd'
"To hex modle
let s:hexModle = "N"
function! ToHexModle()
    if s:hexModle == "Y"
        %!xxd -r
        let s:hexModle = "N"
    else
        %!xxd
        let s:hexModle = "Y"
    endif
endfunction

map <leader>hx :call ToHexModle()<cr>

function! DoPrettyXML()
    silent %!xmllint --format  --encode UTF-8 -
endfunction
command! PrettyXML call DoPrettyXML()

function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        " echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    " exec('leftabove  '.a:pfx.'open')
    exec(a:pfx.'open')
    if winnr() != winnr
        " wincmd p
    endif
endfunction

function! TQFix()
    :LQFix
    :CQFix
endfunction
command -bang -nargs=? LQFix call ToggleList("Location List", 'l')
command -bang -nargs=? CQFix call ToggleList("Quickfix List", 'c')
command -bang -nargs=? TQFix call TQFix()
nmap <silent> <leader>lo :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>co :call ToggleList("Quickfix List", 'c')<CR>
map <leader>er /error<CR>

command -nargs=? Sw :w !sudo tee %

let g:EasyGrepWindow=1
let g:EasyGrepReplaceWindowMode=2
"------------------------------------------------------------------  
" keymaps -   
"------------------------------------------------------------------  
" smart coding map
" noremap <leader>bb <esc>F(a
inoremap <a-h> <esc>:call BackBra()<CR>a
inoremap <a-l> <esc>:call EndBra()<CR>a
" inoremap <a-l> <ESC>f)a
inoremap <a-e> <ESC>
function BackBra()

    let cursor_pos = getpos('.')
    let cur_pos = cursor_pos[2]-1

    let start = 1
    let i = 0
    let mylist = []

    while start < cur_pos && i != -1
        let i = match(getline("."), "[([{<'\"]", start)
        if i != -1 && i < cur_pos
            let mylist += [i]
        endif
        let start = i+1
    endw

    let c = max(mylist)
    if c != 0
        let d = c+1
        call cursor('.', d)
    endif

endfunction

function EndBra()
    let cursor_pos = getpos('.')
    let cur_pos = cursor_pos[2]-1

    let start = cur_pos 
    let end = strlen(getline("."))
    let i = cur_pos
    let mylist = []

    while start < end && i != -1
        let i = match(getline("."), "[])}>'\"]", start)  
        if i != -1 && i > cur_pos
            let mylist += [i]
        endif
        let start = i+1
    endw

    let c = min(mylist)
    if c != 0
        let d = c + 1
        call cursor('.', d)
    endif
endfunction

noremap <A-w> :w!<CR>
inoremap <A-w> <ESC>:w!<CR>
" 切换到当前文件目录
nnoremap <S-space> :cd %:p:h<cr>  
" noremap  ' <c-w>
" noremap :q <cr>:q!<cr>
vnoremap g) <esc>`>a)<esc>`<i(<esc>
vnoremap g] <esc>`>a]<esc>`<i[<esc>
vnoremap g} <esc>`>a}<esc>`<i{<esc>
vnoremap g" <esc>`>a"<esc>`<i"<esc>
vnoremap g' <esc>`>a'<esc>`<i'<esc>

noremap <leader>sp  "+p
noremap <leader>sy  "+y

noremap <leader>pa  "ap
noremap <leader>ya  "ay
noremap <leader>pb  "bp
noremap <leader>yb  "by
noremap <leader>pc  "cp
noremap <leader>yc  "cy
noremap <leader>pd  "dp
noremap <leader>yd  "dy
noremap <leader>pe  "ep
noremap <leader>ye  "ey
noremap <leader>pf  "fp
noremap <leader>yf  "fy
noremap <leader>pg  "gp
noremap <leader>yg  "gy

" 在,gg里搜索结果里继续搜索时用,* 不要用,*
vnoremap <Leader># "9y?<C-R>='\V'.substitute(escape(@9,'\?'),'\n','\\n','g')<CR><CR>
vnoremap <Leader>* "9y/<C-R>='\V'.substitute(escape(@9,'\/'),'\n','\\n','g')<CR><CR>
" vnoremap <Leader># "9y?<C-R>=substitute(escape(@9,'\?'),'\n','\\n','g')<CR><CR>
" vnoremap <Leader>* "9y/<C-R>=substitute(escape(@9,'\/'),'\n','\\n','g')<CR><CR>

nnoremap <silent><leader>hl :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! PreviewDown()
    if !&previewwindow
        silent! wincmd P
    endif
    if &previewwindow
        silent! wincmd J
        silent! wincmd p
    endif
endf
" au BufWinEnter * call PreviewDown() 

command Astyle silent exec '%!astyle --style=kr'

" 函数定义 ，] 返回历史列表用,tt   直接返回用bs
" marker用,ms

function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message
    set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
command! -nargs=+ -complete=command TM call TabMessage(<q-args>)

function! SuperESC()
    wincmd j
    exec "normal \<ESC>"
    silent exec "cclose"
    silent exec "lclose"
    silent exec "pclose"
endfunction

noremap <S-ESC> :silent call SuperESC()<CR>
imap <S-ESC> <c-o>:silent call SuperESC()<CR>

command! -bar Helptags :call plug#helptags()

" vim:ts=4:sw=4:sts=4 et fdm=marker:
