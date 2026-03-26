using Csharp.Core;

namespace Csharp.Controllers;

public class UserController
{
    public object Index()
    {
        Logger.Info("User list requested");

        var users = new[]
        {
            new { id = 1, name = "John" },
            new { id = 2, name = "Jane" },
            new { id = 3, name = "Mike" }
        };

        return new
        {
            status = "success",
            data = users
        };
    }
}