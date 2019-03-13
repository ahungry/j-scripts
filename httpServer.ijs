NB. Run with: ~/jbld/j64/bin/jconsole ~/src/j-scripts/httpServer.ijs 6379
NB. http://www.jsoftware.com/learning/socket_programming.htm

coinsert'jsocket' [ require 'socket'             NB.  Sockets library

hex=: 16bffffffff NB. 4294967295

sock=: > 0 { sdcheck sdsocket AF_INET, SOCK_STREAM, 0
bound=: sdbind sock; AF_INET; ''; 12345
listened=: sdlisten sock, 5

NB. Same deal, with a working while loop
monad define 1024
  while. 0 < y do.
    smoutput y
    NB. floor halve y
    y =. <. -: y
  end.
  i.0 0
)

monad define ''
  while. 1 = 1 do.
    smoutput 'yea'
    smoutput t
    NB. t=.(>sdcheck sdconnect socket ; host ,< 6379)}.t
    NB. pull in all the ready to read sockets
    t=. > 0 } sdselect ''
    smoutput t
    accepts=. > 0 } sdaccept t
    smoutput accepts
    'hi' sdsend accepts , 0
  end.
  i.0 0
)

exit 0
NB. This would get the boxed format return_code;socket_number
NB. socket=: sdsocket AF_INET, SOCK_STREAM, 0

NB. This would also get the boxed format return_code;socket_number, but check return code
NB. > (monadic open) 0 (slot) { (dyadic take from) sdsocket (ret/num)
socket=: > 0 { sdsocket AF_INET, SOCK_STREAM, 0

NB. read list; write list; error list; timeout
NB. readysocks=: sdselect socket;socket;socket;10e3

NB. Or, without any args, get boxed args of all
readysocks=: sdselect ''

NB. By default, all sockets will block, unless you use something like this:
NB. sdasync socket

NB. which will then process events via the definition in socket_handler
NB. socket_handler '' NB. This would be the call - but how do I define it??
NB. socket_handler=: 3

NB. All this is translated from main.c in five-minute-microservice repo to listen
NB. sock=: > 0 { sdcheck sdsocket AF_UNSPEC, SOCK_STREAM, 0
sock=: > 0 { sdcheck sdsocket AF_INET, SOCK_STREAM, 0

NB. http://www.jsoftware.com/docs/help602/user/script_socket.htm#sdbind
NB. https://code.jsoftware.com/wiki/Guides/Sockets
sdbind sock 0.0.0.0


exit 0
