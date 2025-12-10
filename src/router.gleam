import dream/http/request.{Get, Post}
import dream/router.{type Router, route, router}
import dream/context.{type EmptyContext}
import controllers/users_controller.{index, show, create}
import services.{type Services}

pub fn create_router() -> Router(EmptyContext, Services) {
  router()
  |> route(method: Get, path: "/users", controller: index, middleware: [])
  |> route(method: Get, path: "/users/:id", controller: show, middleware: [])
  |> route(method: Post, path: "/users", controller: create, middleware: [])
}