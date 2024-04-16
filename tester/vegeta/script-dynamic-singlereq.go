package main

import (
  vegeta "github.com/tsenart/vegeta/v12/lib"
)

func main() {
  targeter := func(id uint64) vegeta.Targeter {
      return func(t *vegeta.Target) (err error) {
          t.Method = "POST"
          t.URL    = "http://target:3000/test/vegeta/dynamic-singlereq?q=" + RandomString(5)

          return nil
      }
  }(0)

  RunScenario(targeter)
}
