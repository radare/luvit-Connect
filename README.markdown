luvit-Connect
=============
This luvit module aims to clone Node's Connect framework.

TODO
----
This module is still work in progress and very incomplete, do not use it in
production environments. Feel free to contribute and send us ideas.

Optimizations
-------------
Some possible optimizations has been detected and need to be evaluated when
the API is done. It is important to keep compatibility with Node API.

We can then wrap the optimizations or extend the api to support faster routing.

Example
-------
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
