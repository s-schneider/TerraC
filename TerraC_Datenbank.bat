rem TO RUN ON PRODUCTION MODE
rem STRING = bundle exec rake secret 
SECRET_KEY_BASE="STRING"


set PATH=c:\windows\system32;c:\windows
set PATH=%PATH%;c:\Ruby23-x64\bin
set PATH=%PATH%;c:\Programme\MySQL\MySQL Server 5.7\bin
set SECRET_KEY_BASE
ruby -e 'p ENV["SECRET_KEY_BASE"]'

cd c:\terrac
rails server -b 0.0.0.0 -p 8080 -e production





