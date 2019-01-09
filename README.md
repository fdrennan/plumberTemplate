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

