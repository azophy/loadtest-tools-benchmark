package main

import (
  "unsafe"
  "net/http"
  "crypto/rand"

  "github.com/alecthomas/kingpin"
	"github.com/vearutop/plt/curl"
	"github.com/vearutop/plt/loadgen"
	"github.com/vearutop/plt/nethttp"
)

var alphabet = []byte("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

// taken from https://stackoverflow.com/a/64270538/2496217
func RandomString(size int) string {
    b := make([]byte, size)
    rand.Read(b)
    for i := 0; i < size; i++ {
        b[i] = alphabet[b[i] % byte(len(alphabet))]
    }
    return *(*string)(unsafe.Pointer(&b))
}

func RunScenario(prepareRequest func(int, *http.Request) error) {
	lf := loadgen.Flags{}
	lf.Register()

	curl.AddCommand(&lf, func(lf *loadgen.Flags, f *nethttp.Flags, j loadgen.JobProducer) {
		if nj, ok := j.(*nethttp.JobProducer); ok {
			nj.PrepareRequest = prepareRequest
    }
	})

  kingpin.Parse()
}

func main() {
  availableMethods := []string{ "GET", "POST" }

  isDynamic := kingpin.Flag("dynamic", "is the request dynamic/static").Bool()
  isMultireq := kingpin.Flag("multireq", "is calling multiple requests").Bool()

  RunScenario(func(i int, req *http.Request) error {
    k := i % 2
    if (*isMultireq) {
      req.Method = availableMethods[k]
    }
    if (*isDynamic) {
      req.URL.RawQuery = "q=" + RandomString(5)
    }

    return nil
  })
}
