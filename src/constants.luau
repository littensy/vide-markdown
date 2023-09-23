local RunService = game:GetService("RunService")

return {
	IS_DEV = RunService:IsStudio(),
	IS_STORY = RunService:IsStudio() and not RunService:IsRunning(),
}
