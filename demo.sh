rm -rf errlog
mkdir errlog
docker build . -t mariacrash
docker rm mariademo
docker run --name=mariademo -p 3306:3306 -d mariacrash
echo "Waiting MariaDB to start"
sleep 3
docker exec -ti mariademo sh -c "mysql < crash.sql"
docker exec -ti mariademo sh -c "cat /var/lib/mysql/*err"
docker exec -ti mariademo sh -c "ls -la /var/lib/mysql/"
docker exec -ti mariademo sh -c "tar -czf /crash.tar.gz /var/lib/mysql/core /var/lib/mysql/*err"
 
docker cp mariademo:/crash.tar.gz ./errlog/.
