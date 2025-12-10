import gleam/erlang/process.{new_name}
import gleam/option.{Some}
import gleam/otp/actor.{Started}
import pog.{type Connection, default_config, host, port, database, user, password, pool_size, start}

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