@test "awscli is installed and reports its version" {
  run /usr/local/bin/aws --version
  [ "$status" -eq 0 ]
  [[ "$output" = aws-cli/* ]]
}
