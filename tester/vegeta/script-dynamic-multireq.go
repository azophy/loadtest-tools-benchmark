package main

import (
  "sync/atomic"

  vegeta "github.com/tsenart/vegeta/v12/lib"
)

func main() {
  targeter := func(id uint64) vegeta.Targeter {
      i := int64(-1)
      methods := [2]string{ "GET", "POST"}

      return func(t *vegeta.Target) (err error) {
          // iterate all of the defined methods
          // adapted from https://github.com/tsenart/vegeta/blob/9c95632b3e8562be6df690c639a3f5a6f40d3004/lib/targets.go#L212
          t.Method = methods[atomic.AddInt64(&i, 1)%2]
          t.URL    = "http://target:3000/test/vegeta/dynamic-multireq?q=" + RandomString(5)

          return nil
      }
  }(0)

  RunScenario(targeter)
}
