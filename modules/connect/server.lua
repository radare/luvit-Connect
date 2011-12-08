-- luvit-connect middleware framework --
-- author:  pancake<nopcode>
-- license: MIT

local os = require('os')
local Url = require('url')
local HTTP = require("http")
local table = require ("table")

local App = require ("./app")

local server = {}

function table.copy(t, deep, seen)
    seen = seen or {}
    if t == nil then return nil end
    if seen[t] then return seen[t] end

    local nt = {}
    for k, v in pairs(t) do
        if deep and type(v) == 'table' then
            nt[k] = table.copy(v, deep, seen)
        else
            nt[k] = v
        end
    end
    setmetatable(nt, table.copy(getmetatable(t), deep, seen))
    seen[t] = nt
    return nt
end

function server.createServer()
	local s = table.copy(server)
	s.app = table.copy(App)
	s.query = {}
	s.handlers = {}
	return s
end

function server.favicon(s)
	return s
end

function server.static(s, a, b)
	if not b then b = a ; a = "" end
	return s
end

function server.logger()
	local h = function (app)
		local ts = os.date ("%Y-%m-%d %H:%M:%S")
		print (ts.."  "..app.req.method.." : "..app.req.url)
	end
	return h
end

function server.use(s, h)
	table.insert (s.handlers, h)
	return s
end

function server.listen(s, port)
	print ("luvit-Connect listening on port "..port)
	HTTP.create_server ("0.0.0.0", port, function (req, res)
		local app = s.app
		app.server = s
		app.req = req
		app.res = res
		--- xxx not async or wtf
		app.handled = false
		for i=1, #s.handlers do
			s.handlers[i] (app)
		end
		-- 404 --
		if not app.handled then
			local body = "<html><h1>404: resource not found</h1></html>"
			res:write_head (404, {
				["Content-Type"] = "text/html",
				["Content-Length"] = #body
			})
			res:finish (body)
		end
		
	end)
end

function server.router(fn)
	local x = function (app)
		return fn (app)
		-- optimize
		--if app.method[app.req.method] then
		--	print ("I CAN HAS A REG")
		--	return fn (app, app.req, app.res)
		--end
	end
	return x
end

return server
