
" vim: ft=vim
"{{{ encoding
scriptencoding utf8
set fencs=utf8,eucjp,sjis
"}}}

"{{{ plugins
filetype off

"{{{ neovandle
"プラグインの管理を自動化
call neobundle#begin('~/.vim/vandle-bundle/')

NeoBundle 'leafgarland/typescript-vim.git'
NeoBundle 'clausreinke/typescript-tools.vim'

NeoBundle 'JesseKPhillips/d.vim'

"source code formatter
" astyle, autopen8, js-beautifyを必要とする
NeoBundle "Chiel92/vim-autoformat"

"ctags
NeoBundle 'szw/vim-tags'
NeoBundle 'vim-scripts/taglist.vim'

"GNU global
"NeoBundle '5t111111/alt-gtags.vim'

"vim less
"NeoBundle 'groenewege/vim-less'

"ファイラ
NeoBundle 'opsplorer'

"テキストの置換をヴィジュアル化
"OverCommandLine 
NeoBundle 'osyo-manga/vim-over'

"検索パターン入力中に、マッチした領域のハイライトを更新やカーソルの移動をする
NeoBundle 'haya14busa/incsearch.vim'
"{{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"}}}

"カッコを自動で閉じる／自動改行／インデントする
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'kana/vim-smartinput'

"選択範囲をコメントアウト
"\xでコメントアウトの切り替え
"INSERTモードでも動作してしまうのが気になる
NeoBundle 'hrp/EnhancedCommentify'

"変更行を可視化
NeoBundle 'airblade/vim-gitgutter'

"HTMLのタグを自動で閉じる
NeoBundle 'alvan/vim-closetag'

"引用符やタグなど、テキストを囲うものの編集を支援する
NeoBundle 'tpope/vim-surround'

"%で対応するタグへ移動できるようにする
NeoBundle 'vim-scripts/matchit.zip'

"colorscheme
"{{{
"彩度が強い
NeoBundle 'tomasr/molokai'
"パステルカラーで明るめ
NeoBundle 'jonathanfilip/vim-lucius'
"低コントラスト
NeoBundle 'w0ng/vim-hybrid'
"}}}

"自動補完
NeoBundle 'Shougo/neocomplete'
"{{{

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}
"pythonの自動補完
NeoBundle 'vim-scripts/Pydiction'

"syntax"
NeoBundle 'scrooloose/syntastic'
"{{{
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
"}}}

"NERDTree
NeoBundle 'scrooloose/nerdtree'

"Emmet
"短縮表記からhtmlやcssに展開する
NeoBundle 'mattn/emmet-vim'

"quickrun
"ちょっとしたコード片をその場で実行して確認できる
NeoBundle 'thinca/vim-quickrun'

"vimdiffを単語単位で差分表示する
NeoBundle 'vim-scripts/diffchar.vim'
"{{{
"編集中にハイライトをアップデートする
let g:DiffUpdate = 1
"}}}

"pythonのインデントをマドモに機能させる
NeoBundleLazy 'hynek/vim-python-pep8-indent'

" Realtime preview by Vim. (Markdown, reStructuredText, textile)
NeoBundle 'kannokanno/previm'
let g:previm_open_cmd = 'xdg-open'

NeoBundle 'plasticboy/vim-markdown'

"テキスト整形
NeoBundle 'godlygeek/tabular'

"grep.vim
"NeoBundle 'grep.vim'

NeoBundle 'PotatoesMaster/i3-vim-syntax'
NeoBundle 'superbrothers/vim-vimperator'
NeoBundle 'othree/html5.vim'
NeoBundle 'JulesWang/css.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'yoppi/fluentd.vim'
NeoBundle 'moon-musick/vim-logrotate'

NeoBundleCheck
call neobundle#end()
"

"}}}
filetype on
"}}}

filetype indent on
filetype plugin on

syntax on

"clipboard"{{{
set clipboard=unnamed,unnamedplus
"}}}

"{{{ serarch
set ignorecase smartcase	"大・小文字を区別しない。ただし検索文字に大文字を含む場合は大小を区別。
set incsearch	"インクリメンタルサーチ
set hlsearch	"検索マッチテキストをハイライト
"set nowrapscan	"検索をループしない
"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
"}}}

"{{{ edit
set nrformats+=alpha	"アルファベットを増減"
"set virtualedit& virtualedit+=block	"文字が存在しない場所までカーソルを移動可能に
"set autoindent	"自動インデントを有効に
set smartindent
set copyindent	"インデントに使用する文字は周囲と統一する。
set infercase	"補完時に大文字小文字を区別しない
set hidden	"バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen	"新しく開く代わりにすでに開いてあるバッファを開く
set showmatch	"対応する括弧などをハイライト表示する
set matchtime=1
set matchpairs& matchpairs+=<:>	"対応括弧に'<'と'>'のペアを追加
"set backspace=indent,eol,start	"バックスペースでなんでも消せるようにする
"backupファイルの無効化
"set nowritebackup
"set nobackup
"}}}

"{{{ color
set background=dark
colorscheme molokai
highlight Normal ctermfg=white ctermbg=black
highlight CursorLine cterm=bold 
"}}}

""{{{ highlight
"カレント行のハイライト
"set cursorcolumn
"set cursorline 
set nocursorline nocursorcolumn
augroup vimrc-auto-cursorline
	autocmd!
	autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
	autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
	autocmd WinEnter * call s:auto_cursorline('WinEnter')
	autocmd WinLeave * call s:auto_cursorline('WinLeave')

	let s:cursorline_lock = 0
	function! s:auto_cursorline(event)
		if a:event ==# 'WinEnter'
			setlocal cursorline cursorcolumn
			let s:cursorline_lock = 2
		elseif a:event ==# 'WinLeave'
			setlocal nocursorline nocursorcolumn
		elseif a:event ==# 'CursorMoved'
			if s:cursorline_lock
				if 1 < s:cursorline_lock
					let s:cursorline_lock = 1
				else
					setlocal nocursorline nocursorcolumn
					let s:cursorline_lock = 0
				endif
			endif
		elseif a:event ==# 'CursorHold'
			setlocal cursorline cursorcolumn
			let s:cursorline_lock = 1
		endif
	endfunction
augroup END

set wildmode=longest,list,full	"ファイル名補完を見やすく"
set conceallevel=1	"行の一部を非表示
set matchpairs=(:),{:},[:]
" 行末のスペースをハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
"}}}

"{{{ 折りたたみ
set foldmethod=marker	"マーカを元に行の折り畳みをする"
set foldcolumn=0
"}}}

"{{{ view
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set ruler	"カーソルの位置をステータスバーに表示"
set title	"タイトルの表示をファイル名へ変更"
set showcmd
set showmode
set backspace=
set synmaxcol=1000	"長い行による動作速度低下を防止"
"set list	"不可視文字の可視化
set rnu	"カーソル行からの相対行番号の表示
set wrap	"長いテキストの折り返し
set textwidth=0	"自動的に改行が入るのを無効化
"デフォルト不可視文字は美しくないのでUnicodeで綺麗に
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

set display=lastline	"非常に長い行でも表示する"
set modeline	"ファイルの一部だけ他のファイルタイプを使用可能に"
set lazyredraw	"スクリプト実行中は画面の描画を停止する"
"}}}

"{{{ keybind
"vim-tags"{{{
"nnoremap <C-j><C-j> :TagsGenerate<cr>
nnoremap <C-]> g<C-]>
"}}}
"	gnu global"{{{
" QuickFix
"        map <C-n> :cn<CR>
"        map <C-p> :cp<CR>
" alt-gtags.vim
"        nnoremap <C-j> :AltGtags<CR>
"        nnoremap <C-k> :AltGtags -r<CR>
"        nnoremap <C-l> :AltGtags -s<CR>
"}}}
set mouse=	"マウス操作無効化"

"Yだけ一貫性のない動きなので修正
nnoremap Y y$
"入力モード中に素早くjjと入力した場合はescとみなす
inoremap jj <esc>
"escを二回押すことでハイライトを消す
nmap <silent> <esc><esc> :nohlsearch<cr>
"j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
"ctrl + hjkl でウィンドウ間を移動
"tmuxのキーバインドと衝突してしまうので無効化
"nnoremap <c-h> <c-w>h
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
:noremap + :vimgrep /<C-r>='\V'.escape(expand('<cword>'), '/\')<CR>/ % <bar> copen <enter>

"    noremap <c-g> ggvg:vimshellsendstring<cr><c-o>
"    vnoremap <c-g> :vimshellsendstring<cr>
set timeout timeoutlen=1000 ttimeoutlen=10	"escなどの反応速度を上げる。副作用あり注意"
"}}}

"function"{{{
command! -nargs=1 -bang -bar -complete=file Rename saveas<bang> <args> | call delete(expand('#:p'))

" 他で開いているファイルを開こうとした時は、Read Onlyで開く
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END
"}}}

"{{{ Tab jump
for n in range(1,9)
	execute 'nnoremap <silent> t'.n ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> tc :tablast <bar> tabnew<CR>
map <silent> tx :tabclose<CR>
map <silent> tn :tabnext<CR>
map <silent> tp :tabprevious<CR>

"}}}

"実験的

autocmd QuickFixCmdPost *grep* cwindow

