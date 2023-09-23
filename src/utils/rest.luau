local function rest(props: { [any]: any }): { [number]: any }
	return { table.unpack(props) }
end

return rest
