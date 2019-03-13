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
    NB. smoutput 'yea'
    NB. smoutput t
    NB. t=.(>sdcheck sdconnect socket ; host ,< 6379)}.t
    NB. pull in all the ready to read sockets
    NB. rt=. sdselect sock, sock, sock, 10e3
    rt=. sdselect '' NB. Returns result;read;write;error
    w=. > 1 } rt
    r=. > 1 } rt

    NB. # is tally

    NB. if. #r > 0 do.
      NB. smoutput 'Someone wants to send us a message'
      NB. sr=. >1};sdaccept r
      NB. read=.>1}sdrecv accepts, 1024, 0
      NB. smoutput 'We think we read something'
      NB. smoutput read
    NB. end.

    if. #w > 0 do.
      smoutput 'Selected socket ready to work on'
      smoutput w
      NB. Result is result code and new socket
      NB. sa=. > 1 } sdaccept t
      sa=. > 1 } ; sdaccept w
      NB. smoutput raw
      NB. smoutput 0 { sa
      NB. smoutput > 1 { sa
      NB. smoutput 2 { sa
      input=. > 1 } sdrecv sa, 1024, 0
      smoutput input
      NB. sent=. 'hi' sdsend sa , 0
      sent=. input sdsend sa, 0
      smoutput 'Sent some text'
      smoutput sent
      sdclose sa
    end.
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
