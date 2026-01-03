import dream/context.{type EmptyContext}
import dream/http.{type Request, type Response, ok, text_response}
import dream/http/request.{Get}
import dream/router.{type EmptyServices, route, router as create_router}
import dream/servers/mist/server.{bind, listen, router}

fn index(
  _request: Request,
  _context: EmptyContext,
  _services: EmptyServices,
) -> Response {
  text_response(ok, "Hello, World!")
}

pub fn main() {
  let app_router =
    create_router()
    |> route(method: Get, path: "/", controller: index, middleware: [])

  server.new()
  |> router(app_router)
  |> bind("localhost")
  |> listen(3000)
}
