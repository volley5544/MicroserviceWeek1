#!/bin/bash

PORT=8080
echo "Server running on port $PORT"

while true; do
  ncat -l -p $PORT --exec "bash -c '
    source ./core/logger.sh

    read request
    path=\$(echo \"\$request\" | cut -d \" \" -f2)

    if [ \"\$path\" == \"/\" ]; then
      log_info \"Root endpoint hit\"
      body=\"{\\\"message\\\":\\\"Hello from Bash\\\"}\"

    elif [ \"\$path\" == \"/home\" ]; then
      log_info \"Home endpoint hit\"
      body=\"Hello from HomeController\"

    elif [ \"\$path\" == \"/api/users\" ]; then
      log_info \"User list requested\"
      body=\"{\\\"status\\\":\\\"success\\\",\\\"data\\\":[{\\\"id\\\":1,\\\"name\\\":\\\"John\\\"}]}\"

    else
      log_error \"Route not found: \$path\"
      body=\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"Not Found\\\"}\"
    fi

    printf \"HTTP/1.1 200 OK\r\n\"
    printf \"Content-Type: application/json\r\n\"
    printf \"Content-Length: %s\r\n\" \"\${#body}\"
    printf \"Connection: close\r\n\"
    printf \"\r\n\"
    printf \"%s\" \"\$body\"
  '"
done