package main

import (
  "os"
  "fmt"
  "time"
  "unsafe"
  "strconv"
  "crypto/rand"

  vegeta "github.com/tsenart/vegeta/v12/lib"
)

var alphabet = []byte("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

func RunScenario(targeter vegeta.Targeter) {
  durationEnv,_ := strconv.Atoi(os.Getenv("DEFAULT_DURATION"))
  numThread,_ := strconv.ParseUint(os.Getenv("NUM_THREAD"), 10, 64)

  rate := vegeta.Rate{Freq: 0, Per: time.Second}
  duration := time.Duration(durationEnv) * time.Second
  attacker := vegeta.NewAttacker(vegeta.MaxWorkers(numThread))

  var metrics vegeta.Metrics
  for res := range attacker.Attack(targeter, rate, duration, "test-vegeta") {
    metrics.Add(res)
  }
  metrics.Close()

  fmt.Printf("99th percentile: %s\n", metrics.Latencies.P99)
}

// taken from https://stackoverflow.com/a/64270538/2496217
func RandomString(size int) string {
    b := make([]byte, size)
    rand.Read(b)
    for i := 0; i < size; i++ {
        b[i] = alphabet[b[i] % byte(len(alphabet))]
    }
    return *(*string)(unsafe.Pointer(&b))
}
