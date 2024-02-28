# loadtest-tools-benchmark
benchmark of various load testing tools, focusing on open source, scriptable, command-line based tools

I've read [this great article from the creator of k6 about benchmarking of various load testing tools](https://grafana.com/blog/2020/03/03/open-source-load-testing-tool-review/). However the article was from 2020, and I wish I could have the latest data for the tools I'm currently interested with.

The criteria of the tools I prefers:
- open source. its 2024 guys
- support scripting. Only testing static GET or POST requests are useless to me. Also support better collaboration
- command line. I hate GUI tools
- local tools. No cloud based SaaS please
- fast enough. Java & Python seems like a no go

The tools I wish to look into:
- https://github.com/wg/wrk/ -> limited scriptability with Lua
- https://github.com/giltene/wrk2 -> same as above
- https://github.com/vearutop/plt -> scriptable by modifying go file
- https://github.com/rogerwelin/cassowary -> need to make sure about the scriptability. the docs only mention scripting the parameters
- https://k6.io -> huge ecosystem. I just need to check the performance
- https://www.artillery.io -> scriptable payload as selecting random item from list of available payloads
- https://github.com/mcollina/autocannon -> nodejs based

Tools I intentionally excluded:
- Java based: jmeter, gatling
- not scriptable: hey, vegeta
  
Metrics I look out for. For a given target & given testing device specification:
- how many request could be made
- how much memory used
- latency of the generated requests
