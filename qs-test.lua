local qs = require ("querystring")

obj = {}
obj.foo="bar&lol"
obj.bar = true
obj.cow=33
obj.arr={1,3,4}
obj.arr.food="carrot"

p(qs.stringify(obj))

p(qs.unescape("A%41%41"))
