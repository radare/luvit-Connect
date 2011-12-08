-- luvit-connect example --
local connect = require ("connect")

local server = connect.createServer ()
	:use (connect.logger ())
	:use (connect.router (function (app)
		app:get ("/", app.req.query, function (req, res)
			local body = "<html><h1>Hello Luvit Connect World!</h1></html>"
			res:write_head (200, {
				["Content-Type"] = "text/html",
				["Content-Length"] = #body
			})
			res:finish (body)
		end)
	end))
	:listen (3333)
