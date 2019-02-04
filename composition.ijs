NB. Compose some simple math things.
add1=:1&+
add2=:2&+
add3=add1&add2

sum=: +/
square=: *:
double=: *&2

NB. http://www.jsoftware.com/help/learning/03.htm
sum square 1 2 3 NB. 14
sumsq=: sum @: square

NB. Fahrenheit to Celsius (subtract 32 and multiply by 5/9ths)
s=: - & 32
m=: * & (5%9)
convert=: m@:s
convert 212

conv=:(* & (5%9)) @: (- & 32) NB. 212 -> 100

NB. Calculating an order total
P=: 2 3   NB. Prices
Q=: 1 100 NB. quantities
total=: sum @: * NB. Dyadic composition - multiply quantity by price, then sum them.
P total Q NB. 302 (sum (2 3 * 1 100)) -> (sum 2 300)

NB. Get the min of a set
min=: {./:~;

NB. Get the max of a set
max=: {.\:~;

NB. Take first 20 vals in a range to 100
taketwenty=: 20{. i.100
