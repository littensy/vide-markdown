local Layer = require(script.Parent.Layer)
local MarkdownPreview = require(script.Parent.MarkdownPreview)

local function App()
	return Layer {
		MarkdownPreview(),
	}
end

return App
