## Automating tests

```sh
curl -X POST -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$TOKEN'' \
    -d '{"name":"benchmark-loadtest-16cpu",
        "size":"c-8-16GiB",
        "region":"sfo3",
        "image":"docker-20-04"}' \
    "https://api.digitalocean.com/v2/droplets"

doctl compute droplet create \
    --image docker-20-04 \
    --size c-8-16GiB \
    --region sfo3 \
    benchmark-loadtest-16cpu

ssh -i ~/.ssh/private_key root@IP_ADDRESS

> git clone https://github.com/azophy/loadtest-tools-benchmark.git
> cd loadtest-tools-benchmark
> docker compose pull
> docker compose build
> docker compose up -d
> # wait until setup complete
> sleep 180
> docker compose down
> docker compose up -d
> # wait until setup complete
> sleep 180
> # prepare & makesure grafana is ready, then execute
> docker compose exec tester ./tester/script-static-singlereq.sh
```

## dashboarding
grafana dashbaord for comparisons:
- ID 13946 -> detailed on cpu & mem, less on network
- ID 193 -> less detailed on CPU & mem, clearer on network

`irate()` is more suitable then `rate()` for high-volatile counter: 
- https://valyala.medium.com/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832
- https://community.grafana.com/t/rate-and-irate-display-very-different-values/6590
