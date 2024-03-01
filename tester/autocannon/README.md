AUTOCANNON REVIEW
=================

Personally I think this is the tool I put most of my hope to beat wrk. Its nodejs-based so its easily scriptable & extendable, and the performance is very high while the resource usage are very low compared to k6 which also scriptable using js (but without nodejs ecosystem capabilities).

one the most interesting thing is Autocannon support [HTTP pipelining](https://en.wikipedia.org/wiki/HTTP_pipelining) which allows creating multiple parallel request over single connection, making the troughput very high.
