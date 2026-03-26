package Controllers

import "project/src/Core"

type UserController struct{}

func (u *UserController) Index() interface{} {
	Core.Info("User list requested")

	users := []map[string]interface{}{
		{"id": 1, "name": "John"},
		{"id": 2, "name": "Jane"},
		{"id": 3, "name": "Mike"},
	}

	return map[string]interface{}{
		"status": "success",
		"data":   users,
	}
}
