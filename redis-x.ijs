NB. http://www.jsoftware.com/help/jforc/
NB. http://www.jsoftware.com/help/learning/contents.htm
NB. http://rosettacode.org/wiki/Sockets#J
NB. http://rosettacode.org/wiki/Loops/While#J
NB. http://www.jsoftware.com/help/jforc/error_messages.htm

coinsert'jsocket' [ require 'socket'             NB.  Sockets library

smoutput 'beg'

monad define ''
  smoutput 'my monad'
  smoutput y NB. Magical variable defined to the input.
  smoutput 'all done'
)

NB. See also: pacman.ijs
monad define ''
  NB. socket =.  >{.sdcheck sdsocket''                 NB.  Open a socket
  socket =.  >0{sdcheck sdsocket''                 NB.  Open a socket
  host   =. sdcheck sdgethostbyname 'localhost'    NB.  Resolve host

  NB. server =. 0 pick sdcheck sdaccept socket 0
  sdcheck sdconnect socket ; host ,< 6379          NB.  Create connection to port 6379 (redis)
  NB. sdcheck sdconnect socket ; host ,< 12345          NB.  Create connection to port 6379 (redis)
  NB. sdlisten socket
  NB. sdbind SKLISTEN;AF_INET_jsocket_;y;50111
  NB. SKSERVER=:0 pick sdcheck sdaccept SKLISTEN
  NB. server =. 0 pick sdcheck sdaccept sdcheck sdsocket''
  NB. redis=:(>sdcheck 'keys *' sdsend socket , 0)               NB.  Send msg (list redis keys)
  NB. redis=:(>sdcheck 'GET d4ce6bedc5a6c11ceb6e8d8eb07464b1a502c788' sdsend socket , 0) NB.  Send msg
  NB. smoutput redis

  'rc sent'=. ('GET ', 'dog') sdsend socket ; 0

  smoutput 'Sent stuff'
  smoutput rc
  smoutput sent

  NB. Looks like an opcode
  srecv=: 3 : 0

  NB. Re-enable to check for timeout
  NB. server =. >0{sdaccept sdlisten socket
  z=. sdselect socket;'';'';10000 NB. ms
  assert socket e.>1{z NB. Timeout exception throw

  NB. It'll pause/block here, until we receive something.
  'c r'=. sdrecv socket,4026,0

  smoutput 'C and R'
  smoutput c
  smoutput r
  smoutput 'All good'
  NB. We know we get 9 bytes if we send out 'fido'
  assert 9=c
  assert 9~:#r
  smoutput 9{.r
  exit 0

try.
  while. ((0=rc)*.(*#m)) [[ 'rc m'=. sdrecv server,4096 do.
  NB. while. ((0=rc)*.(*#m)) [[ 'rc m'=. sdrecv_jsocket_ socket,4096 do.
    smoutput 'In loop'
    pp=. pp,m
    smoutput pp
  end.

  smoutput 'Socket time'
  d=. y

  smoutput 'No timeout'
  'c r'=. sdrecv socket, 10, 0
  smoutput 'recv'
  smoutput 'c r'
  assert 0=c
  assert 0~:#r
  d=. d,r

  smoutput d
  smoutput 'Got past the sdrecv'

  NB. cl=. 0
  NB. while. (0=#h)+.cl>#d do. NB. Read until we have all data
  NB.   smoutput 'Receive time'
  NB.   h=. (sdrecv socket, redis, 0)
  NB.   smoutput h
  NB. end.

  NB. h;d
catch.
  smoutput 'Timeout error most likely'
  exit 1
end.
)

NB. while. #t do. t=.(>sdcheck sdconnect socket ; host ,< 6379)}.t end.

exit 0
