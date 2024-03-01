# loadtest-tools-benchmark
benchmark of various load testing tools, focusing on open source, scriptable, command-line based tools

I've read [this great article from the creator of k6 about benchmarking of various load testing tools](https://grafana.com/blog/2020/03/03/open-source-load-testing-tool-review/). However the article was from 2020, and I wish I could have the latest data for the tools I'm currently interested with.

The criteria of the tools I prefers:
- open source. its 2024 guys
- support dynamic payload. Only testing static GET or POST requests are useless to me
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
- https://github.com/fcsonline/drill -> yaml scriptable
- locust -> python based
- https://github.com/tsenart/vegeta -> need to make sure how to do dynamic payload

Tools I intentionally excluded:
- Java based: jmeter, gatling, ab
- no dynamic payload: hey

Metrics I look out for. For a given target & given testing device specification:
- how many request could be made
- how much memory used
- latency of the generated requests

My plan is to test in 3 scenario:
- static single GET
- dynamic single POST
- complex multiple requests

## The setup
- Using docker compose, all network calls are made locally
- the target is simple go app with prometheus exporter. the docker compose also included prometheus scrapper & grafana for visualization


## Running

1. clone
2. docker compose up -d
3. open grafana at `localhost:3002`
4. To monitor incoming request, create new visualization with these settings:

![screenshot](/misc/screenshot-grafana.png)
