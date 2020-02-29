path=/etc/apache2/apache2.conf
sudo apt-get update -y

sudo apt-get install apache2 -y

sudo ufw allow 80
echo "add domain name"
read domain
sudo mkdir -p /var/www/html/$domain
echo  "<html><body><h1>HELLO......!!!! This is MIT....!!!! </h1></body></html>" > /var/www/html/$domain/index.html
sudo chown -Rf www-data:www-data /var/www/html/$domain
sudo chmod -Rf 775 /var/www/html/$domain
echo "<VirtualHost *:80>
        ServerAdmin $domain
        ServerName www.$domain
        DirectoryIndex index.php index.html
        DocumentRoot /var/www/html/$domain
</VirtualHost>" > /etc/apache2/sites-available/$domain.conf

sed -i '175 a\
        <Directory /var/www/html/server.com>\
        Options Indexes MultiViews FollowSymLinks\
        DirectoryIndex index.php index.html\
        AllowOverride all\
        Allow From all\
        </Directory>' $path
sed -i 's/server.com/'$domain/g $path
a2ensite $domain.conf
apache2ctl configtest

systemctl restart apache2

sudo apt-get install mysql -y
sudo apt-get install php -y
sudo apt-get install phpmyadmin -y
sudo cp /etc/phpmyadmin/apache2.conf /etc/apache2/conf-avilable/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf
sudo systemctl restart apache2

1. ADDITION OF subdomain
2. Intialize LAMP

1. Create a script, which backs up mysql every day and pushes to another server via FTP/SFTP/SCP
2. Create a script, which takes files one by one from /var/www/abc and uploads in the database.

  /var/www/abc   
     a.sql  insert into table values (2,3)
	 b.sql 
	 
a.sql -> /var/www/done/
