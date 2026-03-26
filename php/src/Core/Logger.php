<?php

namespace Volley5544\PhpProject\Core;

class Logger
{
    protected static string $logFile = __DIR__ . '/../../storage/logs/app.log';

    public static function info(
        string $message,
        array $metaData = [],
        array $data = []
    ) {
        self::write("INFO", $message, $metaData, $data);
    }

    public static function error(
        string $message,
        array $metaData = [],
        array $data = []
    ) {
        self::write("ERROR", $message, $metaData, $data);
    }

    protected static function write(
        string $level,
        string $message,
        array $metaData = [],
        array $data = []
    ) {
        $log = [
            "timestamp" => date("Ymd\TH:i:sP"), // ISO8601 with timezone
            "message" => $message,
            "level" => $level,
            "trace_id" => self::generateTraceId(),
            "service" => "users-api",
            "meta_data" => (object)$metaData,
            "data" => (object)$data,
        ];

        file_put_contents(
            self::$logFile,
            json_encode($log, JSON_UNESCAPED_UNICODE) . PHP_EOL,
            FILE_APPEND
        );
    }

    protected static function generateTraceId(): string
    {
        return bin2hex(random_bytes(8)) . ',' . bin2hex(random_bytes(8));
    }
}