import gleam/erlang/process.{new_name}
import gleam/option.{Some}
import gleam/otp/actor.{Started}
import pog.{
  type Connection, database, default_config, host, password, pool_size, port,
  start, user,
}

pub type Services {
  Services(db: Connection)
}

pub fn initialize_services() -> Services {
  let pool_name = new_name("db_pool")

  let config =
    default_config(pool_name: pool_name)
    |> host("localhost")
    |> port(5432)
    |> database("gleam_local")
    |> user("postgres")
    |> password(Some("postgres"))
    |> pool_size(10)

  let assert Ok(Started(_pid, connection)) = start(config)

  Services(db: connection)
}
