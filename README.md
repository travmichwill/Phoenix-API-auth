# Phoenix API Auth
This application is to demonstrate user creation, session validation, and restricting API access from a central location.

- [x] Session Expiration Timeouts (30 Minutes)
- [x] Configurable Session Timeouts (Plug Configuration)
- [ ] Auto-Renew session if still valid
- [ ] Rate Limit Authentication API

### Create Users:
```
Type: POST
URL: 127.0.0.1:4000/api/user
Header: Content-Type: application/json
Body: {"email": "testemail@gmail.com", "username": "testuser", "password": "Password123"}
```

### Create User Response:
```json
{
  "username": "testuser",
  "user_id": "7933906c-338f-47b0-a158-b77de6482176",
  "email": "testemail@gmail.com"
}
```

### Start Session:
```
Type: POST
URL: 127.0.0.1:4000/api/session
Header: Content-Type: application/json
Body: {"username": "testuser", "password": "Password123"}
```
### Start Session Response:
```json
{
  "token": "usbBFw78IGnHacYHjRUfWA"
}
```
### Validate Session:
```
Type: GET
URL: 127.0.0.1:4000/api/user/7933906c-338f-47b0-a158-b77de6482176
Header: Authorization: usbBFw78IGnHacYHjRUfWA
```

### Validate Response:
```json
{
  "username": "testuser",
  "user_id": "7933906c-338f-47b0-a158-b77de6482176",
  "email": "testemail@gmail.com"
}
```
