NB. http://www.jsoftware.com/help/learning/contents.htm
NB. http://rosettacode.org/wiki/Sockets#J
NB. http://rosettacode.org/wiki/Loops/While#J
NB. http://www.jsoftware.com/help/jforc/error_messages.htm

coinsert'jsocket' [ require 'socket'             NB.  Sockets library
socket =.  > {. sdcheck sdsocket''                 NB.  Open a socket
host =. sdcheck sdgethostbyname 'localhost'    NB.  Resolve host
sdcheck sdconnect socket ; host ,< 6379          NB.  Create connection to port 6379 (redis)
NB. smoutput sdcheck 'keys *' sdsend socket , 0               NB.  Send msg (list redis keys)

t=.'test'
smoutput 'beg'
monad define xxx
  while. #t do.
    smoutput 'yea'
    smoutput t
    t=.(>sdcheck sdconnect socket ; host ,< 6379)}.t
  end.
  i.0 0
)

monad define xy
  while. #t do. t=.(>sdcheck sdconnect socket ; host ,< 6379)}.t end.
i.0 0
)

NB. Output 1024 and halve it each time.
smoutput ,. <.@-:^:*^:a: 1024

NB. Same deal, with a working while loop
monad define 1024
  while. 0 < y do.
    smoutput y
    y =. <. -: y
  end.
  i.0 0
)

exit 0
