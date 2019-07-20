checkout-submodules:
	git submodule update --recursive --checkout

update-submodules:
	git submodule update --recursive --remote --checkout
