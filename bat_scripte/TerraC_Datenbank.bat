
set PATH=c:\windows\system32;c:\windows
set PATH=%PATH%;c:\Ruby23-x64\bin
set PATH=%PATH%;c:\Programme\MySQL\MySQL Server 5.7\bin
set SSL_CERT_FILE="C:\users\Vaubel\cacert.pem"

start /B "Starting Database"

cd c:\terrac\tmp\pids
del server.pid
cd c:\terrac
rails server -b 0.0.0.0 -p 80