using System.Text.Json;
using Csharp.routes;
using Csharp.Core;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

string NormalizePath(string path)
{
    return path.TrimEnd('/') == "" ? "/" : path.TrimEnd('/');
}

app.Map("{*path}", async (HttpContext context) =>
{
    var routes = Web.Routes;

    var uri = NormalizePath(context.Request.Path.ToString());

    context.Response.ContentType = "application/json";

    try
    {
        if (routes.ContainsKey(uri))
        {
            var (controller, method) = routes[uri];

            var result = method.Invoke(controller, null);

            if (result is string str)
            {
                await context.Response.WriteAsync(str);
            }
            else
            {
                await context.Response.WriteAsync(
                    JsonSerializer.Serialize(result)
                );
            }
        }
        else
        {
            context.Response.StatusCode = 404;

            Logger.Error($"Route not found: {uri}");

            await context.Response.WriteAsync(JsonSerializer.Serialize(new
            {
                status = "error",
                message = "Not Found"
            }));
        }
    }
    catch (Exception ex)
    {
        context.Response.StatusCode = 500;

        Logger.Error(ex.Message);

        await context.Response.WriteAsync(JsonSerializer.Serialize(new
        {
            status = "error",
            message = "Server Error"
        }));
    }
});

app.Run();