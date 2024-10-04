env | grep DEFAULT_TERMINAL | awk '{ gsub("=", " "); print $2 }' | sh
