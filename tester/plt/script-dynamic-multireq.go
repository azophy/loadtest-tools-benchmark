package main

import (
	//"strconv"
  "net/url"
	"net/http"

	"github.com/vearutop/plt/curl"
	"github.com/vearutop/plt/loadgen"
	"github.com/vearutop/plt/nethttp"
)

var AvailableMethods = []string{ "GET", "POST" }

func main() {
	lf := loadgen.Flags{}
	lf.Register()

	curl.AddCommand(&lf, func(lf *loadgen.Flags, f *nethttp.Flags, j loadgen.JobProducer) {
		if nj, ok := j.(*nethttp.JobProducer); ok {
			nj.PrepareRequest = func(i int, req *http.Request) error {
        k := i % 2
        req.Method = AvailableMethods[k]
				req.URL,_ = url.Parse("http://target:3000/test/vegeta/dynamic-multireq")
        req.URL.RawQuery = "q=" + RandomString(5)

				return nil
			}
		}
	})
}
