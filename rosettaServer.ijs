NB. Run with: ~/jbld/j64/bin/jconsole ~/src/j-scripts/echoServer.ijs

NB. Lets implement according to the spec here
NB. http://rosettacode.org/wiki/Echo_server

NB. Sit on 12321
NB. Take multiple connections and respond to echo more
NB. than one per.

coinsert'jsocket' [ require 'socket'             NB.  Sockets library

NB. Set up a listener
sock=: > 0 { sdcheck sdsocket AF_INET, SOCK_STREAM, 0
sdbind sock; AF_INET; ''; 12321
sdlisten sock, 5

NB. DO block basically
monad define ''
  while. 1 = 1 do.
    w=. > 1 } sdselect '' NB. Returns result;read;write;error

    if. #w > 0 do.
    smoutput w
      sa=. > 1 } ; sdaccept w
      input=. > 1 } sdrecv sa, 1024, 0
      input sdsend sa, 0
      NB. sdclose sa NB. Byebye
    end.
  end.
  i.0 0
)

exit 0
