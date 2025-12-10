import types/user.{type User, User}
import sql
import gleam/list.{map}
import gleam/option.{unwrap}
import gleam/time/timestamp.{system_time}
import gleam/dynamic/decode.{type Decoder, field, string, success}
import pog.{type Connection, type Returned}

import dream/http/error.{type Error, NotFound, InternalServerError}

pub fn list(db: Connection) -> Result(List(User), Error) {
  case sql.list_users(db) {
    Ok(returned) -> Ok(map(returned.rows, list_row_to_user))
    Error(_) -> Error(InternalServerError("Database error"))
  }
}

pub fn get(db: Connection, id: Int) -> Result(User, Error) {
  case sql.get_user(db, id) {
    Ok(returned) -> extract_first_user(returned)
    Error(_) -> Error(InternalServerError("Database error"))
  }
}

pub fn create(
  db: Connection,
  name: String,
  email: String,
) -> Result(User, Error) {
  case sql.create_user(db, name, email) {
    Ok(returned) -> extract_first_created_user(returned)
    Error(_) -> Error(InternalServerError("Database error"))
  }
}

pub fn decoder() -> Decoder(#(String, String)) {
  use name <- field("name", string)
  use email <- field("email", string)
  success(#(name, email))
}

fn extract_first_user(
  returned: Returned(sql.GetUserRow),
) -> Result(User, Error) {
  case returned.rows {
    [row] -> Ok(row_to_user(row))
    [] -> Error(NotFound("User not found"))
    _ -> Error(NotFound("User not found"))
  }
}

fn extract_first_created_user(
  returned: Returned(sql.CreateUserRow),
) -> Result(User, Error) {
  case returned.rows {
    [row] -> Ok(create_row_to_user(row))
    [] -> Error(InternalServerError("Failed to create user"))
    _ -> Error(InternalServerError("Failed to create user"))
  }
}

fn list_row_to_user(row: sql.ListUsersRow) -> User {
  User(
    id: row.id,
    name: row.name,
    email: row.email,
    created_at: unwrap(row.created_at, system_time()),
  )
}

fn row_to_user(row: sql.GetUserRow) -> User {
  User(
    id: row.id,
    name: row.name,
    email: row.email,
    created_at: unwrap(row.created_at, system_time()),
  )
}

fn create_row_to_user(row: sql.CreateUserRow) -> User {
  User(
    id: row.id,
    name: row.name,
    email: row.email,
    created_at: unwrap(row.created_at, system_time()),
  )
}