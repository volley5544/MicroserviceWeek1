using Csharp.Controllers;

namespace Csharp.routes;

public static class Web
{
    public static Dictionary<string, (object controller, System.Reflection.MethodInfo method)> Routes =
        new()
        {
            { "/", (new UserController(), typeof(UserController).GetMethod("Index")!) },
            { "/home", (new HomeController(), typeof(HomeController).GetMethod("Index")!) },
            { "/api/users", (new UserController(), typeof(UserController).GetMethod("Index")!) },
        };
}