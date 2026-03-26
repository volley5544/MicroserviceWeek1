package Controllers

type HomeController struct{}

func (h *HomeController) Index() string {
	return "Hello from HomeController"
}
