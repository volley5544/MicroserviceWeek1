import json
import os
import secrets
from datetime import datetime, timezone, timedelta

class Logger:
    log_file = os.path.join(os.path.dirname(__file__), "../../storage/logs/app.log")

    @staticmethod
    def info(message, meta_data=None, data=None):
        Logger.write("INFO", message, meta_data or {}, data or {})

    @staticmethod
    def error(message, meta_data=None, data=None):
        Logger.write("ERROR", message, meta_data or {}, data or {})

    @staticmethod
    def write(level, message, meta_data, data):
        log = {
            "timestamp": Logger.timestamp(),
            "message": message,
            "level": level,
            "trace_id": Logger.trace_id(),
            "service": "users-api",
            "meta_data": meta_data,
            "data": data,
        }

        with open(Logger.log_file, "a", encoding="utf-8") as f:
            f.write(json.dumps(log, ensure_ascii=False) + "\n")

    @staticmethod
    def trace_id():
        return f"{secrets.token_hex(8)},{secrets.token_hex(8)}"

    @staticmethod
    def timestamp():
        now = datetime.now().astimezone()
        return now.strftime("%Y%m%dT%H:%M:%S%z")[:-2] + ":" + now.strftime("%Y%m%dT%H:%M:%S%z")[-2:]