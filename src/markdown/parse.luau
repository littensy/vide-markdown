type Modifiers = {
	asterisk3: boolean?,
	asterisk2: boolean?,
	asterisk1: boolean?,
	underscore3: boolean?,
	underscore2: boolean?,
	underscore1: boolean?,
	hash3: boolean?,
	hash2: boolean?,
	hash1: boolean?,
	tilde2: boolean?,
	[string]: any,
}

local ENDING_MODIFIERS = {
	asterisk3 = "</i></b>",
	asterisk2 = "</b>",
	asterisk1 = "</i>",
	underscore3 = "</u></i>",
	underscore2 = "</u>",
	underscore1 = "</i>",
	tilde2 = "</s>",
}

local function parse(markdown: string): string
	local modifiers: Modifiers = {}
	local length = #markdown
	local cursor = 1
	local output = ""

	local function peek(amount: number): string
		return string.sub(markdown, cursor, cursor + amount - 1)
	end

	local function peekBehind(amount: number): string
		return string.sub(markdown, cursor - amount, cursor - 1)
	end

	local function consume(amount: number): string
		cursor += amount
		return string.sub(markdown, cursor - amount, cursor - 1)
	end

	while cursor <= length + 1 do
		if peek(3) == "***" then
			output ..= if not modifiers.asterisk3 then "<b><i>" else "</i></b>"
			modifiers.asterisk3 = not modifiers.asterisk3
			consume(3)
		elseif peek(2) == "**" then
			output ..= if not modifiers.asterisk2 then "<b>" else "</b>"
			modifiers.asterisk2 = not modifiers.asterisk2
			consume(2)
		elseif peek(1) == "*" then
			output ..= if not modifiers.asterisk1 then "<i>" else "</i>"
			modifiers.asterisk1 = not modifiers.asterisk1
			consume(1)
		elseif peek(3) == "___" then
			output ..= if not modifiers.underscore3 then "<i><u>" else "</u></i>"
			modifiers.underscore3 = not modifiers.underscore3
			consume(3)
		elseif peek(2) == "__" then
			output ..= if not modifiers.underscore2 then "<u>" else "</u>"
			modifiers.underscore2 = not modifiers.underscore2
			consume(2)
		elseif peek(1) == "_" then
			output ..= if not modifiers.underscore1 then "<i>" else "</i>"
			modifiers.underscore1 = not modifiers.underscore1
			consume(1)
		elseif peek(2) == "~~" then
			output ..= if not modifiers.tilde2 then "<s>" else "</s>"
			modifiers.tilde2 = not modifiers.tilde2
			consume(2)
		elseif peek(3) == "###" and (cursor == 1 or peekBehind(1) == "\n") then
			output ..= if not modifiers.hash3 then '<font size="16"><b>' else ""
			modifiers.hash3 = not modifiers.hash3
			consume(3)
		elseif peek(2) == "##" and (cursor == 1 or peekBehind(1) == "\n") then
			output ..= if not modifiers.hash2 then '<font size="20"><b>' else ""
			modifiers.hash2 = not modifiers.hash2
			consume(2)
		elseif peek(1) == "#" and (cursor == 1 or peekBehind(1) == "\n") then
			output ..= if not modifiers.hash1 then '<font size="24"><b>' else ""
			modifiers.hash1 = not modifiers.hash1
			consume(1)
		elseif (peek(1) == "\n" or peek(1) == "") and (modifiers.hash1 or modifiers.hash2 or modifiers.hash3) then
			output ..= "</b></font>" .. consume(1)
			modifiers.hash1, modifiers.hash2, modifiers.hash3 = false, false, false
		else
			output ..= consume(1)
		end
	end

	for modifier, active in modifiers do
		if active then
			output ..= ENDING_MODIFIERS[modifier] or ""
		end
	end

	return output
end

return parse
