import gleam/json
import gleam/list.{map}
import types/user.{type User}

pub fn to_json(user: User) -> String {
  user_to_json_object(user)
  |> json.to_string()
}

pub fn list_to_json(users: List(User)) -> String {
  map(users, user_to_json_object)
  |> json.array(from: _, of: identity)
  |> json.to_string()
}

fn user_to_json_object(user: User) -> json.Json {
  json.object([
    #("id", json.int(user.id)),
    #("name", json.string(user.name)),
    #("email", json.string(user.email)),
  ])
}

fn identity(x: a) -> a {
  x
}
