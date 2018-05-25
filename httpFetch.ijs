coinsert'jsocket' [ require 'socket'             NB.  Sockets library

PORT=: > 2 } ARGV NB. Extract that arg and unbox it

monad define ''
  socket=.  >0{sdcheck sdsocket''               NB.  Open a socket
  NB. host=. sdcheck sdgethostbyname 'localhost'    NB.  Resolve host
  host=. sdcheck sdgethostbyname 'example.com'    NB.  Resolve host

  if. PORT-:'12345' do.
    sdconnect socket ; host ,< 12345
  else.
    sdconnect socket ; host ,< 80       NB.  Create connection to port 6379 (redis)
    smoutput 'Redis'
  end.

  NB. sdcheck sdconnect socket ; host ,< 12345
  NB. 'rc sent'=. ('GET ', 'dog') sdsend socket ; 0
  f=.'/'
  'rc sent'=. ('GET ',f,' HTTP/1.1',LF,'Host: example.com',LF2) sdsend socket ; 0
  smoutput ('GET ',f,' HTTP/1.1',LF,'Host: example.com',LF2)

  smoutput 'Sent stuff'
  smoutput rc
  smoutput sent

  pp=.''

  while. ((0=rc)*.(*#m)) [[ 'rc m'=. sdrecv socket,4096 do.
    pp=. pp,m
    smoutput pp
    if. (0=rc) do. break. end.
  end.

  smoutput 'fin'

  exit 0

  NB. Re-enable to check for timeout
  z=. sdselect socket;'';'';10000 NB. ms
  assert socket e.>1{z NB. Timeout exception throw

  NB. It'll pause/block here, until we receive something.
  'c r'=. sdrecv socket,4026,0

  smoutput 'C and R'
  smoutput c
  smoutput r
  NB. We know we get 9 bytes if we send out 'fido'
  assert 9=c
  assert 9~:#r
  smoutput 9{.r
  exit 0
)
