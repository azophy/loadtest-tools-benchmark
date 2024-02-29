package main

import (
	"errors"
	"github.com/labstack/echo-contrib/echoprometheus"
	"github.com/labstack/echo/v4"
	"log"
	"net/http"
  "io/ioutil"
)

func main() {
	e := echo.New()
  e.Use(echoprometheus.NewMiddlewareWithConfig(echoprometheus.MiddlewareConfig{
		// labels of default metrics can be modified or added with `LabelFuncs` function
		LabelFuncs: map[string]echoprometheus.LabelValueFunc{
			"test_tool": func(c echo.Context, err error) string { // additional custom label
        toolName := c.Param("tool")
				return toolName
			},
		},
	})) // adds middleware to gather metrics
	e.GET("/metrics", echoprometheus.NewHandler()) // adds route to serve gathered metrics

  e.GET("/test/:tool", func(c echo.Context) error {
		return c.String(http.StatusOK, "ok")
	})

  e.POST("/test/:tool", func(c echo.Context) error {
		body, err := ioutil.ReadAll(c.Request().Body)
    if err != nil {
        return err
    }

    return c.String(http.StatusOK, string(body))
	})

	if err := e.Start(":3000"); err != nil && !errors.Is(err, http.ErrServerClosed) {
		log.Fatal(err)
	}
}
