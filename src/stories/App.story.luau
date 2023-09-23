local App = require(script.Parent.Parent.components.App)
local Vide = require(script.Parent.Parent.packages.Vide)

return function(target)
	return Vide.mount(App, target)
end
