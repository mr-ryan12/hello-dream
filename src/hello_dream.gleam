import dream/context.{type EmptyContext}
import dream/http.{type Request, type Response, json_response, ok, text_response}
import dream/http/request.{Get}
import dream/router.{type EmptyServices, route, router as create_router}
import dream/servers/mist/server.{bind, listen, router}
import gleam/json

fn index(
  _request: Request,
  _context: EmptyContext,
  _services: EmptyServices,
) -> Response {
  text_response(ok, "Hello, World!")
}

fn testing_things(
  _request: Request,
  _context: EmptyContext,
  _services: EmptyServices,
) -> Response {
  let mock_data =
    json.object([
      #("name", json.string("John")),
      #("age", json.int(30_000_000)),
      #("city", json.string("New York")),
    ])
  json_response(200, json.to_string(mock_data))
}

pub fn main() {
  let app_router =
    create_router()
    |> route(method: Get, path: "/", controller: index, middleware: [])
    |> route(
      method: Get,
      path: "/test",
      controller: testing_things,
      middleware: [],
    )

  server.new()
  |> router(app_router)
  |> bind("localhost")
  |> listen(3000)
}
