using System.Text.Json;

namespace Csharp.Core;

public static class Logger
{
    private static readonly string LogFile = Path.Combine(
        Directory.GetCurrentDirectory(),
        "storage",
        "logs",
        "app.log"
    );

    public static void Info(string message, Dictionary<string, object>? meta = null, Dictionary<string, object>? data = null)
    {
        Write("INFO", message, meta, data);
    }

    public static void Error(string message, Dictionary<string, object>? meta = null, Dictionary<string, object>? data = null)
    {
        Write("ERROR", message, meta, data);
    }

    private static void Write(string level, string message, Dictionary<string, object>? meta, Dictionary<string, object>? data)
    {
        var log = new
        {
            timestamp = DateTime.Now.ToString("yyyyMMddTHH:mm:sszzz"),
            message,
            level,
            trace_id = GenerateTraceId(),
            service = "users-api",
            meta_data = meta ?? new Dictionary<string, object>(),
            data = data ?? new Dictionary<string, object>(),
        };

        var json = JsonSerializer.Serialize(log);

        Directory.CreateDirectory(Path.GetDirectoryName(LogFile)!);

        File.AppendAllText(LogFile, json + Environment.NewLine);
    }

    private static string GenerateTraceId()
    {
        return $"{Guid.NewGuid():N},{Guid.NewGuid():N}";
    }
}