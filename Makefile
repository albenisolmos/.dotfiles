ifneq ($(OS), Linux)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
PROFILE_DIR := $(shell powershell -Command "echo 'Split-Path -Parent $$profile'")
PROFILE_NAME := $(shell powershell -Command "echo 'Split-Path -Leaf $$profile'")
endif

all:
	stow --verbose --target=$(HOME) --restow */

delete:
	stow --verbose --target=$(HOME) --delete */

nvim:
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype Junction -path $(USERPROFILE)\AppData\Local -name nvim -value $(CURDIR)/nvim/.config/nvim }
	@if ( "$(OS)" -eq "Linux") { ln -s $(CURDIR)/nvim/.config/nvim $(HOME)/.config}

powershell:
	@if ( "$(OS)" -eq "Linux" ) { echo "'powershell' is not supported for installation on Linux."}
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype Junction -path "$(PROFILE_DIR)" -name $(PROFILE_NAME) -value $(CURDIR)/powershell/profile.ps1 }

lf:
	@if ( "$(OS)" -eq "Windows_NT" ) { echo "'lf' is not supported for installation on Windows."}
	@if ( "$(OS)" -eq "Linux") { ln -s $(CURDIR)/lf $(HOME)/.config}

test:
	echo "$(PROFILE_DIR)"
	echo "$(PROFILE_NAME)"
