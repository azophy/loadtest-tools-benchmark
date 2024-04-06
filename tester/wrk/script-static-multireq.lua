-- list of HTTP methods
methods = {
  "GET",
  "POST",
}

-- below script were adapted from: http://czerasz.com/2015/07/19/wrk-http-benchmarking-tool-example/
-- Initialize the requests array iterator
counter = 1

request = function()
  -- Get the next requests array element
  local request_method = methods[counter]

  -- Increment the counter
  counter = counter + 1

  -- If the counter is longer than the requests array length then reset it
  if counter > #methods then
    counter = 1
  end

  -- Return the request object with the current URL path
  return wrk.format(request_method)
end
