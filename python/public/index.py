
print("LOADED INDEX FILE")
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse, PlainTextResponse
from routes.web import routes
from src.Core.Logger import Logger

app = FastAPI()
print("APP CREATED")

def normalize_path(path: str):
    return path.rstrip("/") or "/"

@app.api_route("/{full_path:path}", methods=["GET", "POST", "PUT", "DELETE"])
async def handle_request(request: Request, full_path: str):
    uri = normalize_path("/" + full_path)

    try:
        if uri in routes:
            Controller, method = routes[uri]

            controller = Controller()
            response = getattr(controller, method)()

            if isinstance(response, str):
                return PlainTextResponse(content=response)

            return JSONResponse(content=response)

        else:
            Logger.error(f"Route not found: {uri}")

            return JSONResponse(
                status_code=404,
                content={
                    "status": "error",
                    "message": "Not Found"
                }
            )

    except Exception as e:
        Logger.error(str(e))

        return JSONResponse(
            status_code=500,
            content={
                "status": "error",
                "message": "Server Error"
            }
        )