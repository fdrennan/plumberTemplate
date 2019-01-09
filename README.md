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

/etc/nginx/conf.d
```
upstream myproject {
    server ranalytics.medianewsgroup.com:8000;
    server ranalytics.medianewsgroup.com:8001;
    server ranalytics.medianewsgroup.com:8002;
    server ranalytics.medianewsgroup.com:8003;
    server ranalytics.medianewsgroup.com:8004;
    server ranalytics.medianewsgroup.com:8005;
    server ranalytics.medianewsgroup.com:8006;
    server ranalytics.medianewsgroup.com:8007;
    server ranalytics.medianewsgroup.com:8008;
    server ranalytics.medianewsgroup.com:8009;
    server ranalytics.medianewsgroup.com:8010;
 }

  server {
    listen 80;
    server_name ranalytics.medianewsgroup.com;
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
