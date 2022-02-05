
" vim: ft=vim
"{{{ encoding
scriptencoding utf8
set fencs=utf8,eucjp,sjis
"}}}

"{{{ plugins
filetype off
" vim-scripts/Pydiction
let g:pydiction_location = $HOME + '.cache/vim-pydiction-dict'

" haya14busa/incsearch.vim
"{{{
"検索パターン入力中に、マッチした領域のハイライトを更新やカーソルの移動をする
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

" scrooloose/syntastic
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11'

" vim-scripts/diffchar.vim
" 編集中にハイライトをアップデートする
let g:DiffUpdate = 1

" kannokanno/previm
let g:previm_open_cmd = 'xdg-open'

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
set foldlevel=99  "デフォルトでは全てのfoldを開いておく"
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

