import dream/context.{type EmptyContext}
import dream/http.{require_int, type Request, type Response, json_response, ok, created, validate_json, internal_server_error, not_found}
import dream/http/error.{NotFound}
import gleam/result
import models/user.{create as create_user, list, get, decoder}
import services.{type Services}
import views/user_view.{to_json, list_to_json}

pub fn index(
  _request: Request,
  _context: EmptyContext,
  services: Services,
) -> Response {
  let result = {
    let db = services.db
    list(db)
  }
  
  case result {
    Ok(users) -> json_response(ok, list_to_json(users))
    Error(_) -> json_response(internal_server_error, "{\"error\": \"Internal server error\"}")
  }
}

pub fn show(
  request: Request,
  _context: EmptyContext,
  services: Services,
) -> Response {
  let result = {
    use id <- result.try(require_int(request, "id"))
    let db = services.db
    get(db, id)
  }
  
  case result {
    Ok(user_data) -> json_response(ok, to_json(user_data))
    Error(NotFound(_)) -> json_response(not_found, "{\"error\": \"User not found\"}")
    Error(_) -> json_response(internal_server_error, "{\"error\": \"Internal server error\"}")
  }
}

pub fn create(
  request: Request,
  _context: EmptyContext,
  services: Services,
) -> Response {
  case validate_json(request.body, decoder()) {
    Ok(data) -> {
      let #(name, email) = data
      let db = services.db
      case create_user(db, name, email) {
        Ok(user_data) -> json_response(created, to_json(user_data))
        Error(_) -> json_response(internal_server_error, "{\"error\": \"Failed to create user\"}")
      }
    }
    Error(_) -> json_response(internal_server_error, "{\"error\": \"Invalid JSON data\"}")
  }
}