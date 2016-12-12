#!/usr/bin/expect -f
set pass [lrange $argv 0 0]
set server [lrange $argv 1 1]
set name [lrange $argv 2 2]
set filename [lrange $argv 3 3]

spawn sftp $name@$server
match_max 100000
expect "*?assword:*"
send -- "$pass\r"
send -- "\r"
expect "sftp>"
send -- "put $filename\r"
send -- "\r"
expect "sftp>"
send -- "quit\r"
