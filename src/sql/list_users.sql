-- name: list_users
SELECT id, name, email, created_at
FROM users
ORDER BY created_at DESC;
