
if exists("g:loaded_myconfig_tlist")
	finish
endif
let g:loaded_myconfig_tlist=1

if exists(":Tlist")
	Tlist
	TlistHighlight
endif

