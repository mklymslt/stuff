# Basic while loop used to scale out monitor instances on a server
counter=10
while [ $counter -le 40 ]
do
tmsh create gtm monitor external sni$counter { defaults-from external destination *:* interval 5 probe-timeout 5 run /Common/snimon timeout 16 user-defined HOSTNAME app$counter.f5labs.com user-defined HTTPSTATUS 200 user-defined RECEIVESTRING APP$counter }

tmsh modify gtm server centos virtual-servers add { app$counter { destination 10.1.10.5:443 monitor sni$counter }

((counter++))
done
echo All done