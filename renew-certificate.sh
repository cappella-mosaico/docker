docker-compose stop
sudo certbot certonly --nginx

sudo cp /etc/letsencrypt/live/admin.ipmosaico.com/fullchain.pem ~/certs/www.ipmosaico.com.pem
sudo cp /etc/letsencrypt/live/admin.ipmosaico.com/privkey.pem ~/certs/www.ipmosaico.com.key
