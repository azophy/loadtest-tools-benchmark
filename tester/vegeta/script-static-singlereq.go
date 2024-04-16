package main

import (
  vegeta "github.com/tsenart/vegeta/v12/lib"
)

func main() {
  targeter := vegeta.NewStaticTargeter(vegeta.Target{
    Method: "GET",
    URL:    "http://target:3000/test/vegeta/static-singlereq",
  })

  RunScenario(targeter)
}
