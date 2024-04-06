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

-- list of HTTP method & path pairs
requests = {
  { "GET", "/test/wrk/dynamic-multireq"},
  { "POST", "/test/wrk/dynamic-multireq"},
}

-- below script were adapted from: http://czerasz.com/2015/07/19/wrk-http-benchmarking-tool-example/
-- Initialize the requests array iterator
counter = 1

request = function()
  -- Get the next requests array element
  local request_object = requests[counter]

  -- Increment the counter
  counter = counter + 1

  -- If the counter is longer than the requests array length then reset it
  if counter > #requests then
    counter = 1
  end

  -- add random string as query param
  url = request_object[2] .. "?q=" .. randomString(5)

  -- Return the request object with the current URL path
  return wrk.format(request_object[1], url)
end
