local App = {}

function App.get (app, path, params, fn)
	if app.req.method == "get" then
		if app.req.url == path then
			fn (app.req, app.res)
			app.handled = true
		end
	end
end

function App.post(self, path, params, fn)
	if app.req.method == "post" then
		if app.req.url == path then
			fn (app.req, app.res) -- data ?? must review api
			app.handled = true
		end
	end
end

function App.put(self, path, params, fn)
  if app.req.method == "put" then
    if app.req.url == path then
      fn (app.req, app.res) -- data ?? must review api
      app.handled = true
    end
  end
end

function App.patch(self, path, params, fn)
  if app.req.method == "patch" then
    if app.req.url == path then
      fn (app.req, app.res) -- data ?? must review api
      app.handled = true
    end
  end
end

function App.delete(self, path, params, fn)
  if app.req.method == "delete" then
    if app.req.url == path then
      fn (app.req, app.res) -- data ?? must review api
      app.handled = true
    end
  end
end

function App.error(self, fn)
	-- TODO
end

App.method = {}

return App
