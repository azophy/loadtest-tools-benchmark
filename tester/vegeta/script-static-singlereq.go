package main

import (
  "fmt"
  "time"

  vegeta "github.com/tsenart/vegeta/v12/lib"
)

func main() {
  rate := vegeta.Rate{Freq: 0, Per: time.Second}
  duration := 60 * time.Second
  targeter := vegeta.NewStaticTargeter(vegeta.Target{
    Method: "GET",
    URL:    "http://target:3000/test/vegeta/static-singlereq-script",
  })
  attacker := vegeta.NewAttacker(vegeta.MaxWorkers(8))

  var metrics vegeta.Metrics
  for res := range attacker.Attack(targeter, rate, duration, "Big Bang!") {
    metrics.Add(res)
  }
  metrics.Close()

  fmt.Printf("99th percentile: %s\n", metrics.Latencies.P99)
}
