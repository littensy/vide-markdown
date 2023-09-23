local constants = require(script.Parent.Parent.constants)
local Vide = require(script.Parent.Parent.packages.Vide)
local rest = require(script.Parent.Parent.utils.rest)

type LayerProps = {
	displayOrder: number?,
	[any]: any,
}

local function Layer(props: LayerProps)
	return if constants.IS_STORY
		then Vide.create "Frame" {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = props.displayOrder,
			rest(props),
		} :: never
		else Vide.create "ScreenGui" {
			DisplayOrder = props.displayOrder,
			IgnoreGuiInset = true,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			rest(props),
		}
end

return Layer
