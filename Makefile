ifneq ($(OS), Linux)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command 
endif

STOWDIR=$(CURDIR)/nvim/.config

.PHONY: nvim

all:
	stow --verbose --target=$(HOME) --restow */

delete:
	stow --verbose --target=$(HOME) --delete */

nvim:
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype Junction -path $(USERPROFILE)\AppData\Local -name nvim -value $(CURDIR)/nvim/.config/nvim }
	@if ( "$(OS)" -eq "Linux") { ln -s $(STOWDIR)/nvim $(HOME)/.config}
