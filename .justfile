check:
	curl -o ci/roblox.d.lua https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.lua
	rojo sourcemap dev.project.json -o dev.sourcemap.json
	luau-lsp analyze --defs=ci/roblox.d.lua --base-luaurc=.luaurc --sourcemap=dev.sourcemap.json --ignore="**/_Index/**" src
	selene src
	stylua --check src
	rm ci/roblox.d.lua
	rm dev.sourcemap.json

install:
	wally install
	rojo sourcemap default.project.json -o sourcemap.json
	wally-package-types Packages --sourcemap=sourcemap.json
