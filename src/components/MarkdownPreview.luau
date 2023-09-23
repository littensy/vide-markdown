local markdown = require(script.Parent.Parent.markdown)
local Vide = require(script.Parent.Parent.packages.Vide)

local DEFAULT_TEXT = [[
# Header
## Subheader
### Subsubheader

**Bold**
*Italic* _Italic_
~~Strikethrough~~
__Underline__
**~~__Combined__~~**

**Incomplete
]]

local function MarkdownPreview()
	local inputText = Vide.source(DEFAULT_TEXT)

	local previewText = Vide.derive(function()
		return markdown.parse(inputText())
	end)

	return Vide.create "Frame" {
		BackgroundColor3 = Color3.fromRGB(235, 235, 241),
		BorderSizePixel = 0,

		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 400, 0, 300),
		Position = UDim2.new(0.5, 0, 0.5, 0),

		Vide.create "UICorner" {
			CornerRadius = UDim.new(0, 12),
		},

		Vide.create "TextBox" {
			Name = "InputField",

			ClearTextOnFocus = false,
			MultiLine = true,
			PlaceholderText = "Input markdown",

			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium),
			RichText = true,
			Text = DEFAULT_TEXT,
			TextSize = 16,
			TextColor3 = Color3.fromRGB(27, 26, 35),
			TextXAlignment = "Left",
			TextYAlignment = "Top",

			BackgroundTransparency = 1,

			Size = UDim2.new(0.5, 0, 1, 0),

			Vide.changed("Text", inputText),

			Vide.create "UIPadding" {
				PaddingTop = UDim.new(0, 12),
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
			},
		},

		Vide.create "TextLabel" {
			Name = "MarkdownPreview",

			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium),
			RichText = true,
			Text = previewText,
			TextSize = 16,
			TextColor3 = Color3.fromRGB(27, 26, 35),
			TextXAlignment = "Left",
			TextYAlignment = "Top",

			BackgroundTransparency = 1,

			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),

			Vide.create "UIPadding" {
				PaddingTop = UDim.new(0, 12),
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
			},
		},
	}
end

return MarkdownPreview
