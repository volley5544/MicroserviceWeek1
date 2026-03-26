source ./core/logger.sh

user_index() {
  log_info "User list requested"

  echo '{
    "status": "success",
    "data": [
      {"id":1,"name":"John"},
      {"id":2,"name":"Jane"},
      {"id":3,"name":"Mike"}
    ]
  }'
}