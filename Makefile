ifneq ($(OS), Linux)
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
PROFILE_DIR := $(shell powershell -Command "echo 'Split-Path -Parent $$profile'")
PROFILE_NAME := $(shell powershell -Command "echo 'Split-Path -Leaf $$profile'")
DOCUMENTS_DIR := $(shell powershell -Command "[Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)")
endif

.PHONY: all delete vars nvim powershell lf autohotkey wezterm

all:
	stow --verbose --target=$(HOME) --restow */

delete:
	stow --verbose --target=$(HOME) --delete */

nvim:
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype Junction -path $(USERPROFILE)\AppData\Local -name nvim -value $(CURDIR)/nvim }
	@if ( "$(OS)" -eq "Linux") { ln -s $(CURDIR)/nvim/ $(HOME)/.config}

powershell:
	@if ( "$(OS)" -eq "Linux" ) { echo "'powershell' is not supported for installation on Linux."}
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype Junction -path "$(PROFILE_DIR)" -name $(PROFILE_NAME) -value $(CURDIR)/powershell/profile.ps1 }

lf:
	@if ( "$(OS)" -eq "Windows_NT" ) { echo "'lf' is not supported for installation on Windows."}
	@if ( "$(OS)" -eq "Linux") { ln -s $(CURDIR)/lf $(HOME)/.config}

autohotkey:
ifeq ("$(OS)","Windows_NT")
	new-item -itemtype HardLink -path "$(DOCUMENTS_DIR)\AutoHotkey" -name user_config.ahk -value $(CURDIR)/autohotkey/user_config.ahk
	new-item -itemtype HardLink -path "$(DOCUMENTS_DIR)\AutoHotkey" -name window.ahk -value $(CURDIR)/autohotkey/window.ahk
	new-item -itemtype HardLink -path "$(DOCUMENTS_DIR)\AutoHotkey" -name mouse.ahk -value $(CURDIR)/autohotkey/mouse.ahk
else
	echo "'autohotkey' is not supported on Linux."
endif

wezterm:
	@if ( "$(OS)" -eq "Linux" ) { echo "'wezterm' is not supported for installation on Linux."}
	@if ( "$(OS)" -eq "Windows_NT" ) { new-item -itemtype hardLink -path "$(USERPROFILE)" -name ".wezterm.lua" -value $(CURDIR)/wezterm/wezterm.lua }

vars:
	@echo "PROFILE_DIR: $(PROFILE_DIR)"
	@echo "PROFILE_NAME: $(PROFILE_NAME)"
	@echo "USERPROFILE: $(PROFILE_NAME)"
