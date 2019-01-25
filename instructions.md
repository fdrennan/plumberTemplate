
Building the dockerfile:
sudo docker build -t dockerfile .

Running Plumber:
sudo docker run --rm -p 8000:8000 -v `pwd`/plumber.R:/plumber.R dockerfile /plumber.R

List containers:
docker container ls

Stop Container:
docker stop fc8f265f279bfc8f265f279b


Destroy Everything
```
!/bin/bash
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
```


nginx.conf:
```

ns  4096;  ## Default: 1024
}

http {
        default_type application/octet-stream;
        sendfile     on;
        tcp_nopush   on;
        server_names_hash_bucket_size 128; # this seems to be required for some vhosts

        server {
                listen 80 default_server;
                listen [::]:80 default_server ipv6only=on;

                root /usr/share/nginx/html;
                index index.html index.htm;

                18.217.102.18 MYSERVER.ORG

                location /app1/ {
                        proxy_pass http://app1:8000/;
                        proxy_set_header Host $host;
                }

                location /app2/ {
                        proxy_pass http://app2:8000/;
                        proxy_set_header Host $host;
                }


                location ~ /\.ht {
                        deny all;
                }
        }
}ievents {
  worker_connections  4096;  ## Default: 1024
}

http {
        default_type application/octet-stream;
        sendfile     on;
        tcp_nopush   on;
        server_names_hash_bucket_size 128; # this seems to be required for some vhosts

        server {
                listen 80 default_server;
                listen [::]:80 default_server ipv6only=on;

                root /usr/share/nginx/html;
                index index.html index.htm;

                server_name MYSERVER.ORG

                location /app1/ {
                        proxy_pass http://app1:8000/;
                        proxy_set_header Host $host;
                }

                location /app2/ {
                        proxy_pass http://app2:8000/;
                        proxy_set_header Host $host;
                }


                location ~ /\.ht {
                        deny all;
                }
        }
}

```

docker-compose.yaml:
```
version: '2'
services:
  app2:
    image: fdrennan/plumber
    command: /app/plumber.R
    volumes:
     - .:/app
    restart: always
    ports:
     - "8000:8000"
  app3:
    image: fdrennan/plumber
    command: /app/plumber.R
    volumes:
     - .:/app
    restart: always
    ports:
     - "8001:8000"
```