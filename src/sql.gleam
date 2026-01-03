//// This module contains the code to run the sql queries defined in
//// `./src/sql`.
//// > 🐿️ This module was generated automatically using v4.6.0 of
//// > the [squirrel package](https://github.com/giacomocavalieri/squirrel).
////

import gleam/dynamic/decode
import gleam/option.{type Option}
import gleam/time/timestamp.{type Timestamp}
import pog

/// A row you get from running the `create_user` query
/// defined in `./src/sql/create_user.sql`.
///
/// > 🐿️ This type definition was generated automatically using v4.6.0 of the
/// > [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub type CreateUserRow {
  CreateUserRow(
    id: Int,
    name: String,
    email: String,
    created_at: Option(Timestamp),
  )
}

/// name: create_user
///
/// > 🐿️ This function was generated automatically using v4.6.0 of
/// > the [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub fn create_user(
  db: pog.Connection,
  arg_1: String,
  arg_2: String,
) -> Result(pog.Returned(CreateUserRow), pog.QueryError) {
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use email <- decode.field(2, decode.string)
    use created_at <- decode.field(3, decode.optional(pog.timestamp_decoder()))
    decode.success(CreateUserRow(id:, name:, email:, created_at:))
  }

  "-- name: create_user
INSERT INTO users (name, email)
VALUES ($1, $2)
RETURNING id, name, email, created_at;"
  |> pog.query
  |> pog.parameter(pog.text(arg_1))
  |> pog.parameter(pog.text(arg_2))
  |> pog.returning(decoder)
  |> pog.execute(db)
}

/// A row you get from running the `get_user` query
/// defined in `./src/sql/get_user.sql`.
///
/// > 🐿️ This type definition was generated automatically using v4.6.0 of the
/// > [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub type GetUserRow {
  GetUserRow(
    id: Int,
    name: String,
    email: String,
    created_at: Option(Timestamp),
  )
}

/// name: get_user
///
/// > 🐿️ This function was generated automatically using v4.6.0 of
/// > the [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub fn get_user(
  db: pog.Connection,
  arg_1: Int,
) -> Result(pog.Returned(GetUserRow), pog.QueryError) {
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use email <- decode.field(2, decode.string)
    use created_at <- decode.field(3, decode.optional(pog.timestamp_decoder()))
    decode.success(GetUserRow(id:, name:, email:, created_at:))
  }

  "-- name: get_user
SELECT id, name, email, created_at
FROM users
WHERE id = $1;"
  |> pog.query
  |> pog.parameter(pog.int(arg_1))
  |> pog.returning(decoder)
  |> pog.execute(db)
}

/// A row you get from running the `list_users` query
/// defined in `./src/sql/list_users.sql`.
///
/// > 🐿️ This type definition was generated automatically using v4.6.0 of the
/// > [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub type ListUsersRow {
  ListUsersRow(
    id: Int,
    name: String,
    email: String,
    created_at: Option(Timestamp),
  )
}

/// name: list_users
///
/// > 🐿️ This function was generated automatically using v4.6.0 of
/// > the [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub fn list_users(
  db: pog.Connection,
) -> Result(pog.Returned(ListUsersRow), pog.QueryError) {
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use email <- decode.field(2, decode.string)
    use created_at <- decode.field(3, decode.optional(pog.timestamp_decoder()))
    decode.success(ListUsersRow(id:, name:, email:, created_at:))
  }

  "-- name: list_users
SELECT id, name, email, created_at
FROM users
ORDER BY created_at DESC;"
  |> pog.query
  |> pog.returning(decoder)
  |> pog.execute(db)
}
