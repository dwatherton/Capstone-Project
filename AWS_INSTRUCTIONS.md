### Deployment to AWS (EC2 Terminal Commands)
* `git clone http://www.github.com/dwatherton/Capstone-Project.git`
* `cd Capstone-Project/`
* `python3 -m venv venv`
* `source venv/bin/activate`
* `pip3 install django`
* `pip3 install -r requirements.txt`
* `mysql -u root -p` <- Create the "ew_db" database and "ew_admin" user defined in settings.py
* `python3 manage.py makemigrations`
* `python3 manage.py migrate`
* `python3 manage.py migrate --run-syncdb`
* `python3 manage.py createsuperuser` <- Create a Django-admin for logging in and populating the database (manually)
* `python3 manage.py runserver 0.0.0.0:8000`

### Run the project from AWS EC2 Instance
1. Make sure you are in the Capstone-Project/ directory.
2. Type `source venv/bin/activate` into the terminal.
2. Type `python3 manage.py runserver 0.0.0.0:8000` into the terminal.
3. Visit the URL: [ualrcapstone.ddns.net](http://ualrcapstone.ddns.net:8000/) OR use the dynamic AWS EC2 public IP [http://18.191.146.137:8000/](http://18.191.146.137:8000/).

### Update the project code for presentation
1. Make sure you are in the Capstone-Project/ directory.
2. Type `git fetch origin && git merge origin/master` into the terminal.
