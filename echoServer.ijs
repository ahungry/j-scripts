NB. Run with: ~/jbld/j64/bin/jconsole ~/src/j-scripts/echoServer.ijs
NB. http://www.jsoftware.com/learning/socket_programming.htm

coinsert'jsocket' [ require 'socket'             NB.  Sockets library

NB. Set up a listener
sock=: > 0 { sdcheck sdsocket AF_INET, SOCK_STREAM, 0
sdbind sock; AF_INET; ''; 12345
sdlisten sock, 5

NB. DO block basically
monad define ''
  while. 1 = 1 do.
    w=. > 1 } sdselect '' NB. Returns result;read;write;error

    if. #w > 0 do.
      sa=. > 1 } ; sdaccept w
      input=. > 1 } sdrecv sa, 1024, 0
      input sdsend sa, 0
      sdclose sa NB. Byebye
    end.
  end.
  i.0 0
)

exit 0
