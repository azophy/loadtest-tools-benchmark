--adapted from https://gist.github.com/haggen/2fd643ea9a261fea2094?permalink_comment_id=4185532#gistcomment-4185532
math.randomseed(os.clock())
local charset = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"

function randomString(length)
	local ret = {}
	local r
	for i = 1, length do
		r = math.random(1, #charset)
		table.insert(ret, charset:sub(r, r))
	end
	return table.concat(ret)
end

wrk.method = "POST"
wrk.body   = randomString(10)
