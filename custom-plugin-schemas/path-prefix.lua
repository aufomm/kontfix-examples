local typedefs = require("kong.db.schema.typedefs")
local PLUGIN_NAME = "path-prefix"

return {
	name = PLUGIN_NAME,
	fields = {
		{ consumer = typedefs.no_consumer },
		{ protocols = typedefs.protocols_http },
		{
			config = {
				type = "record",
				fields = {
					{ path_prefix = { type = "string", required = true } },
					{ escape = { type = "boolean", default = true } },
					{ forwarded_header = { type = "boolean", default = false } },
				},
			},
		},
	},
	entity_checks = {},
}
