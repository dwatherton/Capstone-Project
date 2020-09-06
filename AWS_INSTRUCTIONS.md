### Deployment to AWS (EC2 Terminal Commands)
* `git clone https://github.com/MinorJinx/Capstone-Project.git`
* `cd Capstone-Project/`
* `sudo apt-get install mariadb-server`
* `sudo mysql_secure_installation` <- Set a root password and follow the prompts detailed here: https://mariadb.com/kb/en/mysql_secure_installation/


* `sudo mysql -u root -p` <- Create the "ew_db" database and "ew_admin" user defined in settings.py
* `CREATE DATABASE ew_db;`
* `SHOW DATABASES;`
* `CREATE USER ew_admin@localhost IDENTIFIED BY 'UALRcapstone2019!';`
* `SELECT user FROM mysql.user;`
* ``GRANT ALL PRIVILEGES ON `ew_db`.* TO 'ew_admin'@localhost;``
* `FLUSH PRIVILEGES;`
* `SHOW GRANTS FOR 'ew_admin'@localhost;`


* `mysql ew_db < ew_db_backup.sql` <- Exit MariaDB console and restore the ew_db database default backup
* `python3 -m venv venv`
* `source venv/bin/activate`
* `pip3 install -r requirements.txt`
* `python3 manage.py makemigrations`
* `python3 manage.py migrate`
* `python3 manage.py migrate --run-syncdb`
* `python3 manage.py createsuperuser` <- Create a Django-admin for logging in and populating the database (manually)
* `Username: Django-admin`
* `Email address: WebBlockheads@gmail.com`
* `Password: UALRcapstone2019!` 
* `python3 manage.py runserver 0.0.0.0:8000`
* `deactivate` <- Exits the virtualenv
 

### Run the project from AWS EC2 Instance
1. Make sure you are in the Capstone-Project/ directory.
2. Type `source venv/bin/activate` into the terminal.
2. Type `python3 manage.py runserver 0.0.0.0:8000` into the terminal.
3. Visit the URL: [ualrcapstone.ddns.net:8000](http://ualrcapstone.ddns.net:8000/) ~~OR use the dynamic AWS EC2 public IP [http://18.191.146.137:8000/](http://18.191.146.137:8000/).~~

### Update the project code for presentation
1. Make sure you are in the Capstone-Project/ directory.
2. Type `git fetch origin && git merge origin/master` into the terminal.

### To Leave Project Running After Terminal Closes
1. Make sure you are in the Capstone-Project/ directory.
2. Type `screen -l` to open up a "screen" instance or install: `sudo apt-get install screen`
3. Inside the screen Type `source venv/bin/activate && python3 manage.py runserver 0.0.0.0:8000 | screen -d` to run the server and detach the process (prevent it from dying on exit)!
4. Type `exit` or close the terminal, and check [ualrcapstone.ddns.net:8000](http://ualrcapstone.ddns.net:8000/)

### To Kill A Previously Detached Screen
1. Make sure you are in the Capstone-Project/ directory.
2. Type `screen -list` to view the active, detached, screens.
3. Type `screen -X -S <PROCESS_ID_TO_KILL> quit` .

### To View All Running Proccess
1. Type `top`, or `pstree`

### To Update The Dynamic DNS (IP)
1. Download the Dynamic Update Client from No-IP: https://my.noip.com/#!/dynamic-dns/duc
2. Configure and run: `/usr/local/bin/noip2`
* `sudo chmod 777 /usr/local/etc/no-ip2.conf` <- Set permissions for all users
* `sudo chmod 777 /usr/local/bin/noip2`
* `noip2 -S` <- Shows status of clients
* `crontab -e` followed by `@reboot sudo /usr/local/bin/noip2` <- Will start on reboot