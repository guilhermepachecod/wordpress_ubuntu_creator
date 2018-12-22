#!/bin/bash
#Direitos autorais Acertotec.
#Desevolvido pelo Clube da Tecnologia.
#dev        :Guilherme Pacheco
#criado     :03/01/2017

#editado por: Guilherme Pacheco	
#editado    : 01/08/2018

#Scrip para preparação do servidor com Wordpress
#O script ira instalar e configurar o 
#MYSQL, PHP5, APACHE2, WORDPRESS, PROFTPD

##ZANs1tsd5(aOnQLq7
#atualiza o servidor e instala os serviços
sudo dpkg --configure -a
sudo apt -f install


sudo apt-get upgrade -y

sudo apt-get update -y
sudo apt-get install wordpress -y
sudo apt-get install mysql-server-5.7 -y

sudo gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress localhost

sudo ln -s /etc/wordpress/config-localhost.php /etc/wordpress/config-default.php

sudo apt-get install proftpd -y

wget https://github.com/guilhermepachecod/wordpress_ubuntu_creator/proftpd.conf
wget https://github.com/guilhermepachecod/wordpress_ubuntu_creator/wp-config.php.txt

sudo mv proftpd.conf /etc/proftpd/proftpd.conf

sudo service proftpd restart


sudo mkdir /var/www/html/userftp
sudo cp -R /usr/share/wordpress /var/www/html/userftp/
sudo mv wp-config.php.txt /var/www/html/userftp/wordpress/wp-config.php

sudo groupadd -g 2121 ftpgroup

#Adiciona o usuario do ftp wordpress

sudo useradd userftp -p $(perl -e 'print crypt($ARGV[0], "password")' mypassword) -d /var/www/html/userftp -s /bin/false -g 2121 -M

sudo chown -R userftp /var/www/html/userftp
sudo chmod -R 0755 /var/www/html/userftp/

sudo shutdown -r 00
