# total CPU usage
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU: "100 - $1"%"}'

# top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%cpu | head -6 | awk 'NR>1{print "    "$3}'

# total memory usage
# NR        current record number in the total input stream.
free -m | awk 'NR==2{printf "Memory: %.2f%% (%s/%sMB)\n", $3*100/$2,$2,$3 }'

# top 5 processes by memory usage
echo "Top 5 processes by memory usage:"
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%mem | head -6 | awk 'NR>1{print "    "$3}'

# total disk usage
# NF        number of fields in the current record.
df -h | awk '$NF=="/"{printf "Disk: %s (%d/%dGB)\n", $5,$3,$2}'

# (opt) os version
lsb_release -a | awk -F':' 'NR==2{gsub(/^[ \t]+/,"",$2);print "OS: "$2}'

# (opt) uptime
uptime -p
#uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print "Uptime:",d+0,"days,",h+0,"hours,",m+0,"minutes."}'

# (opt) load average
# TODO
#uptime | awk -F'(:)+' 'OFS="\n"{for (i=1;i<=NF;i++)print $i}'

# (opt) logged in users
# (opt) failed login attempts
