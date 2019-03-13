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
    NB. w=. > 1 } sdselect '' NB. Returns result;read;write;error
    w=. > 1 } sdselect sock;sock;sock;0 NB. Returns result;read;write;error

    if. #w do.
      smoutput w
      sa=. > 1 } ; sdaccept w

      while. #sa do. NB. Need to detect when client disconnects
        input=. > 1 } sdrecv sa, 1024, 0
        input sdsend sa, 0
        NB. sdclose sa NB. Byebye
        smoutput 'I am in the loop still...'
      end.
    end.
  end.
  i.0 0
)

exit 0
