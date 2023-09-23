local Players = game:GetService("Players")

local App = require(script.components.App)
local constants = require(script.constants)
local Vide = require(script.packages.Vide)

Vide.strict = constants.IS_DEV

Vide.mount(App, Players.LocalPlayer:WaitForChild("PlayerGui"))
