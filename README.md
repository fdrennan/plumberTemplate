```
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
sudo apt-get install git-core
sudo apt-get install default-jdk
sudo apt-get install libgdal-dev libproj-dev
sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev --y
sudo R CMD javareconf
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ubuntu
su - ubuntu
id -nG
```


```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install r-base -y
sudo apt-get install gdebi-core -y
wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb
sudo gdebi rstudio-server-1.1.463-amd64.deb 
wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb
sudo gdebi shiny-server-1.5.9.923-amd64.deb 
```


```
adduser fdrennan
usermod -aG docker fdrennan
usermod -aG sudo fdrennan
```

```
git config --global user.name "Freddy Drennan"
git config --global user.email "drennanfreddy@gmail.com"
```


```
ssh-keygen -t rsa
cd /home/fdrennan/.ssh/id_rsa.pub
git@github.com:fdrennan/plumberTemplate.git
```

```
docker build -t dockerfile .
docker run --rm -d -p 8000:8000 -v `pwd`/plumber.R:/plumber.R dockerfile /plumber.R
```

```
sudo apt  install docker-compose
```

Use filename below
/etc/nginx/conf.d/nginx.conf
```
upstream myproject {
    server 18.220.132.82:8000;
    server 18.220.132.82:8001;
    server 18.220.132.82:8002;
    server 18.220.132.82:8003;
    server 18.220.132.82:8004;
    server 18.220.132.82:8005;
    server 18.220.132.82:8006;
    server 18.220.132.82:8007;
    server 18.220.132.82:8008;
    server 18.220.132.82:8009;
    server 18.220.132.82:8010;
 }

  server {
    listen 80;
    server_name 18.220.132.82;
    location / {
      proxy_pass http://myproject;
    }
  }

```
as root
/etc/init.d/nginx start
```
apt-get install nginx
```

```
docker-container up -d
```

18.220.132.82:8000/pdf


```
siege -c 10 -r 10 -b 18.220.132.82/meggan
```

```
Transactions:		       19099 hits
Availability:		       95.49 %
Elapsed time:		       83.25 secs
Data transferred:	       30.98 MB
Response time:		        0.36 secs
Transaction rate:	      229.42 trans/sec
Throughput:		        0.37 MB/sec
Concurrency:		       81.99
Successful transactions:       19099
Failed transactions:	         901
Longest transaction:	        7.62
Shortest transaction:	        0.09
 ```
 
```
 Transactions:		       19339 hits
Availability:		       96.69 %
Elapsed time:		       80.16 secs
Data transferred:	       31.37 MB
Response time:		        0.46 secs
Transaction rate:	      241.25 trans/sec
Throughput:		        0.39 MB/sec
Concurrency:		      110.47
Successful transactions:       19339
Failed transactions:	         661
Longest transaction:	        7.26
Shortest transaction:	        0.09
```


