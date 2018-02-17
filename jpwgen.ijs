NB. Get time and date
time=: >. +/(6!:0 '')

NB. Set random seed to current time.
(9!:1) time

NB. Get list of ascii charset
ascii=:1 2 3 { 8 32 $ a.

NB. Generate a random password
pwgen=:(? (32 $ ($,ascii))) { ,ascii

smoutput pwgen
exit 0
