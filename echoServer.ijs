NB. Run with: ~/jbld/j64/bin/jconsole ~/src/j-scripts/echoServer.ijs
NB. http://www.jsoftware.com/learning/socket_programming.htm

coinsert'jsocket' [ require 'socket'             NB.  Sockets library

NB. Set up a listener
sock=: > 0 { sdcheck sdsocket AF_INET, SOCK_STREAM, 0
bound=: sdbind sock; AF_INET; ''; 12345
listened=: sdlisten sock, 5

NB. DO block basically
monad define ''
  while. 1 = 1 do.
    rt=. sdselect '' NB. Returns result;read;write;error
    w=. > 1 } rt

    if. #w > 0 do.
      sa=. > 1 } ; sdaccept w
      input=. > 1 } sdrecv sa, 1024, 0 NB. TODO Read until nothing more to read
      smoutput 'Got some user input: '
      smoutput input
      sent=. input sdsend sa, 0
      sdclose sa NB. Byebye
    end.
  end.
  i.0 0
)

exit 0
