PID=$(pidof asterisk)
UpTime=$(ps -p $PID -o etime=)

echo $UpTime
