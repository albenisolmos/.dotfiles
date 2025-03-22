Set-Alias -Name v -Value nvim

Function gst {
	git status
}

Function gpush {
	git push origin main
}

Function gpull {
	git pull origin main
}

Function fn-gadd {
	git add
}

Function fn-gdff {
	git diff
}

Set-Alias -Name gdff -Value fn-gdff
Set-Alias -Name gadd -Value fn-gadd
