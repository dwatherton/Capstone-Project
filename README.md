# Capstone-Project
A repository containing the UALR BSCS Final Project. Team members: Daniel Atherton, Griffin Kim, Jeremy Reynolds, Shane Champion.

To get started with this project in PyCharm, follow the simple, step-by-step, instructions below:

1. Open PyCharm and select "Check out from Version Control" > "Git"
![Checkout from Git](https://imgur.com/jimrhgs.png)

2. Enter the Project Repository URL (green), a Project Directory name (yellow), and hit "Clone" (red)
![Clone Project](https://imgur.com/KzMgvDK.png)

3. Click "Yes" to open the Project Directory in the PyCharm IDE
![Open as a Project](https://imgur.com/0q77GFW.png)

4. When the IDE finishes opening, open the built-in terminal
![Open Terminal](https://imgur.com/CZIaEXd.png)
 
5. Install/Update python3 (Django Projects use Python, so it's a must)
You can get it from Homebrew (Mac OS):  type `brew install python3` in the built-in terminal
OR
You can get python3 from https://www.python.org/downloads/

6. Create a virtual environment for the project
In the built-in terminal type `python3 -m venv venv`

7. Activate the virtual environment for the Django project
![Activate Venv](https://imgur.com/Bl6095E.png)

8. Install requirements for the project from 'requirements.txt' `pip3 install -r requirements.txt`
![Install Requirements](https://imgur.com/5GWpXhw.png)

9. In Step 8, mysql-client was installed automatically, but we must manually install and setup MySQL Server
Follow the guide at http://www.marinamele.com/taskbuster-django-tutorial/install-and-configure-mysql-for-django (ONLY DO THE 'Install MySQL' and 'Create a MySQL Database' STEPS!). Use the following values as already defined in our 'settings.py' file:
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'ew_db',
        'USER': 'ew_admin',
        'PASSWORD': 'ualrcapstone19',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```
* Note: If you choose to use different values for your mysql user and database, you MUST change the code above in the settings.py file!

10. With the MySQL User and Database created, you can simply migrate the changes
![Migrate Changes](https://imgur.com/jsjCmeJ.png)

11. Now that the project and database are ready, create a Django superuser
![Create Superuser](https://imgur.com/UeAuRxN.png)
* Note: The Superuser that you create should not make a difference for the rest of us (to my knowledge), it just grants you access to logging in via the url: `http://127.0.0.1:8000/admin/` where you can modify items in the database.

##### You should now be able to run the project with the command `python3 manage.py runserver`, then click the link to view the site, but the site will look rather boring.

The reason the site looks so boring is because of the fact that the content loaded in to the editor comes from the database, so without any entries in the database, the site is empty. To fix this, go to `http://127.0.0.1:8000/admin/` and log in. Once you are logged in, click `Pages` under the EASY_WEB heading and click `ADD PAGE`. Fill in the fields and click `Save`
![Add Test Page](https://imgur.com/jy0OZuU.png)

Once the new page has been saved, click `VIEW SITE` to see what the Easy Web Content Editor truly looks like!
![View Site](https://imgur.com/tm87e3E.png)

The Easy Web Editor should look like this (assuming you entered the same content into the database fields)
![Easy Web Editor](https://imgur.com/boPUvcO.png)

That covers everything for getting started with this project! Please expirement with the content editor buttons to get a deeper understanding of what the Easy Web Content Editor is capable of!
