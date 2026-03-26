package routes

import (
	"project/src/Controllers"
)

type Route struct {
	Controller interface{}
	Method     func(interface{}) interface{}
}

var Routes = map[string]Route{
	"/": {
		Controller: &Controllers.UserController{},
		Method: func(c interface{}) interface{} {
			return c.(*Controllers.UserController).Index()
		},
	},
	"/home": {
		Controller: &Controllers.HomeController{},
		Method: func(c interface{}) interface{} {
			return c.(*Controllers.HomeController).Index()
		},
	},
	"/api/users": {
		Controller: &Controllers.UserController{},
		Method: func(c interface{}) interface{} {
			return c.(*Controllers.UserController).Index()
		},
	},
}
