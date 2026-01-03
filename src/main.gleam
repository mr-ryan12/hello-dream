import dream/servers/mist/server.{bind, listen, router, services}
import router.{create_router}
import services.{initialize_services}

pub fn main() {
  server.new()
  |> services(initialize_services())
  |> router(create_router())
  |> bind("localhost")
  |> listen(3000)
}
