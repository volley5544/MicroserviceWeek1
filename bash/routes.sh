#!/bin/bash

source ./controllers/home.sh
source ./controllers/user.sh

handle_route() {
  case "$1" in
    "/")
      user_index
      ;;
    "/home")
      home_index
      ;;
    "/api/users")
      user_index
      ;;
    *)
      log_error "Route not found: $1"
      echo '{"status":"error","message":"Not Found"}'
      ;;
  esac
}